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
    if (MyPref.getIdDistributor() == distributor.id) {
      Get.back();
      return;
    }
    MyPref.setIdDristributor(distributor.id);
    MyPref.setCustomerGroupId(distributor.customerGroupId);
    MyPref.setPriceGroupId(distributor.priceGroupId);
    MyPref.setDisributorName(distributor.namaPrincipal);
    MyPref.setDisributorCode(distributor.kode);
    MyPref.setMap('distributor', distributor.toJson());
    if (!MyPref.isIdDistributorExist()) {
      Get.offNamed(parentScreen);
    } else {
      Get.back(result: distributor.id);
    }
  }
}
