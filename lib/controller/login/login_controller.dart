import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'file:///C:/Users/hp/StudioProjects/aksestoko/lib/model/login_model.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginScreenController extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isShow = false;
  var isRemember = false;
  Login currentData = Login();

  _actionSubmit() async {
    var status = await ApiClient.methodPost(
        ApiConfig.urlLogin, currentData.toJson(), {},
        onBefore: (status) {
          Get.back();
        }, onSuccess: (data, _) {
       var baseResponse = BaseResponse.fromJson(data);
      MyPref.setForcaToken(baseResponse?.data?.token);
      MyPref.setIdBk(baseResponse?.data.idBK);
       Get.back();
       Get.offNamed(selectDistributorScreen);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
    }, onAfter: (status) {
      if (status == ResponseStatus.success)
        MyPref.setRemember(isRemember, currentData);
    });
    status.execute();
  }

  showDialogProgress() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });
    await _actionSubmit();
  }
}
