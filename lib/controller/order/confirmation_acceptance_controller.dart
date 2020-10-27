import 'package:aksestokomobile/model/delivery.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConfirmationAcceptanceController extends GetController {
  static ConfirmationAcceptanceController get to => Get.find();

   void updateScreen(){
      debugPrint("Focus:");
      update();
   }
}