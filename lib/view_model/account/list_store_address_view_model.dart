import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/list_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ListStoreAddressViewModel extends State<ListAddressScreen> {
  List<Alamat> listAddress;

  void getListAddress() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListAddress,
        onBefore: (status) {}, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListAddress = baseResponse?.data?.listAlamat ?? [];
          listAddress = listAddress ?? [];
          listAddress
            ..clear()
            ..addAll(newListAddress);
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text('Gagal'));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text('Gagal'));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    getListAddress();
    super.initState();
  }
}