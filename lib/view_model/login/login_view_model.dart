import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/login_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginViewModel extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isShow = false;
  var isRemember = false;
  Login currentData = Login();

  actionSubmit() async {
    formKey.currentState.save();
    postLogin();
  }

  postLogin({skip}) async {
    if (skip == null) formKey.currentState.save();
    var status = await ApiClient.methodPost(
        ApiConfig.urlLogin, currentData.toJson(), {}, onBefore: (status) {
      Get.back();
    }, onSuccess: (data, _) {
      var baseResponse = BaseResponse.fromJson(data);
      Get.back();
      var valid = (baseResponse?.data?.token?.isNotEmpty ?? false);
      valid &= (baseResponse?.data?.idBK ?? 0) > 0;
      if (valid) {
        MyPref.setATToken(baseResponse?.data?.token);
        MyPref.setIdBk(baseResponse?.data?.idBK);
            Get.offNamed(selectDistributorScreen);
          }
        }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text('Login Gagal'));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
    }, onAfter: (status) {
      if (status == ResponseStatus.success)
        MyPref.setRemember(isRemember, currentData);
    });
    status.execute();
  }

  developerInit() {
    if (Foundation.kDebugMode) {
      currentData = Login(
        // username: '000001597',
        // password: 'Indonesia1',
        username: '900000010',
        password: 'Indonesia2020',
      );
    }
  }

  @override
  void initState() {
    currentData = Login(
      username: MyPref.getUsername(),
      password: MyPref.getPassword(),
    );
    isRemember = MyPref.getRemember();
    developerInit();
    FirebaseMessaging().deleteInstanceID();
    super.initState();
  }
}
