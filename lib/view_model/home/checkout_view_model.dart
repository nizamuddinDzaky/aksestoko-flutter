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
  void _getAddress() async{
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlDetailAddress, params: params, onBefore: (status) {
//      Get.back();
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      address = baseResponse?.data?.address;
      /*var newListProduct = baseResponse?.data?.listProduct ?? [];*/
      /*listProduct.clear();
      listProduct.addAll(newListProduct);*/

    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
//      if (status == ResponseStatus.success)
//        MyPref.setRemember(isRemember, currentData);
    });
    setState(() {
      status.execute();
    });
  }
}