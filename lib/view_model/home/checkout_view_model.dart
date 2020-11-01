import 'dart:convert';

import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/checkout_model.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckoutViewModel extends State<CheckoutScreen> {
  List<Product> cart;
  bool complete;
  Shipment selectShipping;
  CheckoutModel checkoutModel;
  Address address;

  @override
  void initState() {
    cart = Get.arguments;
    _getDetailCheckout();
    super.initState();
  }

  void _getDetailCheckout() async {
    var status = await ApiClient.methodGet(ApiConfig.urlDetailCheckout,
        params: {
          'id_distributor': MyPref.getIdDistributor().toString(),
        },
        customHandle: true,
        onBefore: (status) {}, onSuccess: (data, flag) {
      checkoutModel = CheckoutModel.fromJson(data['data']);
      selectShipping = checkoutModel?.listPengiriman
          ?.where((element) => element.value == 'pickup')
          ?.first;
      address = checkoutModel?.alamatPengiriman;
      complete = true;
    }, onFailed: (title, message) {
      complete = false;
      var response = BaseResponse.fromJson(jsonDecode(message));
      Get.defaultDialog(
          title: "Pemberitahuan",
          content: Text("Proses tidak bisa dilanjutkan. ${response?.message}"),
          textCancel: 'Tutup',
          onCancel: () {
            debugPrint('back 1');
            Get.back();
            Get.back(result: {
              'errorcode': response?.code,
            });
          });
    }, onError: (title, message) {
      complete = false;
      // Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  getShipment() async {
    var params = {
      'id_distributor': MyPref.getIdDistributor(),
      'price_group_id': MyPref.getPriceGroupId(),
      'delivery_method': selectShipping.value,
    };
    var status = await ApiClient.methodGet(ApiConfig.urlShipmentPrice,
        params: params, onBefore: (status) {}, onSuccess: (data, _) {
      var response = BaseResponse.fromJson(data);
      var ringkasan = response?.data?.ringkasan;
      if (ringkasan?.label?.isNotEmpty ?? false) {
        selectShipping?.totalHarga = 0;
      }
      checkoutModel?.ringkasan = ringkasan;
    },
        onFailed: (title, message) {},
        onError: (title, message) {},
        onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }
}
