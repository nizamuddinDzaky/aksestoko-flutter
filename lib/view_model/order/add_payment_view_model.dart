
import 'dart:io';

import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/payment_data.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/add_payment_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

abstract class AddPaymentViewModel extends State<AddPaymentScreen> {
  PaymentData paymentData = null;
  String base64File = "data:image/png;base64,";
  String idPemesanan = null;
  var nominalTextController =  TextEditingController();
  bool completeLoad;
  File imageFile;
  //

  Future<void> actionRefresh() async {
    setState(() {
      completeLoad = null;
    });
    getDetailPayment();
    return Future.value();
  }
  getDetailPayment() async{
    if (Get.arguments == null) {
      return;
    }
    var status = await ApiClient.methodGet(ApiConfig.urlDetailAddPayment,
        params: {
          'id_pemesanan': Get.arguments?.toString(),
          'supplier_id' : MyPref.getIdDistributor()
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
          completeLoad = true;
          var response = BaseResponse.fromJson(data);
          paymentData = response.data.paymentData;
          debugPrint("result => ${paymentData.metodePembayaran}");
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  actionAddPayment() async{
    if(nominalTextController.text == ''){
      Get.defaultDialog(title: "Warning", content: Text('Nominal Harap Diisi'));
      return;
    }
    if(imageFile == null){
      Get.defaultDialog(title: "Warning", content: Text('File Tidak Boleh Kosong'));
      return;
    }

    var crnPayment = double.parse(nominalTextController.text.replaceAll("Rp", "").replaceAll(".", "").trim());
    var maxPayment = double.parse(paymentData.total.replaceAll("Rp", "").replaceAll(",", "").trim());
    if(crnPayment > maxPayment){
      Get.defaultDialog(title: "Warning", content: Text('Pembayaran Melebihi Batas'));
      return;
    }

    if(crnPayment <= 0 ){
      Get.defaultDialog(title: "Warning", content: Text('Pembayaran Tidak Boleh Nol'));
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

    var body = {
      "id_pemesanan" : idPemesanan,
      "nominal" : crnPayment,
      "file" : base64File,
    };

    var status = await ApiClient.methodPost(
      ApiConfig.urlAddPayment,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Navigator.of(context).pop();
        Get.back(result: true);
      },
      onFailed: (title, message) {
        Navigator.of(context).pop();
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
      },
      onAfter: (status) {},
    );
    status.execute();
  }
}