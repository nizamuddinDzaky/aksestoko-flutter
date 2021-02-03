import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/customer_service/add_issue_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class AddIssueViewModel extends State<AddIssueScreen> {
  String subjectValue;
  TextEditingController issueController = TextEditingController();
  List subjectList = [
    "Akun Saya",
    "Pembayaran",
    "Pengiriman",
    "Pesanan",
    "Poin & Loyalty",
    "Umum",
  ];

  actionSubmitIssue(){
    if(subjectValue == null){
      Fluttertoast.showToast(
        msg: 'Subject Belum dipilih',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if(issueController.text.isEmpty){
      Fluttertoast.showToast(
        msg: 'Keluhan Tidak Boleh Kosong',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    var body = {
      'subject': subjectValue,
      'description': issueController.text,
    };

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

    _postAddIssue(body);

    /*debugPrint("body : $body");*/
  }

  _postAddIssue(body)async{
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddIssue,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: data['message'],
          gravity: ToastGravity.CENTER,
        );
        widget.onSelectDelivery(true);
        Get.back(result: -1);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }
}