import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/home/checkout_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckoutViewModel extends State<CheckoutScreen> {
  @override
  void initState() {
    _getAddress();
    super.initState();
  }
  Address address;
  List<String> shiping = [];
  var totalAkhir = 0.0;
  var shipmentPrice = 0.0;
  void _getAddress() async{
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlDetailAddress, params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      address = baseResponse?.data?.address;
      shiping.add("Pengiriman Distributor");
      shiping.add("Pengambilan Sendiri");
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    setState(() {
      status.execute();
    });
  }

  void getShipmentPrice(String shipment, SelectProductController controller) async{
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
    var status = await ApiClient.methodPost(
        ApiConfig.urlListShipment, body, {},
        onBefore: (status) {
          Get.back();
        }, onSuccess: (data, _) {
      var baseResponse = BaseResponse.fromJson(data);
      shipmentPrice = double.parse(baseResponse?.data?.shipmentPrice);
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

  double getTotalAkhir(SelectProductController controller){
    var harga = controller.getTotalHarga();
    totalAkhir = harga.toDouble() + shipmentPrice;
    return totalAkhir;
  }
}