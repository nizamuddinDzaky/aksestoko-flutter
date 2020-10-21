import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/sales_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class SalesPersonViewModel extends State<SalesPersonScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();

  Future<void> actionRefresh() async {
    await getSalesPerson();
  }

  getSalesPerson() async {
    var status = await ApiClient.methodGet(ApiConfig.urlDetailSalesPerson,
        onBefore: (status) {},
        onSuccess: (data, flag) {}, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
