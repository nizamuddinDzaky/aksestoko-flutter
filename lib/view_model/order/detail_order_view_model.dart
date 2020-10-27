import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class DetailOrderViewModel extends State<DetailOrderScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  OrderDetail orderDetail;

  Future<void> actionRefresh() async {
    await getListOrder();
  }

  getListOrder() async {
    if (Get.arguments == null) {
      debugPrint('argument kosong');
      return;
    }
    var status = await ApiClient.methodGet(ApiConfig.urlDetailOrder,
        params: {
          'id_pemesanan': Get.arguments?.toString(),
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      var response = BaseResponse.fromJson(data);
      /*debugPrint("response : ${response.data.orderDetail.detailPemesanan}");*/
      orderDetail = OrderDetail.fromJson(data['data']);
      /*debugPrint("response : ${orderDetail.ringkasan}");*/
      // order = response?.data?.orderModel?.listOrderDalamProses ?? [];
    }, onFailed: (title, message) { 
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  void putCancelOrder(String idPurchase) async {
    var body = {
      'purchase_id': idPurchase,
    };
    var status = await ApiClient.methodPut(ApiConfig.urlCancelOrder, body, {},
        onBefore: (status) {
          Get.back();
        }, onSuccess: (data, _) {
          var baseResponse = BaseResponse.fromJson(data);
          debugPrint("result => ${baseResponse?.data?.idPurchase}");
          getListOrder();
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onAfter: (status) {
          /*if (status == ResponseStatus.success)
        MyPref.setRemember(isRemember, currentData);*/
        });
    status.execute();
  }

  showDialogProgress(String idPurchase) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });
    await putCancelOrder(idPurchase);
  }
  @override
  void initState() {
    super.initState();
    debugPrint('argument1 ${Get.arguments}');
    actionRefresh();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      debugPrint('argument2 ${Get.arguments}');
      refreshKey?.currentState?.show();
    });
  }
}
