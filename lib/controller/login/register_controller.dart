import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/customer.dart';
import 'package:aksestokomobile/model/principal.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class RegisterController extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String idBK;
  String storeName;
  String email;
  String tlp;
  String firstName;
  String lastName;
  String password;
  String repeatPassword;

  List<Principal> principals;
  Principal selectPrincipal;
  var isShow = false;
  var isShowRepeatPassword = false;

  int selectedRadioTile;
  bool isValid;
  Customer customer;
  bool isApprove = false;

  @override
  void initState() {
    super.initState();
    isValid = false;
    selectedRadioTile = 0;
    principals = Principal.getPrincipals();
  }

  setSelectedPrincipal(Principal principal) {
    setState(() {
      selectPrincipal = principal;
    });
  }

  _dialogSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Berhasil"),
        content: new Text("Cek email Anda dan ikuti langkah berikutnya."),
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

  void _actionCekIDBK() async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlRegisterCheck,
      {'kode_bk': idBK},
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        var baseResponse = BaseResponse.fromJson(data);
        setState(() {
          customer = baseResponse?.data?.customer;
          isValid = true;
        });
      },
      onFailed: (title, message) {
        if (title == '400') {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Cek ID BK'));
        } else if (title == '500') {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Email tidak terdaftar'));
        } else {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Akses dibatalkan'));
        }
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  void _actionRegisterSubmit() async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlRegisterSubmit,
      {
        '': idBK,
      },
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        Get.back();
        _dialogSuccess();
      },
      onFailed: (title, message) {
        if (title == '400') {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Cek ID BK'));
        } else if (title == '500') {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Email tidak terdaftar'));
        } else {
          Get.defaultDialog(
              title: 'Kesalahan Data', content: Text('Akses dibatalkan'));
        }
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
      if (isValid) {
        if ((password?.isNotEmpty ?? false) && password == repeatPassword) {
          _actionRegisterSubmit();
        } else {
          Get.back();
          Get.defaultDialog(content: Text('Kata sandi tidak valid.'));
        }
      } else {
        _actionCekIDBK();
      }
    } else {
      Get.back();
      debugPrint("gagal");
    }
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
