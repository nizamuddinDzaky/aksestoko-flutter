import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/model/order_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/preview_delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PreviewDeliveryViewModel extends State<PreviewDeliveryScreen> {
  OrderDetail orderDetail;
  List<DetailDelivery> listDetailDelivery = [];
  getListOrder(String idPurchase) async {
    listDetailDelivery.clear();
    var status = await ApiClient.methodGet(ApiConfig.urlDetailOrder,
        params: {
          'id_pemesanan': idPurchase,
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
          orderDetail = OrderDetail.fromJson(data['data']);
          orderDetail.pengiriman.listDetailDelivery.forEach((detailDelivery) {
            if(detailDelivery.statuPengiriman.toLowerCase() == 'dalam pengiriman')
              listDetailDelivery.add(detailDelivery);
          });
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  Future<void> actionRefresh(String idPurchase) async {
    await getListOrder(idPurchase);
  }
}
