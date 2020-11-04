import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/zone.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/edit_alamat_screen.dart';
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
  Address address;
  final List<Zona> village = [];
  final List<Zona> province = [];
  final List<Zona> district = [];
  final List<Zona> subDistrict = [];
  Zona selectVillage;
  Zona selectProvince;
  Zona selectSubDistrict;
  Zona selectDistrict;

  reInitText() {
    nameTextController.text = address?.namaPenerima;
    emailTextController.text = address?.email;
    phoneTextController.text = address?.noTlpn;
    addressTextController.text = address?.alamat;
    postalCodeTextController.text = address?.kodePos;
  }

  reZona() {
    selectProvince =
        Zona(provinceName: address?.provinceName ?? address?.provinsi);
    selectDistrict =
        Zona(kabupatenName: address?.kabupatenName ?? address?.kabupaten);
    selectSubDistrict =
        Zona(kecamatanName: address?.kecamatanName ?? address?.kecamatan);
    selectVillage =
        Zona(idWilayah: address?.desa ?? selectSubDistrict?.kecamatanName);
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
        reZona();
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

  setZona(Zona data, int step) async {
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
    if (step == 1) {
      selectProvince = data;
      selectDistrict = data;
      selectSubDistrict = data;
      selectVillage = data;
      getKabupaten(data.kabupatenCode);
      // getsubDistrict(data.kecamatanCode);
    } else if (step == 2) {
      selectDistrict = data;
    } else if (step == 3) {
      selectSubDistrict = data;
    } else if (step == 4) {
      selectVillage = data;
    }
  }

  void getProvinsi() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlProvinsi,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var listData = data['data'];
        if (listData is List) {
          listData.forEach((map) {
            province.add(Zona.fromJson(map));
          });
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

  void getKabupaten(String idProvinsi) async {
    district.clear();
    var params = {
      'province': idProvinsi,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlKabupaten,
      params: params,
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        var listData = data['data'];
        if (listData is List) {
          listData.forEach((map) {
            district.add(Zona.fromJson(map));
          });
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

  void getsubDistrict(String idKabupaten) async {
    subDistrict.clear();
    var params = {
      'city': idKabupaten,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlKecamatan,
      params: params,
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        var listData = data['data'];
        if (listData is List) {
          listData.forEach((map) {
            subDistrict.add(Zona.fromJson(map));
          });
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
      'provinsi': selectProvince.provinceName,
      'kabupaten': selectDistrict.kabupatenName,
      'kecamatan': selectSubDistrict.kecamatanName,
      // 'desa': selectVillage.idWilayah,
      // 'provinsi': address.provinceName,
      // 'kabupaten': address.kabupatenName,
      // 'kecamatan': address.kecamatanName,
      'desa': address.desa,
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
    getProvinsi();
    address = Address(
      namaPenerima: widget.address.addressName,
      noTlpn: widget.address.addressPhone,
      alamat: widget.address.address,
      kodePos: widget.address.addressPostalCode,
      provinceName: widget.address.addressCountry,
      kabupatenName: widget.address.addressCity,
      kecamatanName: widget.address.addressState,
    );
    reInitText();
    reZona();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _getAddress();
    });
  }
}
