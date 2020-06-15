import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/empty_app_bar.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/helper/my_text.dart';
import 'package:aksestokomobile/screen/login/otp_controller.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestOtpScreen extends StatefulWidget{

  @override
  _RequestOtpScreenState createState() => _RequestOtpScreenState();

}


class _RequestOtpScreenState extends RequestOtpController{

  createAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 16,
        child: Container(
          height: 250.0,
          width: 360.0,
          child: ListView(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  margin: MyDimen.marginButtonRegister(),
                  width: double.maxFinite,
                  height: 46,
                  child: FlatButton(
                      color: MyColor.greenWhatsApp,
                      child: Text(
                        "WA +628912345678",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.toNamed(requestOtpScreen);
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: MyDimen.marginButtonRegister(),
                  width: double.maxFinite,
                  height: 46,
                  child: FlatButton(
                      color: MyColor.greyButtonOtp,
                      child: Text(
                        "SMS +628912345678",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.toNamed(requestOtpScreen);
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: MyDimen.marginButtonRegister(),
                  width: double.maxFinite,
                  height: 46,
                  child: FlatButton(
                      color: MyColor.greyButtonOtp,
                      child: Text(
                        "Mail lorem@mail.com",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.toNamed(requestOtpScreen);
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ),
                SizedBox(height: 40),
              ],
          ),
        ),
      );
    });
  }




  @override
  Widget build(BuildContext context) {
    var formLayout = Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
              key: formKey,
            child: Column(
              children: <Widget>[
                MyDivider.spaceDividerLogin(custom: 40),
                Container(
                  padding: MyDimen.marginLayout(),
                  child: TextFormField(
                    onSaved: (value) => otp = value,
                    maxLength: 30,
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: "Masukan Kode OTP",
                      labelStyle: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.txtField),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.lineTxtField,)
                      ),
                      errorText: "Masukan Kode OTP",
                      errorStyle: TextStyle(
                        color: MyColor.txtField,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                MyDivider.spaceDividerLogin(custom: 50),
                Container(
                  padding: MyDimen.marginLayout(),
                  child: Text(
                    "Estimasi 00:30",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyDivider.spaceDividerLogin(custom: 20),
                Container(
                  margin: MyDimen.marginButtonRegister(),
                  width: double.maxFinite,
                  height: 46,
                  child: FlatButton(
                    color: MyColor.redAT,
                    child: Text(
                      "Request OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                      onPressed: () {
                        createAlertDialog(context);
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );


    return Scaffold(
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
                          height: Get.height * 0.2,
                          child: Center(
                            child: Hero(
                              tag: 'logoForcaPoS2',
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