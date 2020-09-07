import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/login/login_controller.dart';
import 'package:aksestokomobile/helper/empty_app_bar.dart';
import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/helper/my_text.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginScreenController {
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    var formLayout = Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: MyDimen.marginLayout(),
                  child: TextFormField(
                    onSaved: (userName) => currentData.username = userName,
                    initialValue: currentData.username,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: 'Nama Pengguna',
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
                      errorText: 'Maksimal 30 karakter',
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
                    onSaved: (password) => currentData.password = password,
                    initialValue: currentData.password,
                    maxLength: 30,
                    obscureText: !isShow,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (val) {
                      showDialogProgress();
                    },
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: 'Kata Sandi',
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
                      errorText: 'Maksimal 30 karakter',
                      errorStyle: TextStyle(
                        color: MyColor.txtField,
                        fontStyle: FontStyle.italic,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isShow ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: MyDimen.paddingRememberPass(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Checkbox(
                            activeColor: MyColor.lineTxtField,
                            value: isRemember,
                            onChanged: (bool value) {
                              setState(() {
                                isRemember = value;
                              });
                            },
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                isRemember = !isRemember;
                              });
                            },
                            child: new Text(
                              'Ingat Saya',
                              style: new TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      CupertinoButton(
                        child: Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            color: MyColor.mainBlue,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(forgotPasswordScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: MyDimen.marginButtonLoginCustom(),
            width: double.maxFinite,
            height: 46,
            child: FlatButton(
                color: MyColor.redAT,
                child: Text(
                  'MASUK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: showDialogProgress,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Belum punya akun? '),
                CupertinoButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: MyColor.redAT,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(registerScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: EmptyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: SafeArea(
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: Get.height * 0.25,
                          child: Center(
                            child: Hero(
                              tag: 'logoForcaPoS',
                              child: MyLogo.logoForcaPoSColor(),
                            ),
                          ),
                        ),
                        formLayout,
                        Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: MyText.textBlackSmall(
                                    'Ⓒ 2020 PT SISI, All Right Reserved.'),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
