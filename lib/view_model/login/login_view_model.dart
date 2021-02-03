import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/login_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/login_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  List<String> checkMessage(String msg) {
    var key = 'telepon : ';
    if ((msg?.toLowerCase()?.contains(key) ?? false) &&
        (msg.toLowerCase().split(key)?.length ?? 0) == 2) {
      var data = msg.toLowerCase().split(key).last;
      return data
          .toLowerCase()
          .split('user id :')
          .map((e) => e.replaceAll(RegExp(r'[^0-9]'), ''))
          .toList();
    }
    return null;
  }

  onSuccessSubmit(userId, String tlp) {
    var controller = TextEditingController(text: tlp);
    Get.defaultDialog(
      title: 'Kirim Kode Aktivasi',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Kirim ke nomor telepon berikut',
            textAlign: TextAlign.center,
          ),
          TextFormField(
            controller: controller,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
            decoration: InputDecoration(
              hintText: 'Nomor Telepon',
            ),
          ),
        ],
      ),
      textConfirm: 'Kirim',
      confirmTextColor: Colors.white,
      textCancel: 'Tutup',
      onConfirm: () {
        _postSendCode(userId, controller.text);
      },
    );
  }

  _postSendCode(userId, tlp) async {
    var body = {
      'user_id': userId,
      'no_tlp': tlp,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlSendCode,
      body,
      {},
      customHandle: true,
      onSuccess: (data, _) {
        _dialogSuccess();
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
    );
    setState(() {
      status.execute();
    });
  }

  _dialogSuccess() {
    Get.until((route) => route.settings.name == loginScreen);
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Berhasil Dikirim"),
        content: Text("Cek informasi aktivasi dan ikuti langkah berikutnya."),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Ya",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  postLogin({skip}) async {
    if (skip == null) formKey.currentState.save();
    var status = await ApiClient.methodPost(
      ApiConfig.urlLogin,
      currentData.toJson(),
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        var baseResponse = BaseResponse.fromJson(data);
        Get.back();
        var valid = (baseResponse?.data?.token?.isNotEmpty ?? false);
        valid &= (baseResponse?.data?.idBK ?? 0) > 0;
        if (valid) {
          MyPref.setATToken(baseResponse?.data?.token);
          MyPref.setIdBk(baseResponse?.data?.idBK);
          Get.offNamed(selectDistributorScreen);
        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        var msg = response?.message;
        var result = checkMessage(msg);
        if (result != null) {
          onSuccessSubmit(result.last, result.first);
        } else {
          Get.defaultDialog(
            title: 'Kesalahan',
            content: Text(response?.message ?? 'Login Gagal'),
          );
        }
      },
      onError: (title, message) {
        Get.defaultDialog(
          title: 'Kesalahan',
          content: Text('Terjadi kesalahan data / koneksi'),
        );
      },
      onAfter: (status) {
        if (status == ResponseStatus.success)
          MyPref.setRemember(isRemember, currentData);
      },
    );
    status.execute();
  }

  developerInit() {
    if (isDebugMode) {
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
