import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/profile.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/update_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class UpdateProfileController extends State<UpdateProfileScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var firstNameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  Profile profile;

  Future<void> actionRefresh() async {
    await getProfile();
  }

  reInitText() {
    firstNameTextController.text = profile?.namaDepan;
    lastNameTextController.text = profile?.namaBelakang;
    emailTextController.text = profile?.email;
    phoneTextController.text = profile?.noTlp;
  }

  saveProfile() {
    MyPref.setMap('profile', profile?.toJson());
  }

  putUpdateProfile() async {
    var body = {
      'nama_toko': profile?.namaToko,
      'email': emailTextController.text,
      'no_tlp': phoneTextController.text,
      'nama_depan': firstNameTextController.text,
      'nama_belakang': lastNameTextController.text,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateProfile,
      body,
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        var newProfile = response?.data?.profile;
        newProfile?.namaToko = profile?.namaToko;
        newProfile?.kodeBk = profile?.kodeBk;
        profile = newProfile;
        Fluttertoast.showToast(
          msg: 'Data berhasil berubah',
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
      onAfter: (status) {
        saveProfile();
        reInitText();
      },
    );
    setState(() {
      status.execute();
    });
  }

  getProfile() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailProfile,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        profile = response?.data?.profile;
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
      onAfter: (status) {
        saveProfile();
        reInitText();
      },
    );
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
