import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/helper/my_text.dart';
import 'package:aksestokomobile/screen/login/register_controller.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    var formLayout = SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: 'logoForcaPoS',
                      child: MyLogo.logoForcaPoSColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Pendaftaran',
                          style: TextStyle(
                            color: MyColor.txtField,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Silahkan isi formulir di bawah ini untuk membuat akun. Sudah punya akun? silahkan Login.',
                          style: TextStyle(
                            color: MyColor.txtField,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => idBK = value,
                      keyboardType: TextInputType.text,
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
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => storeName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Nama Toko',
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
                        errorText: 'Masukkan Nama Toko Anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Nama Toko',
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
                        errorText: 'Masukkan Nama Toko Anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => tlp = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'No Telepon',
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
                        errorText: 'Gunakan No Telepon yang valid untuk menerima SMS Kode Aktivasi',
                        errorStyle: TextStyle(
                          color: MyColor.redAT,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => firstName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Nama Depan',
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
                        errorText: 'Masukan nama depan anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField ,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => lastName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
                        labelText: 'Nama Belakang',
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
                        errorText: 'Masukan nama belakang anda',
                        errorStyle: TextStyle(
                          color: MyColor.txtField ,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => password = value,
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
                        errorText: 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka',
                        errorStyle: TextStyle(
                          color: MyColor.redAT,
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
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => repeatPassword = value,
                      maxLength: 30,
                      obscureText: !isShowRepeatPassword,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (val) {
                        showDialogProgress();
                      },
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
                            isShowRepeatPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowRepeatPassword = !isShowRepeatPassword;
                            });
                          },
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
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
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
