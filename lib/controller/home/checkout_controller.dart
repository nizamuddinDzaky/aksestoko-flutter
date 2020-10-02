import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Product.dart';
import 'package:aksestokomobile/model/Sales.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckoutController extends GetController {
  static CheckoutController get to => Get.find();
  final SelectProductController productController = Get.find();
  DateTime date = DateTime.now();
  final noteSales = TextEditingController();
  String shipment;
  Sales sales;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  void checkout(String totalAkhir){
    sales = Sales();
    sales.tanggalPemesanan = date.toStr();
    sales.catatan = noteSales.text;
    sales.shipmentMethod = shipment;
    sales.totalAkhir = totalAkhir;
    sales.statusPembayaran = 'pending';
    sales.statusPemesanan = 'pending';

    Get.toNamed(paymentScreen, arguments: sales);
//    debugPrint("res => ${sales.tanggalPemesanan}");
//    debugPrint(sales.tanggalPemesanan);
  }

  void setDate(DateTime newDateTime) {
    debugPrint("${strToDate(newDateTime.toString())}");
    date = newDateTime ?? date;
    update();
  }
}