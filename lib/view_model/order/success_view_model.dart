import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/order_response.dart';
import 'package:aksestokomobile/screen/home/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SuccessViewModel extends State<SuccessScreen> {
  OrderResponse orderResponse;

  initData() {
    setState(() {
      orderResponse = Get.arguments;
    });
  }

  @override
  void initState() {
    super.initState();
    SelectProductController.to?.resetCart();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initData();
    });
  }
}
