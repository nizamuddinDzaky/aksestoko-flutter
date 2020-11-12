import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/change_password_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class ChangePasswordViewModel extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKeyChangePassword = GlobalKey<FormState>();
  String oldPassword;
  String newPassword;
  String repeatPassword;

  var isOldPassword = false;
  var isNewPassword = false;
  var isRepeatPassword = false;

  actionChangePassword(){

    formKeyChangePassword.currentState.save();
    if(newPassword.compareTo(repeatPassword) == -1){
      Fluttertoast.showToast(
        msg: 'Password baru dan Ulangi password baru tidak sama',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if(!formKeyChangePassword.currentState.validate()){
      Fluttertoast.showToast(
        msg: 'Data Belum Valid, Harap Periksa Kembali',
        gravity: ToastGravity.CENTER,
      );
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
    _postChangePassword();
    /*debugPrint("adsadsa $newPassword => $oldPassword => $repeatPassword }");*/
  }

  _postChangePassword() async{

    var body = {
      'password_lama': oldPassword,
      'password_baru': newPassword,
      'ulangi_password_baru': repeatPassword
    };

    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdatePassword,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        /*Get.back();*/
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        Fluttertoast.showToast(
          msg: baseResponse?.message ?? 'Berhasil',
          gravity: ToastGravity.CENTER,
        );
        /*Fluttertoast.showToast(
          msg: 'Tambah alamat sukses',
          gravity: ToastGravity.CENTER,
        );*/
        Navigator.of(context, rootNavigator: true).pop();
        /*Get.back(result: -1);*/
        Get.back();
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
        Get.back();
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
        Get.back();
      },
      onAfter: (status) {},
    );
    status.execute();
  }
}