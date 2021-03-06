import 'dart:io';

import 'package:aksestokomobile/helper/my_stateful_builder.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/screen/account/update_profile_controller.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends UpdateProfileController {
  _verifikasiNoTelepon() {
    var otpTextController = TextEditingController();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var styleBlack = TextStyle(color: MyColor.txtField, fontSize: 16);
    var styleRed = TextStyle(color: MyColor.redAT, fontSize: 16);
    var styleBlue = TextStyle(color: MyColor.blueDio, fontSize: 16);
    CountdownTimerController controller;
    isDialogShowing = true;
    return showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          child: MyStatefulBuilder(
            dispose: () {},
            builder: (_context, _setState) {
              var now = DateTime.now();
              var status = (endOtp?.millisecondsSinceEpoch ?? 0) >
                  now.millisecondsSinceEpoch;
              debugLog('status $status $now $endOtp');
              if (status)
                controller = CountdownTimerController(
                  endTime: endOtp.millisecondsSinceEpoch + 500,
                  onEnd: () {
                    debugLog('selesai timer');
                  },
                );
              var actionGetOTP = () {
                getPhoneOtp(
                  onSuccess: (otp) {
                    debugLog('kirim kode');
                    var duration = Duration(seconds: otp?.timeleft ?? 300);
                    endOtp = DateTime.now().add(duration);
                    MyPref.setOtpVerPhone(
                        endOtp.millisecondsSinceEpoch.toDouble());
                    _setState(() {});
                  },
                );
              };
              var actionTestOTP = () {
                debugLog('kirim kode');
                var duration = Duration(seconds: 10);
                endOtp = DateTime.now().add(duration);
                MyPref.setOtpVerPhone(endOtp.millisecondsSinceEpoch.toDouble());
                _setState(() {});
              };
              var timeOut = RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(style: styleBlack, text: 'Tekan '),
                    TextSpan(
                      style: styleBlue,
                      text: 'Kirim Kode',
                      recognizer: TapGestureRecognizer()
                        ..onTap = isDebugOnly ? actionTestOTP : actionGetOTP,
                    ),
                    TextSpan(
                        style: styleBlack,
                        text: ' untuk menerima kode verifikasi No Telepon'),
                  ],
                ),
              );
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Verifikasi No Telepon',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Divider(height: 0),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!status) timeOut,
                        if (controller != null && endOtp != null && status)
                          CountdownTimer(
                            controller: controller,
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time == null) {
                                return timeOut;
                              }
                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style: styleBlack, text: 'Tunggu '),
                                    TextSpan(
                                      style: styleRed,
                                      text:
                                      '${twoDigits(time.min ?? 0)}:${twoDigits(
                                          time.sec ?? 0)}',
                                    ),
                                    TextSpan(
                                        style: styleBlack,
                                        text:
                                        ' untuk dapat mengirim kode verifikasi lagi.'),
                                  ],
                                ),
                              );
                            },
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
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlineButton(
                          child: Text('Batal'),
                          shape: StadiumBorder(),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: 8),
                        RaisedButton(
                          color: MyColor.redAT,
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            postVerifyPhone(otpTextController.text);
                          },
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    ).then((value) {
      isDialogShowing = false;
      controller?.disposeTimer();
      controller?.dispose();
    });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return (profile?.imgKtp?.isEmpty ?? true)
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Belum ada gambar KTP",
                style: TextStyle(
                    color: MyColor.greyTextAT, fontStyle: FontStyle.italic),
              ),
            )
          : AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: profile?.imgKtp ?? '',
                  placeholder: (context, url) => Image.asset(kNoImageLandscape),
                  errorWidget: (context, url, error) =>
                      Image.asset(kNoImageLandscape),
                ),
              ),
            );
    } else {
      return Image.file(
        imageFile,
        width: 200,
        height: 200,
      );
    }
  }

  _processPicture(PickedFile picture) async {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[CircularProgressIndicator()],
              ),
            ),
          );
        });
    final lastIndex = picture.path.lastIndexOf(new RegExp(r'.jp'));
    final splitted = picture.path.substring(0, (lastIndex));
    final outPath = "${splitted}_out${picture.path.substring(lastIndex)}";
    imageFile = await compressAndGetFile(File(picture.path), outPath);
    setState(() {});
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    ImagePicker().getImage(source: ImageSource.gallery).then((picture) {
      if (picture != null) _processPicture(picture);
    });
  }

  _openCamera(BuildContext context) async {
    ImagePicker().getImage(source: ImageSource.camera).then((picture) {
      if (picture != null) _processPicture(picture);
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Silahkan Pilih"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var colorVerified =
        (profile?.isVerified ?? false) ? Colors.green : Colors.red;
    var formLayout = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Perbarui Profil",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(0.40),
                  ),
                ],
              ),
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: actionRefresh,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profile?.namaToko ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      Text(
                        profile?.kodeBk ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: MyColor.greyTextAT),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: firstNameTextController,
                                onSaved: (value) => profile?.namaDepan = value,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: MyDimen.paddingTxtField(),
                                  labelText: 'Nama Depan',
                                  labelStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.txtField),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.lineTxtField),
                                  ),
                                  errorText: 'Masukan Nama Depan Anda',
                                  errorStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: lastNameTextController,
                                onSaved: (value) =>
                                profile?.namaBelakang = value,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: MyDimen.paddingTxtField(),
                                  labelText: 'Nama Belakang',
                                  labelStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.txtField),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.lineTxtField),
                                  ),
                                  errorText: 'Masukan Nama Belakang Anda',
                                  errorStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: emailTextController,
                                onSaved: (value) => profile?.email = value,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: MyDimen.paddingTxtField(),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.txtField),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: MyColor.lineTxtField),
                                  ),
                                  errorText: 'Masukan Email Anda',
                                  errorStyle: TextStyle(
                                    color: MyColor.txtField,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Stack(
                                children: [
                                  TextFormField(
                                    controller: phoneTextController,
                                    onSaved: (value) => profile?.noTlp = value,
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    onChanged: (text) {
                                      phoneTextController = cursorToEnd(trimMobilePhoneNumber(text));
                                      setState(() {});
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLength: 13,
                                    decoration: InputDecoration(
                                      prefixText: '+62',
                                      contentPadding: MyDimen.paddingTxtField(),
                                      labelText: 'No. Telepon',
                                      labelStyle: TextStyle(
                                        color: MyColor.txtField,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: MyColor.txtField),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.lineTxtField),
                                      ),
                                      errorText:
                                      'Gunakan No Telepon yang valid untuk menerima SMS Kode Aktivasi',
                                      errorStyle: TextStyle(
                                        color: MyColor.redAT,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -4,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        if (profile?.phoneIsVerified != null)
                                          Icon(
                                            (profile?.isVerified == true)
                                                ? Icons.check
                                                : Icons.clear,
                                            color: colorVerified,
                                          ),
                                        Text(
                                          profile?.phoneIsVerified ?? '',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: colorVerified,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if ((profile?.phoneIsVerified != null) &&
                                !(profile?.isVerified ?? false))
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  minSize: 0,
                                  child: Text(
                                    'Verifikasi No Telepon?',
                                    style: TextStyle(color: MyColor.blueDio),
                                  ),
                                  onPressed: () {
                                    _verifikasiNoTelepon();
                                  },
                                ),
                              ),
                            MyDivider.spaceDividerLogin(custom: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: FlatButton(
                                  color: MyColor.redAT,
                                  child: Text(
                                    'Simpan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: putUpdateProfile,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0))),
                            ),
                            if (isDebugQA)
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 0, left: 15, right: 15),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Color(0xfff5f5f5),
                                    border:
                                        Border.all(color: MyColor.greyTextAT),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: <Widget>[_decideImageView()],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: double.maxFinite,
                                      height: 40,
                                      child: FlatButton(
                                        color: MyColor.redAT,
                                        shape: StadiumBorder(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5)),
                                            Text(
                                              "Pilih File",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          _showChoiceDialog(context);
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: double.maxFinite,
                                      height: 40,
                                      child: FlatButton(
                                        color: MyColor.redAT,
                                        disabledColor: Colors.grey,
                                        shape: StadiumBorder(),
                                        onPressed:
                                            imageFile == null ? null : saveFile,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.save,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5)),
                                            Text(
                                              "Simpan File KTP",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        Image.asset(
          bgLarge,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: formLayout,
          ),
        )
      ],
    );
  }
}
