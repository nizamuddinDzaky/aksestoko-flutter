import 'package:aksestokomobile/model/Distributor.dart';
import 'package:aksestokomobile/screen/home/parent_screen.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SelectDistributorController extends State<SelectDistributorScreen>
    with SingleTickerProviderStateMixin {
  /*@override
  void initState() {
    getDataDistributor();
    super.initState();
  }*/


  List<Distributor> listDistributor = [];

  gotoParent(BuildContext context, Distributor distributor){
    if(!MyPref.isIdDistributorExist()){
      MyPref.setIdDristributor(distributor.id);
      MyPref.setDisributorName(distributor.nama);
      MyPref.setDisributorCode(distributor.kode);

      Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
          builder: (context) => ParentScreen()),
              (Route<dynamic> route) => false
      );
    }else{
      MyPref.setIdDristributor(distributor.id);
      MyPref.setDisributorName(distributor.nama);
      Get.back(result: distributor.id);
    }
  }
}