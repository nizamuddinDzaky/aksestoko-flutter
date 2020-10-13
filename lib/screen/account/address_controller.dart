
import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetController{
  /*AddressController({Address address}){
    this.isEdit = address != null;
  }*/
  static AddressController get to => Get.find();
  bool isEdit = false;

  Address address;

  List<Address> listAddress = [];

  setAddress(Address address) {
    this.address = address;
    this.isEdit = address != null;
    debugPrint('terdeteksi ubah $isEdit');
  }

  Address getAddress(){
    return this.address;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  saveForm(
      {namaPenerima,
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
      kodePos,}) {
    address = address ?? Address();
    address.namaPenerima =namaPenerima ?? address.namaPenerima;
    address.email =email ?? address.email;
    address.noTlpn =noTlpn ?? address.noTlpn;
    address.alamat =alamat ?? address.alamat;
    address.provinceName =provinceName ?? address.provinceName;
    address.provinceId =provinceId ?? address.provinceId;
    address.kabupatenName =kabupatenName ?? address.kabupatenName;
    address.kabupatenId =kabupatenId ?? address.kabupatenId;
    address.kecamatanName =kecamatanName ?? address.kecamatanName;
    address.kecamatanId =kecamatanId ?? address.kecamatanId;
    address.kodePos =kodePos ?? address.kodePos;
  }

  actionSubmit(BuildContext context) async {
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
    formKey.currentState.save();
    var body = {
      'namaPenerima' : address?.namaPenerima,
      'email' : address?.email,
      'noTlpn' : address?.noTlpn,
      'alamat' : address?.alamat,
      'provinceName' : address?.provinceName,
      'provinceId' : address?.provinceId,
      'kabupatenName' : address?.kabupatenName,
      'kabupatenId' : address?.kabupatenId,
      'kecamatanName': address?.kecamatanName,
      'kecamatanId': address?.kecamatanId,
      'addressId': address?.addressId,
      'kodePos': address?.kodePos,
    };
    debugPrint('action api ${isEdit ? 'edit' : 'add'} customer $body');
    if (isEdit) {
      await actionPutEditAddress(body, context);
    } else {
      await actionPostAddAddress(body, context);
    }

  }

  actionPutEditAddress(body, BuildContext context) async {
    var params = {
      'id_customer': address?.addressId,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlEditAddress,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Navigator.of(context).pop();
        Get.back(result: "qqww");
      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  actionPostAddAddress(body, BuildContext context) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddAddress,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Navigator.of(context).pop();
        Get.back(result: "qqww");

      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  void getListAddress() async{
    listAddress.clear();
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };

    var status = await ApiClient.methodGet(ApiConfig.urlListAddress, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      listAddress.addAll(baseResponse?.data?.listAddress);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    status.execute();
    update();
  }

  void deleteAddress(int idAddress, BuildContext context) async{
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: idAddress,
    };

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

    var status = await ApiClient.methodPost(
      ApiConfig.urlAddAddress,
      {},
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        getListAddress();
        Navigator.of(context).pop();
//        Get.back(result: "qqww");

      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onAfter: (status) {},
    );
    status.execute();
    update();
  }
}