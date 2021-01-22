import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/customer.dart';
import 'package:aksestokomobile/model/principal.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/login/register_screen.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String salesCode;
  var storeNameTextController = TextEditingController();
  var firstNameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();

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

  bool validatePassword(String value, {String repeat}) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value) && (repeat ?? value) == value;
  }

  bool validatePhone(String value) {
    String pattern = r'^(?:[+0]62)?[0-9]{10,12}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  setSelectedPrincipal(Principal principal) {
    setState(() {
      selectPrincipal = principal;
    });
  }

  _dialogSuccess() {
    Get.until((route) => route.settings.name == loginScreen);
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Berhasil Dikirim"),
        content:
            new Text("Cek informasi aktivasi dan ikuti langkah berikutnya."),
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
          _initTextValue();
          isValid = true;
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

  void _actionRegisterSubmit() async {
    var fields = {
      'kode_bk': idBK,
      'nama_depan': firstName,
      'nama_belakang': lastName,
      'email': email,
      'nama_toko': storeName,
      'password': password,
      'ulangi_password': repeatPassword,
      'no_tlp': tlp,
      'registed_by': selectPrincipal?.name,
      'sales_person': salesCode,
    };
    debugLog('cek fields $fields');
    var status = await ApiClient.methodPost(
      ApiConfig.urlRegisterSubmit,
      fields,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        if (data == null) return;
        if (data['data'] == null) return;
        if (data['data']['user_id'] == null) return;
        onSuccessSubmit(data['data']['user_id']);
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
      debugLog("gagal");
      Fluttertoast.showToast(msg: 'Periksa data kembali');
    }
  }

  showDialogProgress({int step = 0}) async {
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
      await getGenerateEmail();
    } else {
      await _actionSubmit();
    }
  }

  getGenerateEmail() async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlGenerateEmail,
      {
        'kode_bk': idBK,
      },
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        debugLog('cek $data');
        if (data != null &&
            data['data'] != null &&
            data['data']['email'] != null) {
          emailTextController.text = data['data']['email'];
        }
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

  _initTextValue() {
    storeNameTextController.text = customer?.storeName;
    firstNameTextController.text = customer?.firstname;
    lastNameTextController.text = customer?.lastname;
    emailTextController.text = customer?.email;
    phoneTextController.text = customer?.handphone;
  }

  onSuccessSubmit(userId) {
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
            initialValue: tlp,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headline5,
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
        _postSendCode(userId);
      },
    );
  }

  _postSendCode(userId) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlSendCode,
      {
        'user_id': userId,
        'no_tlp': tlp,
      },
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
}
