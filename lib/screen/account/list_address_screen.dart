import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/screen/account/addresses.dart' as listAddress;

class ListAddressScreen extends StatefulWidget {
  _ListAddressScreenState createState() => _ListAddressScreenState();
}

class _ListAddressScreenState extends State<ListAddressScreen> {
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
                    "Daftar Alamat Toko",
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Daftar alamat toko yang dimiliki atau menambah baru",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
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
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          listAddress.ListAddress(),
                          listAddress.ListAddress(),
                          listAddress.ListAddress(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                      child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: FlatButton(
                            color: MyColor.redAT,
                            child: Text(
                              'Tambah Alamat',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: (){
                              Get.toNamed(addAddressScreen);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
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

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Stack(
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
        ),
      ),
    );

  }
}