import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/checkout_model.dart';
import 'package:aksestokomobile/model/order_response.dart';
import 'package:aksestokomobile/model/sales_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckoutController extends GetController {
  static CheckoutController get to => Get.find();
  final SelectProductController productController = Get.find();
  DateTime date = DateTime.now();
  final noteSales = TextEditingController();
  SalesModel salesModel;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  saveCheckoutScreen(
      CheckoutModel checkoutModel, Address address, Shipment shipment) {
    salesModel = SalesModel()
      ..company_address_id = address?.id
      ..delivery_date = date.toStr()
      ..note = noteSales?.text
      ..delivery_method = shipment?.value;
    debugPrint('save sales model ${salesModel.toJson()}');
    Get.toNamed(paymentScreen, arguments: salesModel);
  }

  savePaymentScreen(SalesModel newSalesModel) {
    if (salesModel == null || newSalesModel == null) {
      debugPrint('check: sales model is null');
      return;
    }
    salesModel
      ..promo = productController.promoCode
      ..id_distributor = newSalesModel.id_distributor
      ..price_group_id = newSalesModel.price_group_id
      ..customer_group_id = newSalesModel.customer_group_id
      ..uuid = newSalesModel.uuid
      ..payment_method = newSalesModel.payment_method
      ..payment_durasi = newSalesModel.payment_durasi
      ..bank_id = newSalesModel.bank_id
      ..input_payment_durasi = newSalesModel.input_payment_durasi;
    debugPrint('save sales model ${salesModel.toJson()}');
    // Get.toNamed(paymentScreen, arguments: salesModel);
    // Get.offNamedUntil(
    //     successScreen, (route) => route.settings.name == parentScreen);
    // return;
    postActionOrder(salesModel.toJson());
  }

  postActionOrder(body) async {
    var status = await ApiClient.methodPost(ApiConfig.urlActionOrder, body, {},
        customHandle: true, onBefore: (status) {}, onSuccess: (data, _) {
      var orderResponse = OrderResponse.fromJson(data['data']);
      if (orderResponse != null) {
        Get.offNamedUntil(
          successScreen,
          (route) => route.settings.name == parentScreen,
          arguments: orderResponse,
        );
      } else {
        Get.defaultDialog(
          title: 'Sukses',
          content: Text('Namun terdapat kesalahan response'),
        );
      }
    }, onFailed: (title, message) {
      var response = BaseResponse.fromString(message);
      Get.defaultDialog(
        title: 'Operasi Gagal',
        content: Text(response.message ?? 'Gagal'),
      );
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text('Error'));
    }, onAfter: (status) {});
    status.execute();
  }

  void setDate(DateTime newDateTime) {
    debugPrint("${strToDate(newDateTime.toString())}");
    date = newDateTime ?? date;
    update();
  }
}
