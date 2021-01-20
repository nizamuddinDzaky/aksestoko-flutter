import 'package:aksestokomobile/controller/login/forgot_pasword_controller.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/main.dart';
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

    var formLayout = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * .1),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (idForgetPassword == null)
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        child: Hero(
                          tag: 'logoForcaPoS',
                          child: MyLogo.logoForcaPoSColor(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 22),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                    ),
                    Container(
                      padding: MyDimen.marginLayout(),
                      child: TextFormField(
                        initialValue: isDebugMode ? '121212157' : null,
                        onSaved: (value) => idBisnisKokoh = value,
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
                        initialValue: isDebugMode ? '3388' : null,
                        onSaved: (value) => phoneDigit = value,
                        keyboardType: TextInputType.phone,
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
                            'Lanjut',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            showDialogProgress();
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                  ],
                ),
              ),
            if (idForgetPassword != null)
              Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                      child: Hero(
                        tag: 'logoForcaPoS',
                        child: MyLogo.logoForcaPoSColor(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Silakan atur kata sandi baru Anda.',
                      style: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: MyDimen.marginLayout(),
                    child: TextFormField(
                      controller: passInputController,
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if (!validateStructure(text)) {
                          return 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Masukkan Password',
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
                      ),
                    ),
                  ),
                  MyDivider.spaceDividerLogin(),
                  Container(
                    padding: MyDimen.marginLayout(),
                    child: TextFormField(
                      controller: repeatInputController,
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if (!validateStructure(text,
                            repeat: passInputController.text)) {
                          return 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Ulangi Password',
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
                          'Reset Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          actionResetPassword();
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                ],
              ),
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
