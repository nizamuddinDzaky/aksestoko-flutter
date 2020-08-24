import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/screen/home/select_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class selectProductModel extends State<SelectProductScreen>{
  toSelectDistributorScreen(){
    Get.toNamed(selectDistributorScreen);
  }
}