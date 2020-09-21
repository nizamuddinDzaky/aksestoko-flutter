import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/helper/my_logo.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Berhasil",
                  style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Center(
                child:
                    Image.asset(atSuccessIcon, height: 200, fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Terimakasih atas pemesanan Anda. Segera lakukan penerimaaan barang di menu Pemesanan ketika barang telah sampai di toko Anda",
                  style: TextStyle(color: MyColor.greyTextAT, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.greyTextAT,
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "ID Pemesanan",
                            style: TextStyle(
                                fontSize: 16, color: MyColor.greyTextAT),
                          ),
                        ),
                        Container(
                          child: Text(
                            "SALE/AT/2020/06/0003",
                            style: TextStyle(
                                fontSize: 16,
                                color: MyColor.greyTextAT,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Cara Pembayaran",
                            style: TextStyle(
                                fontSize: 16, color: MyColor.greyTextAT),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Tempo Dengan Distributor",
                            style: TextStyle(
                                fontSize: 16,
                                color: MyColor.greyTextAT,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 50),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: MyColor.redAT,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Get.toNamed(parentScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Hero(
            tag: 'logoForcaPoS',
            child: MyLogo.logoATWhite(width: 100),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  debugPrint('klik notif');
                },
              ),
              Positioned(
                right: 5,
                top: 4,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: MyColor.redAT,
                  child: Text(
                    '20',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
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
