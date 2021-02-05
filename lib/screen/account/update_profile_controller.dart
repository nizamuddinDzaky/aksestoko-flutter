import 'dart:io';

import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/otp_response.dart';
import 'package:aksestokomobile/model/profile.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/update_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

abstract class UpdateProfileController extends State<UpdateProfileScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var firstNameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  Profile profile;
  DateTime endOtp;
  bool isDialogShowing;

  File imageFile;

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
          msg: response?.data?.message ?? 'Data berhasil berubah',
          gravity: ToastGravity.CENTER,
        );
        getProfile();
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

  getPhoneOtp({Function(OTPResponse) onSuccess}) async {
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    var status = await ApiClient.methodGet(
      ApiConfig.urlGenerateOTP,
      params: {
        if (endOtp != null) 'phone_otp_valid_until': format.format(endOtp),
      },
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = OTPResponse.fromJson(data['data']);
        if (response != null) onSuccess?.call(response);
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

  postVerifyPhone(phoneOtp) async {
    var body = {
      'phone_otp': phoneOtp,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlVerivyOTP,
      body,
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        if (isDialogShowing) Get.back();
        getProfile();
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

  saveFile() async {
    if (imageFile == null) {
      Fluttertoast.showToast(
        msg: 'Belum ada gambar terpilih',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    Map<String, dynamic> data = {};
    Map<String, File> files = {
      'ktp': imageFile,
    };
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    var status = await ApiClient.methodPost(
      ApiConfig.urlUploadKtp,
      formData,
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Berhasil..',
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

  @override
  void initState() {
    super.initState();
    if (endOtp == null) {
      MyPref.getOtpVerPhone().then((milis) {
        if (milis != null && milis != 0)
          endOtp = DateTime.fromMillisecondsSinceEpoch(milis.toInt());
      });
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
