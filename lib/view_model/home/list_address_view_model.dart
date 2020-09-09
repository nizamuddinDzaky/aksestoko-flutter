
import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/home/list_address_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ListAddressViewModel extends State<ListAddressScreen> {
  @override
  void initState() {
    super.initState();
    _getListAddress();
  }
  List<Address> listAddress = [];
  void _getListAddress() async{
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
    setState(() {
      status.execute();
    });
  }
}