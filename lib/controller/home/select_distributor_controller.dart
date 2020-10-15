import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SelectDistributorController
    extends State<SelectDistributorScreen> with SingleTickerProviderStateMixin {
  List<Distributor> listDistributor = [];

  gotoParent(BuildContext context, Distributor distributor) {
    if (!MyPref.isIdDistributorExist()) {
      MyPref.setIdDristributor(distributor.id);
      MyPref.setDisributorName(distributor.nama);
      MyPref.setDisributorCode(distributor.kode);
      Get.offNamed(parentScreen);
    } else {
      MyPref.setIdDristributor(distributor.id);
      MyPref.setDisributorName(distributor.nama);
      MyPref.setDisributorCode(distributor.kode);
      Get.back(result: distributor.id);
    }
  }
}
