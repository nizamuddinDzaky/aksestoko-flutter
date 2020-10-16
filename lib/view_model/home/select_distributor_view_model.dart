import 'package:aksestokomobile/controller/home/select_distributor_controller.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SelectDistributorViewModel extends SelectDistributorController {
  @override
  void initState() {
    getDataDistributor();
    super.initState();
  }

  void getDataDistributor() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListDistributor,
        onBefore: (status) {
//      Get.back();
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      List<Distributor> newListDistributor =
          baseResponse?.data?.listDistributor ?? [];
      listDistributor.addAll(newListDistributor);

      if (listDistributor.length == 1) {
        gotoParent(context, listDistributor[0]);
      }
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });

    return null;
  }
}
