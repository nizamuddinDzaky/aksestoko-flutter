import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/screen/login/login_model.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginScreenController extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isShow = false;
  var isRemember = false;
  Login currentData = Login();

  _actionSubmit() async {
    await Future.delayed(Duration(seconds: 2));
    Get.back();
    Get.offNamed(selectDistributorScreen);
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
