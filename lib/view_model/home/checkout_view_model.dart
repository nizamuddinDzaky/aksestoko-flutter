import 'dart:convert';

import 'package:aksestokomobile/controller/home/checkout_controller.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/checkout_model.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class CheckoutViewModel extends State<CheckoutScreen> {
  List<Product> cart;
  int complete;
  Shipment selectShipping;
  CheckoutModel checkoutModel;
  Address address;

  @override
  void initState() {
    cart = Get.arguments;
    actionRefresh();
    super.initState();
  }

  Future<void> actionRefresh() async {
    setState(() {
      complete = null;
    });
    _getDetailCheckout();
    return Future.value();
  }

  void _getDetailCheckout() async {
    var controller = SelectProductController.to;
    var status = await ApiClient.methodGet(ApiConfig.urlDetailCheckout,
        params: {
          'id_distributor': MyPref.getIdDistributor().toString(),
          'price_group_id': MyPref.getPriceGroupId().toString(),
          if (controller?.promoCode?.isNotEmpty ?? false)
            'promo': controller.promoCode,
        },
        customHandle: true,
        onBefore: (status) {}, onSuccess: (data, flag) {
      checkoutModel = CheckoutModel.fromJson(data['data']);
      selectShipping = checkoutModel?.listPengiriman
          ?.where((element) => element.value == 'pickup')
          ?.first;
      address = checkoutModel?.alamatPengiriman;
      getShipment();
    }, onFailed: (title, message) {
      complete = 0;
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
      complete = 0;
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
        params: params,
        onBefore: (status) {},
        customHandle: true, onSuccess: (data, _) {
          var response = BaseResponse.fromJson(data);
          var ringkasan = response?.data?.ringkasan;
          if (ringkasan?.label?.isNotEmpty ?? false) {
            selectShipping?.totalHarga = 0;
          }
          checkoutModel?.ringkasan = ringkasan;
          complete = 2;
    }, onFailed: (title, message) {
          complete = checkoutModel == null ? 0 : 1;
          var baseResponse = BaseResponse.fromJson(jsonDecode(message));
          Fluttertoast.showToast(
            msg: baseResponse.message,
            gravity: ToastGravity.CENTER,
          );
        }, onError: (title, message) {
          complete = checkoutModel == null ? 0 : 1;
          Fluttertoast.showToast(
            msg: 'Terjadi kesalahan data / koneksi',
            gravity: ToastGravity.CENTER,
          );
        },
        onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  void actionToPayment(CheckoutController controller) {
    if (complete != 2) {
      Fluttertoast.showToast(
        msg: 'Transaksi tidak dapat dilanjutkan',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    controller.saveCheckoutScreen(checkoutModel, address, selectShipping);
  }
}
