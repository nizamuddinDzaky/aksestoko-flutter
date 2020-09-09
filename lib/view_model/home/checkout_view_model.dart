import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckoutViewModel extends State<CheckoutScreen> {
  @override
  void initState() {
    _getAddress();
    super.initState();
  }
  Address address;
  List<String> shiping = [];
  void _getAddress() async{
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlDetailAddress, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      address = baseResponse?.data?.address;
      shiping.add("Pengiriman Distributor");
      shiping.add("Pengambilan Sendiri");
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