import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/model/zone.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class AddressViewModel<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    getProvinsi();
  }

  Alamat address;
  Address curAddress;
  String selectedValue;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /*String recipientsName;
  String email;
  String tlp;
  String address;
  String postalCode;*/

  Zone selectProvince;
  Zone selectDistrict;
  Zone selectSubDistrict;
  Zone selectVillage;
  Zona selectProvince2;
  Zona selectDistrict2;
  Zona selectSubDistrict2;
  Zona selectVillage2;

  final provinceSelected = TextEditingController();
  final List<Zone> province = [];
  final List<Zone> district = [];
  final List<Zone> subDistrict = [];
  final List<Zone> village = [];
  final List<Zona> province2 = [];
  final List<Zona> district2 = [];
  final List<Zona> subDistrict2 = [];
  final List<Zona> village2 = [];

  /*final districtSelected  = TextEditingController();
  final subDistrictSelected  = TextEditingController();
  final villageSelected  = TextEditingController();*/

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
      selectProvince2 = data;
      selectDistrict2 = data;
      selectSubDistrict2 = data;
      selectVillage2 = data;
      // getKabupaten(data.kabupatenCode);
      getsubDistrict(data.kecamatanCode);
    } else if (step == 2) {
      selectDistrict2 = data;
    } else if (step == 3) {
      selectSubDistrict2 = data;
    } else if (step == 4) {
      selectVillage2 = data;
    }
  }

  searchKabupaten(Zone data) async {
    selectProvince = data;
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
    // getKabupaten(data.id == null ? 0 : data.id);
  }

  searchKecamatan(Zone data) async {
    selectDistrict = data;
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
    // getsubDistrict(data.id == null ? 0 : data.id);
  }

  searchDesa(Zone data) async {
    selectSubDistrict = data;
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
    getVillage(data.id == null ? 0 : data.id);
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
            province2.add(Zona.fromJson(map));
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
    district2.clear();
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
            district2.add(Zona.fromJson(map));
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
    subDistrict2.clear();
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
            subDistrict2.add(Zona.fromJson(map));
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

  void getVillage(int idKecamatan) async {
    district2.clear();
    var params = {
      MyString.KEY_ID_KECAMATAN: idKecamatan,
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListDesa,
        params: params, onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      // village.addAll(baseResponse?.data?.listDesa);
      if (address != null) {
        village2.forEach((vil) {
          // if(vil.name.toLowerCase() == address.kelurahanName.toLowerCase()){
          //   selectVillage = vil;
          // }
        });
          }
          Navigator.of(context).pop();
        },
        onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        },
        onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        },
        onAfter: (status) {});
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
    curAddress = curAddress ?? Address();
    curAddress.namaPenerima = namaPenerima ?? curAddress.namaPenerima;
    curAddress.email = email ?? curAddress.email;
    curAddress.noTlpn = noTlpn ?? curAddress.noTlpn;
    curAddress.alamat = alamat ?? curAddress.alamat;
    curAddress.kodePos = kodePos ?? curAddress.kodePos;
  }

  actionSubmit(BuildContext context) async {
    // if (formKey.currentState.validate()) {
    formKey.currentState.save();
    // } else {
    //   return;
    // }
    var addressData = [
      curAddress.namaPenerima,
      curAddress.email,
      curAddress.noTlpn,
      curAddress.alamat,
      curAddress.kodePos
    ];
    if (addressData
        .where((element) => element.isNotEmpty)
        .toList()
        .length !=
        addressData.length) {
      Fluttertoast.showToast(
        msg: 'Mohon lengkapi data alamat toko',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if ([selectProvince2, selectDistrict2, selectSubDistrict2, selectVillage2]
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
      'nama': curAddress.namaPenerima,
      'email': curAddress.email,
      'no_tlp': curAddress.noTlpn,
      'alamat': curAddress.alamat,
      'kode_pos': curAddress.kodePos,
      'provinsi': selectProvince2.provinceName,
      'kabupaten': selectDistrict2.kabupatenName,
      'kecamatan': selectSubDistrict2.kecamatanName,
      'desa': selectVillage2.idWilayah.toString(),
    };
    debugPrint('action api address $body');
    _postAddAddress(body);
    // debugPrint('action api ${isEdit ? 'edit' : 'add'} customer $body');
    // if (isEdit) {
    //   await actionPutEditAddress(body, context);
    // } else {
    //   await actionPostAddAddress(body, context);
    // }
  }

  _postAddAddress(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddAddress,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: 'Tambah alamat sukses',
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
}
