import 'package:aksestokomobile/controller/home/select_distributor_controller.dart';
import 'package:aksestokomobile/model/Distributor.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SelectDistributorViewModel extends SelectDistributorController {

  @override
  void initState() {
    getDataDistributor();
    super.initState();
  }

  void getDataDistributor() async {
    var params = {
//      MyString.KEY_SALE_STATUS: getSaleStatus(),
    };
    /*params.addAll(filterData);
    if (searchData != null && searchData.isNotEmpty) {
      params.clear();
      params.addAll(searchData);
    }*/
    var status = await ApiClient.methodGet(ApiConfig.urlListDistributor, onBefore: (status) {
//      Get.back();
        }, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListDistributor = baseResponse?.data?.listDistributor ?? [];
          listDistributor.addAll(newListDistributor);

          if(listDistributor.length ==1){
          gotoParent(context, listDistributor[0]);
        }

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

    return null;
  }
}