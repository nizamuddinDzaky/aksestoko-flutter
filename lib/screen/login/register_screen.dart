import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/helper/my_text.dart';
import 'package:aksestokomobile/screen/login/register_controller.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
  @override
  Widget build(BuildContext context) {
    var formLayout = Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Pendaftaran',
                    style: TextStyle(
                      color: MyColor.txtField,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Silahkan isi formulir di bawah ini untuk membuat akun. Sudah punya akun? silahkan Login.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColor.txtField,
                    ),
                  ),
                ),
                Container(
                  padding: MyDimen.marginLayout(),
                  child: TextFormField(
                    onSaved: (value) => idBK = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: 'ID BK',
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
                      errorText: 'Masukkan ID Bisnis Kokoh',
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
                      'Daftar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: showDialogProgress,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ),
              ],
            ),
          )
        ],
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
        title: Hero(
          tag: 'logoForcaPoS',
          child: MyLogo.logoForcaPoSColor(width: 150),
        ),
      ),
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
                        formLayout,
                        Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: MyText.textBlackSmall(
                                    'Ⓒ 2020 PT SISI, All Right Reserved.'),
                              )
                          ),
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
