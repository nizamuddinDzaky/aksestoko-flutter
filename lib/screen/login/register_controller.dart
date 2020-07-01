import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/resource/my_image.dart';

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
  @override
  void initState(){
    super.initState();
    selectedRadioTile = 0;
    principals = Principal.getPrincipals();
  }

  setSelectedPrincipal(Principal principal){
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
      ApiConfig.urlResetPass,
      {'idBK': idBK},
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
              title: 'Kesalahan Data', content: Text('Email kosong'));
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
      _actionCekIDBK();
    } else {
      Get.back();
      print("gagal");
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

class Principal{
  int principalId;
  String name;
  String iconPrincipal1;
  String iconPrincipal2;
  String iconPrincipal3;

  Principal({this.principalId, this.name, this.iconPrincipal1, this.iconPrincipal2, this.iconPrincipal3});

  static List<Principal> getPrincipals(){
    return <Principal>[
      Principal(principalId: 1, name: "SIG", iconPrincipal1: sgIcon, iconPrincipal2: stIcon, iconPrincipal3: spIcon ),
      Principal(principalId: 2, name: "SBI", iconPrincipal1: dynamixIcon),
    ];
  }
}
