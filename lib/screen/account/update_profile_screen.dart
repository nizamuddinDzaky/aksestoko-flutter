import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/screen/account/update_profile_controller.dart';
import 'package:aksestokomobile/helper/my_divider.dart';

class UpdateProfileScreen extends StatefulWidget {
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends UpdateProfileController {
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
                    "Perbarui Profile",
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
                              margin: EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: phoneTextController,
                                onSaved: (value) => profile?.noTlp = value,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
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
                                    borderSide:
                                    BorderSide(color: MyColor.lineTxtField),
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
                            MyDivider.spaceDividerLogin(custom: 22),
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
                            MyDivider.spaceDividerLogin(custom: 22),
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
