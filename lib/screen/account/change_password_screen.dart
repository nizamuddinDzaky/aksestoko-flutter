import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/screen/account/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ChangePasswordController {
  @override
  Widget build(BuildContext context) {

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
                    "Ganti Password",
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 50),
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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              onSaved: (value) => oldPassword = value,
                              maxLength: 30,
                              obscureText: !isOldPassword,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Password Lama',
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

                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isOldPassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isOldPassword = !isOldPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40),
                            child: TextFormField(
                              onSaved: (value) => newPassword = value,
                              maxLength: 30,
                              obscureText: !isNewPassword,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Password Baru',
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
                                errorText: 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka',
                                errorStyle: TextStyle(
                                  color: MyColor.redAT,
                                  fontStyle: FontStyle.italic,
                                ),

                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isNewPassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isNewPassword = !isNewPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => repeatPassword = value,
                              maxLength: 30,
                              obscureText: !isRepeatPassword,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Ulangi Kata Sandi',
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

                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isRepeatPassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isRepeatPassword = !isRepeatPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FlatButton(
                                color: MyColor.redAT,
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: (){},
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0))),
                          ),
                          Padding(padding: EdgeInsets.only(top: 30)),
                        ],
                      ),
                    ),
                  ],
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
          bgProfile,
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