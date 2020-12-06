import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/list_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class ListOrderViewModel extends State<ListOrderScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Order> _listOrder;
  OrderModel orderModelDalamProses;
  final ParentController controller = Get.find();

  List<Order> get listOrder =>
      [...(controller?.filter(widget?.status) ?? []), ...(_listOrder ?? [])];

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
      if (data['data'][status] is Map) {
        orderModelDalamProses = OrderModel.fromJson(data['data'][status]);
        _listOrder = orderModelDalamProses.listOrderDalamProses;
      }
      controller.clearOrder();
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    if (mounted)
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

  @override
  bool get wantKeepAlive => true;
}
