import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/detail_payment.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/detail_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class DetailPaymentViewModel extends State<DetailPaymentScreen> {
  DetailPayment detailPayment;
  bool completeLoad;

  Future<void> actionRefresh() async {
    setState(() {
      completeLoad = null;
    });
    getListPayment();
    return Future.value();
  }

  getListPayment() async {
    if (Get.arguments == null) {
      debugPrint('argument kosong');
      return;
    }
    debugPrint("id_pemesanan = ${Get.arguments?.toString()}");
    var status = await ApiClient.methodGet(ApiConfig.urlListProofPayment,
        customHandle: true,
        params: {
          'id_pemesanan': Get.arguments?.toString(),
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      completeLoad = true;
      detailPayment = DetailPayment.fromJson(data['data']);
    }, onFailed: (title, message) {
      var response = BaseResponse.fromString(message);
      Get.defaultDialog(title: title, content: Text(response?.message ?? ''));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }
}