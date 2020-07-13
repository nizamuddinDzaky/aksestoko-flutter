import 'package:aksestokomobile/app/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {

    var formLayout = Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(0.40),
                  ),
                ],
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(bgHeaderTopLarge),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140,
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1),
                          color: Colors.black.withOpacity(0.20),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(kDistributor),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "Lorem Ipsum",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "youremail@mail.com",
                        style: TextStyle(fontSize: 20, color: MyColor.greyTextAT),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Color(0xffEAEAEA),
                    margin: EdgeInsets.symmetric(vertical: 40),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: (){
                                Get.toNamed(updateProfileScreen);
                              },
                              icon: Icon(Icons.account_circle),
                              label: Text(
                                "Perbarui Profil",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: () {
                                Get.toNamed(listAddressScreen);
                              },
                              icon: Icon(Icons.person_pin_circle),
                              label: Text(
                                "Daftar Alamat",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.supervised_user_circle),
                              label: Text(
                                "Sales Person",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.settings),
                              label: Text(
                                "Ganti Password",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.info),
                              label: Text(
                                "Petunjuk Penggunaan",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.live_help),
                              label: Text(
                                "Syarat dan Ketentuan",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.not_interested, color: Colors.red,),
                              label: Text(
                                "Keluar",
                                style: TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: formLayout,
    );
  }
}
