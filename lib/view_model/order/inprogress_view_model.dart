import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/in_proses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class InprogressViewModel extends State<InProsesScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Order> listOrder;

  Future<void> actionRefresh() async {
    await getListOrder();
  }

  getListOrder() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListOrder,
        params: {
          'offset': '0',
          'limit': '10',
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      var response = BaseResponse.fromJson(data);
      listOrder = response?.data?.orderModel?.listOrderDalamProses ?? [];
    }, onFailed: (title, message) {
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
