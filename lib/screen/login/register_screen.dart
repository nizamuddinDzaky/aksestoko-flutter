import 'package:aksestokomobile/helper/my_divider.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/controller/login/register_controller.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/model/principal.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
  List<Widget> createRadioListPrincipals() {
    List<Widget> widgets = [];
    for (Principal principal in principals) {
      widgets.add(RadioListTile(
        value: principal,
        groupValue: selectPrincipal,
        title: Row(
          children: <Widget>[
            Text(principal.name),
            Padding(padding: EdgeInsets.only(left: 5)),
            if (principal.iconPrincipal1 != null)
              Image.asset(
                principal.iconPrincipal1,
                height: 30,
              ),
            Padding(padding: EdgeInsets.only(left: 5)),
            if (principal.iconPrincipal2 != null)
              Image.asset(
                principal.iconPrincipal2,
                height: 30,
              ),
            Padding(padding: EdgeInsets.only(left: 5)),
            if (principal.iconPrincipal3 != null)
              Image.asset(
                principal.iconPrincipal3,
                height: 30,
              ),
          ],
        ),
        onChanged: (currentPrincipal) {
          debugLog("${currentPrincipal.name}");
          setSelectedPrincipal(currentPrincipal);
        },
        selected: selectPrincipal == principal,
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listField = [
      Container(
        padding: MyDimen.marginLayout(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: storeNameTextController,
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
        child: Stack(
          children: [
            TextFormField(
              controller: emailTextController,
              onSaved: (value) => email = value,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: MyDimen.paddingTxtField(),
                labelText: 'Alamat E-mail',
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
                errorText: 'Masukkan Email',
                errorStyle: TextStyle(
                  color: MyColor.txtField,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                child: Text(
                  'Generate E-mail',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                onPressed: () {
                  showDialogProgress(step: 1);
                },
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: MyDimen.marginLayout(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: phoneTextController,
          onSaved: (value) => tlp = value,
          keyboardType: TextInputType.text,
          validator: (text) {
            if (!validatePhone(text)) {
              return 'Masukkan no telepon yang valid';
            }
            return null;
          },
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
            errorText:
                'Gunakan No Telepon yang valid untuk menerima SMS Kode Aktivasi',
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
          controller: firstNameTextController,
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
          controller: lastNameTextController,
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
          onSaved: (value) => password = value,
          maxLength: 30,
          obscureText: !isShow,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (val) {
            showDialogProgress();
          },
          validator: (text) {
            if (!validatePassword(text)) {
              return 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka';
            }
            return null;
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
            errorText:
                'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka',
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
          validator: (text) {
            if (!validatePassword(text, repeat: password)) {
              return 'Kata Sandi minimal 8 karakter kombinasi dari huruf besar, huruf kecil dan angka';
            }
            return null;
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
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Didaftarkan Oleh",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: MyColor.txtField),
            ),
            Icon(
              Icons.info,
              color: MyColor.redAT,
              size: 20,
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          children: createRadioListPrincipals(),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Punya kode referal Salesperson ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MyColor.txtField),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onSaved: (value) => salesCode = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: MyDimen.paddingTxtField(),
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
                        errorText:
                        'Silahkan isi jika memiliki kode sales, jika tidak ada silahkan lewati',
                        errorStyle: TextStyle(
                          color: MyColor.txtField,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Checkbox(
                value: isApprove,
                onChanged: (bool value) {
                  setState(() {
                    isApprove = value;
                  });
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: RichText(
                text: TextSpan(
                  text: 'Saya sudah membaca dan menyetujui ',
                  style: TextStyle(color: MyColor.txtField, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Syarat dan Ketentuan ',
                        style: TextStyle(color: MyColor.redAT)),
                    TextSpan(
                      text: '& ',
                    ),
                    TextSpan(
                        text: 'Kebijakan Privasi',
                        style: TextStyle(color: MyColor.redAT)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

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
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              style: TextStyle(color: MyColor.txtField),
                              text:
                              'Silahkan isi formulir di bawah ini untuk membuat akun. Sudah punya akun? Silahkan '),
                          TextSpan(
                            style: TextStyle(color: Colors.blue),
                            text: 'login',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                          ),
                          TextSpan(
                            style: TextStyle(color: MyColor.txtField),
                            text: '.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: MyDimen.marginLayout(),
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      initialValue: isDebugMode ? '900000010' : null,
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
                  if (isValid) ...listField,
                  MyDivider.spaceDividerLogin(custom: 22),
                  Container(
                    margin: MyDimen.marginButtonRegister(),
                    width: double.maxFinite,
                    height: 46,
                    child: FlatButton(
                        color: MyColor.redAT,
                        disabledColor: Colors.grey[300],
                        child: Text(
                          isValid ? 'Daftar' : 'Cek Kode BK',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed:
                            (!isValid || isApprove) ? showDialogProgress : null,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                  MyDivider.spaceDividerLogin(custom: 22),
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
