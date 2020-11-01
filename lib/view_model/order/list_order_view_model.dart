import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/list_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class ListOrderViewModel extends State<ListOrderScreen> {
  /*String status ;
  ListOrderViewModel(String status){

  }*/
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Order> listOrder;
  OrderModel orderModelDalamProses;

  Future<void> actionRefresh(String status) async {
    await getListOrder(status);
  }

  getListOrder(String status) async {
    var request = await ApiClient.methodGet(ApiConfig.urlListOrder,
        params: {
          'offset': '0',
          'limit': '10',
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      /*var response = BaseResponse.fromJson(data);*/
      orderModelDalamProses = OrderModel.fromJson(data['data'][status]);
      listOrder = orderModelDalamProses.listOrderDalamProses;
      debugPrint("orderModel : ${listOrder.length}");
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      request.execute();
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
