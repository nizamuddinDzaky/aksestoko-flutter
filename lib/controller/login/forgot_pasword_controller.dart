import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/forgot_password_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

abstract class ForgotPasswordController extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String idBisnisKokoh;
  String phoneDigit;
  String email;
  String idForgetPassword;
  var passInputController = TextEditingController();
  var repeatInputController = TextEditingController();

  void _actionResetPassword() async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlResetPass,
      {
        'kode_bk': idBisnisKokoh,
        'no_tlp': phoneDigit,
      },
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        chooseService(
            id: data['data']['id_forget_password'],
            service: data['data']['service'].cast<String>());
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  bool _validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _actionSubmit() async {
    if (_validateAndSave()) {
      _actionResetPassword();
    } else {
      Get.back();
      debugPrint("gagal");
    }
  }

  showDialogProgress({step = 0, data}) async {
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
    if (step == 1) {
      await postSendOTP(data);
    } else if (step == 2) {
      await postCheckOTP(data);
    } else if (step == 3) {
      await postChangePassword();
    } else {
      await _actionSubmit();
    }
  }

  postSendOTP(data) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlSendOTP,
      data,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        showInputOTP(data);
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
    status.execute();
  }

  chooseService({id, service = const ['SMS', 'WA']}) {
    Get.defaultDialog(
      title: 'Kirim OTP',
      middleText: 'Silakan pilih layanan untuk mengirimkan kode OTP.',
      content: Column(
        children: [
          Text(
            'Silakan pilih layanan untuk mengirimkan kode OTP.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          ...service.map((e) {
            return FlatButton(
                color: MyColor.greenWhatsApp,
                child: Text(
                  e?.toString()?.toUpperCase() ?? '',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialogProgress(step: 1, data: {
                    'id_forget_password': id,
                    'service': e,
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)));
          }).toList(),
        ],
      ),
      textCancel: 'Tutup',
    );
  }

  showInputOTP(data) {
    var date = "2020-10-27 09:49:00";
    date = DateFormat("dd MMM yy HH:mm")
        .format(DateTime.tryParse(date)?.add(Duration(minutes: 5)));
    var otpTextController = TextEditingController();
    Get.defaultDialog(
      title: 'Reset Password',
      content: Column(
        children: [
          Text(
            'Kode OTP valid sampai dengan',
            textAlign: TextAlign.center,
          ),
          Text(
            date ?? '',
            textAlign: TextAlign.center,
          ),
          TextFormField(
            controller: otpTextController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 5,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              hintText: 'Kode OTP',
              hintStyle: TextStyle(
                fontSize: 24,
              ),
              counter: Container(),
            ),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      textConfirm: 'Cek OTP',
      confirmTextColor: Colors.white,
      onConfirm: () {
        var otp = otpTextController.text;
        actionCheckOTP(otp, data);
      },
    );
  }

  actionCheckOTP(otp, data) {
    if (otp.length < 5) {
      Fluttertoast.showToast(
        msg: 'OTP wajib 5 digit',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    var fields = {
      'otp': otp,
    }..addAll(data);
    showDialogProgress(step: 2, data: fields);
  }

  postCheckOTP(fields) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlCheckOTP,
      fields,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        Get.until((route) => route.settings.name == forgotPasswordScreen);
        setState(() {
          idForgetPassword = fields['id_forget_password']?.toString();
        });
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
    status.execute();
  }

  actionResetPassword() {
    String msg;
    if (passInputController.text?.isEmpty ?? false) {
      msg = 'Password tidak boleh kosong';
    } else if (repeatInputController.text?.isEmpty ?? false) {
      msg = 'Harap ulangi password Anda';
    } else if (passInputController.text != repeatInputController.text) {
      msg = 'Pastikan password kolom 1 dan 2 sama';
    } else if (!validateStructure(passInputController.text)) {
      msg =
          'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka';
    }
    if (msg != null) {
      Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    showDialogProgress(step: 3);
  }

  bool validateStructure(String value, {String repeat}) {
    // String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value) && (repeat ?? value) == value;
  }

  postChangePassword() async {
    var fields = {
      'id_forget_password': idForgetPassword,
      'password_baru': passInputController.text,
      'ulangi_password_baru': repeatInputController.text,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlChangePassword,
      fields,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Reset password berhasil.',
          gravity: ToastGravity.CENTER,
        );
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
    status.execute();
  }
}
