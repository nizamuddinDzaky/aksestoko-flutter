import 'package:aksestokomobile/app/my_router.dart';/**/
import 'package:aksestokomobile/controller/login/forgot_pasword_controller.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ForgotPasswordController {
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    var formLayout = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * .1),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                      child: Hero(
                        tag: 'logoForcaPoS',
                        child: MyLogo.logoForcaPoSColor(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    margin: EdgeInsets.symmetric(horizontal: 30),
//                  child: Text(
//                    'Masukan email yang terdaftar di akun POS Anda dan kami akan '
//                        'mengirimkan email untuk mengatur ulang kata sandi Anda.',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      color: MyColor.txtField,
//                    ),
//                  ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    child: TextFormField(
                      onSaved: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'ID Bisnis Kokoh',
                        labelStyle: TextStyle(
                          color: MyColor.txtField,
                          fontWeight: FontWeight.bold,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColor.txtField),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColor.lineTxtField),
                        ),
                        errorText: 'Masukkan ID Bisnis Kokoh Anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  MyDivider.spaceDividerLogin(),
                  Container(
                    padding: MyDimen.marginLayout(),
                    child: TextFormField(
                      onSaved: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: '4 Digit Terakhir No Telepon',
                        labelStyle: TextStyle(
                          color: MyColor.txtField,
                          fontWeight: FontWeight.bold,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColor.txtField),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyColor.lineTxtField),
                        ),
                        errorText: 'Masukan 4 Digit No Telepon Anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  MyDivider.spaceDividerLogin(custom: 22),
                  Container(
                    margin: MyDimen.marginButtonRegister(),
                    width: double.maxFinite,
                    height: 46,
                    child: FlatButton(
                        color: MyColor.redAT,
                        child: Text(
                          'Perbarui Kata Sandi',
                          style: TextStyle(color: Colors.white),
                        ),
//                    onPressed: showDialogProgress,
                        onPressed: () {
                          Get.toNamed(requestOtpScreen);
                        },
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColor.lineTxtField,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: formLayout,
      ),
    );
  }
}
