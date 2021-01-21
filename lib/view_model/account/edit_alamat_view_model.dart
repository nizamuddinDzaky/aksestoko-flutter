import 'package:aksestokomobile/main_common.dart';
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
  final List<Zone> postalCodes = [];
  final List<Address> listAddress = [];

  Zone selectVillage;
  Zone selectProvince;
  Zone selectSubDistrict;
  Zone selectDistrict;
  Zone selectPostalCode;
  String tokenRajaApi;

  reInitText() {
    nameTextController.text = address?.namaPenerima;
    emailTextController.text = address?.email;
    phoneTextController.text = address?.noTlpn;
    addressTextController.text = address?.alamat;
    postalCodeTextController.text = address?.kodePos;
  }

  getRegionByPostalCode() async {
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

    var params = {
      'postal_code': postalCodeTextController.text,
    };
    var status = await ApiClient.methodGet(
        "${ApiConfig.urlPostalCode}",
        params: params,
        customHandle: true,
        onBefore: (status) {
          province.clear();
          district.clear();
          subDistrict.clear();
          village.clear();
          listAddress.clear();
        },
        onSuccess: (data, flag) {
          var listData = data['data']['kodepos'];
          if (listData is List) {
            listData.forEach((map) {
              var alamat = Address.fromJson(map);
              listAddress.add(alamat);
            });
            _setZoneByPostalCode();
          }
        },
        onFailed: (title, message) {
          var response = BaseResponse.fromString(message);
          _resetRegion();
          Fluttertoast.showToast(
            msg: response?.message ?? 'Gagal',
            gravity: ToastGravity.CENTER,
          );
        },
        onError: (title, message) {
          _resetRegion();
          Fluttertoast.showToast(
            msg: 'Terjadi kesalahan data / koneksi',
            gravity: ToastGravity.CENTER,
          );
        },
        onAfter: (status){
          Get.back();
        }
    );
    setState(() {
      status.execute();
    });
  }

  _resetRegion(){
    _getAddress();
    setState(() {
      province.clear();
      district.clear();
      subDistrict.clear();
      village.clear();

      selectVillage = null;
      selectSubDistrict = null;
      selectDistrict = null;
      selectProvince = null;
    });
  }

  _setZoneByPostalCode(){
    listAddress.forEach((address) {
      var check_provinsi = province.where((element) => element.name.contains(address.provinsi));
      var checkKabupaten = district.where((element) => element.name.contains(address.kabupaten));
      var checkKecamatan = subDistrict.where((element) => element.name.contains(address.kecamatan));
      var checkDesa = village.where((element) => element.name.contains(address.kelurahanName));
      if(check_provinsi.isEmpty){
        province.add(Zone(name: address.provinsi));
      }

      if(checkKabupaten.isEmpty){
        district.add(Zone(name: address.kabupaten));
      }

      if(checkKecamatan.isEmpty){
        subDistrict.add(Zone(name: address.kecamatan));
      }

      if(checkDesa.isEmpty){
        village.add(Zone(name: address.kelurahanName));
      }
    });
    if(province.length == 1){
      selectProvince = province.first;
    }

    if(district.length == 1){
      selectDistrict = district.first;
    }

    if(subDistrict.length == 1){
      selectSubDistrict = subDistrict.first;
    }

    if(village.length == 1){
      selectVillage = village.first;
    }
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
        resetStep(step);
      }
      getKabupaten(data.id.toString(), isFirstLoad: isFirstLoad);
    } else if (step == 2) {
      selectDistrict = data;
      if(getKabupatenName(selectDistrict.name) != getKabupatenName(address.kabupaten)){
        resetStep(step);
      }
      getKecamatan(data.id.toString(), isFirstLoad: isFirstLoad);
    } else if (step == 3) {
      selectSubDistrict = data;
      if (selectSubDistrict.name.toLowerCase() !=
          address.kecamatan.toLowerCase()) {
        resetStep(step);
      }
      getDesa(data.id.toString(), isFirstLoad: isFirstLoad);
    } else if (step == 4) {
      selectVillage = data;
      resetStep(step);
      getPostalCode(isFirstLoad: isFirstLoad);
    } else if (step == 5) {
      selectPostalCode = data;
    }
  }

  void resetStep(int step) {
    selectDistrict = step < 2 ? null : selectDistrict;
    selectSubDistrict = step < 3 ? null : selectSubDistrict;
    selectVillage = step < 4 ? null : selectVillage;
    selectPostalCode = step < 5 ? null : selectPostalCode;
  }

  _getTokenRajaApi() async {
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
    debugPrint('current get postalcode $isFirstLoad');
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
        // complete = true;

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
          if (selected != null) {
            setZona(selected, 4, isFirstLoad: true);
          } else {
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

  void getPostalCode({bool isFirstLoad = false}) async {
    debugPrint('current get postalcode $isFirstLoad');
    postalCodes.clear();
    Map<String, dynamic> params = {
      'kabupaten': selectDistrict?.name,
      'kecamatan': selectSubDistrict?.name,
      'desa': selectVillage?.name,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlListKodepos,
      params: params,
      customHandle: true,
      onBefore: (status) {
        if (!isFirstLoad) {
          Get.back();
        }
      },
      onSuccess: (response, flag) {
        complete = true;
        var data = response['data'];
        var listData = data != null ? data['data'] : null;
        if (listData is List) {
          listData.forEach((map) {
            var zone = Zone.fromJson(map);
            if (postalCodes.firstWhere((element) => element?.name == zone?.name,
                orElse: () => null) ==
                null) postalCodes.add(zone);
          });
          if ((postalCodes?.length ?? 0) == 1) {
            selectPostalCode = postalCodes[0];
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Belum ada kodepos terdaftar',
            gravity: ToastGravity.CENTER,
          );
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
      // address.kodePos
    ];
    if (addressData
        .where((element) => element?.isNotEmpty ?? false)
        .toList()
        .length !=
        addressData.length) {
      Fluttertoast.showToast(
        msg: 'Mohon lengkapi data alamat toko',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    var wilayah = [
      selectProvince,
      selectDistrict,
      selectSubDistrict,
      selectVillage,
      selectPostalCode
    ];
    if (wilayah
        .where((element) => element != null)
        .toList()
        .length !=
        wilayah.length) {
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
      'kode_pos': selectPostalCode?.name,
      'provinsi': selectProvince.name,
      'kabupaten': selectDistrict.name,
      'kecamatan': selectSubDistrict.name,
      'desa': selectVillage.name,
      // 'provinsi': address.provinceName,
      // 'kabupaten': address.kabupatenName,
      // 'kecamatan': address.kecamatanName,
    };
    debugPrint('action api address $body');
    if (isDebugMode) {
      Get.back();
      Fluttertoast.showToast(
        msg: '(Dummy): Ubah alamat sukses',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
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
