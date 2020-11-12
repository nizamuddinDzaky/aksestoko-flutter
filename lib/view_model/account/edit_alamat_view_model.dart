import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/zone.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/edit_alamat_screen.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class EditAlamatViewModel extends State<EditAlamatScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // dynamic vm;
  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var postalCodeTextController = TextEditingController();
  bool complete = null;
  Address address;
  final List<Zone> province = [];
  final List<Zone> village = [];
  final List<Zone> district = [];
  final List<Zone> subDistrict = [];
  Zone selectVillage;
  Zone selectProvince;
  Zone selectSubDistrict;
  Zone selectDistrict;
  String tokenRajaApi;

  reInitText() {
    nameTextController.text = address?.namaPenerima;
    emailTextController.text = address?.email;
    phoneTextController.text = address?.noTlpn;
    addressTextController.text = address?.alamat;
    postalCodeTextController.text = address?.kodePos;
  }

  void _getAddress() async {
    var params = {
      'id_address': widget.address?.addressId ?? '',
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailAddress,
      params: params,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        if (data == null) return;
        if (data['data'] == null) return;
        if (data['data']['detail_address'] == null) return;
        address = Address.fromJson(data['data']['detail_address']);
        debugPrint("no Telpon say :${data['data']['detail_address']['no_tlp']}");
        reInitText();
        _getTokenRajaApi();
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  setZona(Zone data, int step, {bool isFirstLoad = false}) async {
    if(!isFirstLoad){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[CircularProgressIndicator()],
              ),
            );
          });
    }

    if (step == 1) {
      selectProvince = data;
      if(selectProvince.name.toLowerCase() != address.provinsi.toLowerCase()){
        selectDistrict = null;
        selectSubDistrict = null;
        selectVillage = null;
      }
        getKabupaten(data.id.toString(), isFirstLoad: isFirstLoad);
    } else if (step == 2) {
      selectDistrict = data;
      if(getKabupatenName(selectDistrict.name) != getKabupatenName(address.kabupaten)){
        selectSubDistrict = null;
        selectVillage = null;
      }
      getKecamatan(data.id.toString(), isFirstLoad: isFirstLoad);
    } else if (step == 3) {
      selectSubDistrict = data;
      if(selectSubDistrict.name.toLowerCase() != address.kecamatan.toLowerCase()){
        selectVillage = null;
      }
      getDesa(data.id.toString(), isFirstLoad: isFirstLoad);
    }
  }

  _getTokenRajaApi() async{

    var status = await ApiClient.methodGet(
      ApiConfig.urlTokenRajaApi,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        tokenRajaApi = data['token'];
        getProvinsi();
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  void getProvinsi() async {
    var status = await ApiClient.methodGet(
      "${ApiConfig.urlRajaAPi}/MeP7c5ne$tokenRajaApi/${ApiConfig.urlGetProvinsiRajaApi}",
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        /*if(address.provinsi == null){

        }*/
        var selected;
        var listData = data['data'];
        if (listData is List) {
          listData.forEach((item) {
            var zone = Zone.fromJson(item);
            province.add(zone);
            if(address.provinsi != null){
              if(zone.name.toLowerCase() == address.provinsi.toLowerCase()){
                selected = zone;
              }
            }
          });
          if(selected != null){
            setZona(selected, 1, isFirstLoad: true);
          }else{
            complete = true;
          }

        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  void getKabupaten(String idProvinsi, {bool isFirstLoad = false}) async {
    district.clear();
    var params = {
      'idpropinsi': idProvinsi,
    };
    var status = await ApiClient.methodGet(
      "${ApiConfig.urlRajaAPi}/MeP7c5ne$tokenRajaApi/${ApiConfig.urlGetKabupatenRajaApi}",
      params: params,
      customHandle: true,
      onBefore: (status) {

      },
      onSuccess: (data, flag) {
        var listData = data['data'];

        if(!isFirstLoad){
          Get.back();
        }
        var selected;
        if (listData is List) {
          listData.forEach((item) {
            var zone = Zone.fromJson(item);
            district.add(zone);
            if(address.kabupaten != null){
              if(getKabupatenName(zone.name) == getKabupatenName(address.kabupaten)){
                /**/
                selected = zone;
              }
            }
          });
          if(selected != null){
            setZona(selected, 2, isFirstLoad: true);
          }else{
            complete = true;
          }
        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
    );
    setState(() {
      status.execute();
    });
  }

  void getKecamatan(String idKabupaten, {bool isFirstLoad = false}) async {
    subDistrict.clear();
    var params = {
      'idkabupaten': idKabupaten,
    };
    var status = await ApiClient.methodGet(
      "${ApiConfig.urlRajaAPi}/MeP7c5ne$tokenRajaApi/${ApiConfig.urlGetKecamatanRajaApi}",
      params: params,
      customHandle: true,
      onBefore: (status) {
        /*Get.back();*/
      },
      onSuccess: (data, flag) {
        debugPrint("kecamatan sayang : ${address.kecamatan}");
        /*if(address.kecamatan == null){
          complete = true;
        }*/
        var listData = data['data'];
        if(!isFirstLoad){
          Get.back();
        }
        var selected;
        if (listData is List) {
          listData.forEach((item) {
            var zone = Zone.fromJson(item);
            subDistrict.add(zone);
            if(address.kecamatan != null){
              if(zone.name.toLowerCase().trim() == address.kecamatan.toLowerCase().trim()){
                selected = zone;
                /**/
              }
            }
          });
          if(selected != null){
            setZona(selected, 3, isFirstLoad: true);
          }else{
            complete = true;
          }
        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
    );
    setState(() {
      status.execute();
    });
  }

  void getDesa(String idKecamatan, {bool isFirstLoad = false}) async {
    village.clear();
    var params = {
      "idkecamatan": idKecamatan,
    };

    var status = await ApiClient.methodGet(
      "${ApiConfig.urlRajaAPi}/MeP7c5ne$tokenRajaApi/${ApiConfig.urlGetDesaRajaApi}}",
      params: params,
      customHandle: true,
      onBefore: (status) {
        /*Get.back();*/
        if(!isFirstLoad){
          Get.back();
        }
      },
      onSuccess: (data, flag) {
        complete = true;

        var listData = data['data'];
        var selected;
        if (listData is List) {
          listData.forEach((map) {
            var zone = Zone.fromJson(map);
            village.add(zone);
            if(address.desa != null){
              if(zone.name.toLowerCase().trim() == address.desa.toLowerCase().trim()){
                selected = zone;
              }
            }
          });
          if(selected != null){
            selectVillage = selected;
          }
        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
    );
    setState(() {
      status.execute();
    });
  }

  saveForm({
    namaPenerima,
    email,
    noTlpn,
    alamat,
    provinceName,
    provinceId,
    kabupatenName,
    kabupatenId,
    kecamatanName,
    kecamatanId,
    addressId,
    kodePos,
  }) {
    address = address ?? Address();
    address.namaPenerima = namaPenerima ?? address.namaPenerima;
    address.email = email ?? address.email;
    address.noTlpn = noTlpn ?? address.noTlpn;
    address.alamat = alamat ?? address.alamat;
    address.kodePos = kodePos ?? address.kodePos;
  }

  actionSubmit(BuildContext context) async {
    // if (formKey.currentState.validate()) {
    formKey.currentState.save();
    // } else {
    //   return;
    // }
    var addressData = [
      address.namaPenerima,
      address.email,
      address.noTlpn,
      address.alamat,
      address.kodePos
    ];
    if (addressData.where((element) => element.isNotEmpty).toList().length !=
        addressData.length) {
      Fluttertoast.showToast(
        msg: 'Mohon lengkapi data alamat toko',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if ([selectProvince, selectDistrict, selectSubDistrict, selectVillage]
            .where((element) => element != null)
            .toList()
            .length !=
        4) {
      Fluttertoast.showToast(
        msg: 'Mohon lengkapi data wilayah',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CircularProgressIndicator()],
            ),
          );
        });
    var body = {
      'address_id': widget.address.addressId,
      'nama': address.namaPenerima,
      'email': address.email,
      'no_tlp': address.noTlpn,
      'alamat': address.alamat,
      'kode_pos': address.kodePos,
      'provinsi': selectProvince.name,
      'kabupaten': selectDistrict.name,
      'kecamatan': selectSubDistrict.name,
      'desa': selectVillage.name,
      // 'provinsi': address.provinceName,
      // 'kabupaten': address.kabupatenName,
      // 'kecamatan': address.kecamatanName,
    };
    debugPrint('action api address $body');
    _putUpdateAddress(body);
  }

  _putUpdateAddress(body) async {
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateAddress,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: 'Ubah alamat sukses',
          gravity: ToastGravity.CENTER,
        );
        Get.back(result: -1);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {

    reInitText();
    /*reZona();*/
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _getAddress();
    });
  }
}
