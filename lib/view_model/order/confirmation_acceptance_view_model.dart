import 'dart:io';

import 'package:aksestokomobile/controller/order/confirmation_acceptance_controller.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/confirmation_acceptance_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/util/my_util.dart';

abstract class ConfimationAcceptanceViewModel extends State<ConfirmationAcceptScreen> {
  File imageFile;
  DetailDelivery detailDelivery;
  DetailPemesanan detailPemesanan;
  Map<String, dynamic> param;
  String base64File = "data:image/png;base64,";
  // ConfirmationAcceptanceController controller = Get.find();

  @override
  void initState() {
    param = Get.arguments as Map<String, dynamic>;
    detailDelivery = param['delivery'] as DetailDelivery;
    detailPemesanan = param['purchase'] as DetailPemesanan;
    debugPrint("argument => ${detailDelivery.listItemDetailDelivery}");
    /*controller.sumItem();
    controller.sumGoodItem();
    controller.sumBadItem();*/
    // TODO: implement initState
    super.initState();
  }

  String sumGoodItem(){
    int sum = 0;
    detailDelivery.listItemDetailDelivery.forEach((item) {
      sum += item.baik ?? item.jumlah;
    });
    return sum.toString();
  }

  String sumBadItem(){
    int sum = 0;
    detailDelivery.listItemDetailDelivery.forEach((item) {
      sum += item.buruk ?? 0;
    });
    return sum.toString();
  }

  String sumItem(){
    int sum = 0;
    detailDelivery.listItemDetailDelivery.forEach((item) {
      sum += item.jumlah ?? 0;
    });
    return sum.toString();
  }

  postConfirmDelivery() async{


    bool isSetBadItem = false;
    var body = {
      "id_pemesanan" : detailPemesanan.idPemesanan,
      "date" : DateTime.now().toStr(),
      "id_pengiriman" : detailDelivery.idDelivery,
      "file" : base64File,
      "id_distributor" : MyPref.getIdDistributor(),
      "produk" : detailDelivery.listItemDetailDelivery.map((item) {
        /*debugPrint("${item.buruk}");*/
        if(item.buruk != 0 && item.buruk != null){
          isSetBadItem = true;
        }
        return {
          'id_produk': item.idProduct,
          'nama_produk' : item.namaProduct,
          'kode_produk' : item.kodeProduct,
          'quantity_diterima' : item.jumlah,
          'delivery_item_id' : item.deliveryItemId,
          'baik' : item.baik ?? item.jumlah,
          'buruk': item.buruk ?? 0,
        };
      }).toList(),
    };

    if(isSetBadItem && imageFile == null){
      Get.defaultDialog(title: "Warning", content: Text('File Tidak Boleh Kosong'));
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CircularProgressIndicator()],
            ),
          );
        });
    /*debugPrint('body : $body');*/
    /*var status = await ApiClient.methodPost(
      ApiConfig.urlConfirmDelivery,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Navigator.of(context).pop();
        Get.back(result: true);
      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onAfter: (status) {},
    );
    status.execute();*/
  }

  onChangeBadItem(String badItem, ItemDetailDelivery itemDetailDelivery){
    // debugPrint("${textEditingController.text}");
    // itemDetailDelivery.buruk = int.parse(badItem);
    /*setState(() {
      int item = int.parse(badItem);
      if(item > itemDetailDelivery.jumlah){
        itemDetailDelivery.baik = 0;
        itemDetailDelivery.buruk = itemDetailDelivery.jumlah;
      }
    });*/
  }

  /*void onFocusChange(String s){
    debugPrint("Focus: "+focus.hasFocus.toString());
  }*/
}