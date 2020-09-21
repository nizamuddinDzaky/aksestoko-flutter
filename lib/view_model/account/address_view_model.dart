import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/model/Zone.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/account/address_controller.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AddressViewModel<T extends StatefulWidget> extends State<T>{
  @override
  void initState() {
    super.initState();
  }

  var address;
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

  final provinceSelected  = TextEditingController();
  final List<Zone> province = [];
  final List<Zone> district = [];
  final List<Zone> subDistrict = [];
  final List<Zone> village = [];

  /*final districtSelected  = TextEditingController();
  final subDistrictSelected  = TextEditingController();
  final villageSelected  = TextEditingController();*/

  searchKabupaten(Zone data) async{
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
    await getKabupaten(data.id == null ? 0 : data.id);
  }

  searchKecamatan(Zone data) async{
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
    await getsubDistrict(data.id == null ? 0 : data.id);
  }

  searchDesa(Zone data) async{
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
    await getVillage(data.id == null ? 0 : data.id);
  }

  void getProvinsi() async{
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListProvinsi, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      province.addAll(baseResponse?.data?.listProvinsi);
      /*Navigator.of(context).pop();*/
      if(address != null){
        province.forEach((prov) {
          if(prov.name.toLowerCase() == address.provinceName.toLowerCase()){
            searchKabupaten(prov);
          }
        });
      }

    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    setState(() {
      status.execute();
    });
  }

  void getKabupaten(int idProvinsi) async{
    district.clear();
    var params = {
      MyString.KEY_ID_PROVINSI: idProvinsi,
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListKabupaten, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      district.addAll(baseResponse?.data?.listKabupaten);
      Navigator.of(context).pop();
      if(address != null){
        district.forEach((kab) {
          if(kab.name.toLowerCase() == address.kabupatenName.toLowerCase()){
            searchKecamatan(kab);
//            break;
          }
        });
      }
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    /*status.execute();*/
    setState(() {
      status.execute();
    });
  }

  void getsubDistrict(int idKabupaten) async{
    district.clear();
    var params = {
      MyString.KEY_ID_KABUPATEN: idKabupaten,
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListKecamatan, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      subDistrict.addAll(baseResponse?.data?.listKecamatan);
      Navigator.of(context).pop();
      if(address != null){
        subDistrict.forEach((kec) {
          if(kec.name.toLowerCase() == address.kecamatanName.toLowerCase()){
            searchDesa(kec);
          }
        });
      }


    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    setState(() {
      status.execute();
    });
  }

  void getVillage(int idKecamatan) async{
    district.clear();
    var params = {
      MyString.KEY_ID_KECAMATAN: idKecamatan,
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListDesa, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      village.addAll(baseResponse?.data?.listDesa);
      if(address != null){
        village.forEach((vil) {
          if(vil.name.toLowerCase() == address.kelurahanName.toLowerCase()){
            selectVillage = vil;
          }
        });
      }
      Navigator.of(context).pop();
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    setState(() {
      status.execute();
    });
  }

}