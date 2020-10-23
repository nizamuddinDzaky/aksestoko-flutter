import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/data_response.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckoutViewModel extends State<CheckoutScreen> {
  List<Product> cart;
  bool complete;
  String selectShipping = "";
  DataResponse response;

  @override
  void initState() {
    cart = Get.arguments;
    _getDetailCheckout();
    super.initState();
  }

  Address address;
  List<String> shiping = [];
  var totalAkhir = 0.0;
  var shipmentPrice = 0.0;

  void _getDetailCheckout() async {
    var status = await ApiClient.methodGet(ApiConfig.urlDetailCheckout,
        params: {
          'id_distributor': MyPref.getIdDistributor().toString(),
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      response = baseResponse?.data;
      address = response?.address;
      complete = true;
    }, onFailed: (title, message) {
      complete = false;
      Get.defaultDialog(
          title: "Pemberitahuan",
          content: Text("Proses tidak bisa dilanjutkan $message"),
          textCancel: 'Tutup',
          onCancel: () {
            Get.back();
          }).then((value) {
        Get.back();
      });
    }, onError: (title, message) {
      complete = false;
      // Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  void getShipmentPrice(String shipment) async {
    final SelectProductController controller = Get.find();
    List<Map<String, dynamic>> cart = [];
    controller.listCart?.forEach((p) {
      cart.add({
        'product_id': p.productId,
        'price': p.satuanHargaCash,
        'quantity': p.qty,
      });
    });
    var body = {
      'shipment': shipment,
      'item': cart,
    };
    var status = await ApiClient.methodPost(ApiConfig.urlListShipment, body, {},
        onBefore: (status) {
      Get.back();
    }, onSuccess: (data, _) {
      var baseResponse = BaseResponse.fromJson(data);
      shipmentPrice = double.parse(baseResponse?.data?.shipmentPrice);
      var harga = getTotalHarga();
      totalAkhir = harga.toDouble() + shipmentPrice;
      debugPrint(baseResponse?.data?.shipmentPrice);
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

  double getTotalHarga() {
    double total = 0.0;
    cart.forEach((cart) => total +=
        (cart.qty * (cart.satuanHargaCash?.toString()?.toDouble() ?? 0.0)));
    return total;
  }

  double getTotalAkhir() {
    return totalAkhir;
  }

  int getSumItem() {
    int totalQty = 0;
    cart.forEach((cart) => totalQty += cart.qty.toInt());
    return totalQty;
  }
}
