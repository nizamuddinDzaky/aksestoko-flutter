import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/helper/my_divider.dart';

class CheckoutScreen extends StatefulWidget{
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>{
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
  var formLayout = SingleChildScrollView(
    child: Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 15,),
                  child: Text(
                    "Alamat Pengiriman",
                    style: TextStyle(color: MyColor.blackTextAT, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: MyColor.greyTextAT,
                  spreadRadius: 0,
                  blurRadius: 8 ,
                  offset: Offset(0, 2), // changes position of shadow
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.location_on,color: MyColor.redAT,),
                      ),
                      Text(
                        "PT Lorem Ipsum",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15,bottom: 10,left: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Nama Lengkap, ",
                          style: TextStyle(fontSize: 18, color: MyColor.greyTextAT),
                        ),
                      ),
                      Container(
                        child: Text(
                          "08912321313",
                          style: TextStyle(fontSize: 18, color: MyColor.greyTextAT),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10,left: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Jl. Lorem Ipsum Dolor Ismet No 29, Lorem Ipsum Dolor Ismet Kabupaten Gresik Jawa Timur Indonesia",
                          style: TextStyle(fontSize: 18, color: MyColor.greyTextAT),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyDivider.spaceDividerLogin(custom: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: MyColor.redAT,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    child: Text(
                      "Ganti Alamat",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5,),
                      child: Text(
                        "Tanggal Ekspetasi Pengiriman",
                        style: TextStyle(color: MyColor.blackTextAT, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: Text(
                          "Pemesanan di atas jam 12 siang dan tanggal ekspetasi pada hari itu juga akan, berpotensi dikirimkan di hari selanjutnya.",
                          style: TextStyle(color: MyColor.greyTextAT, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          bottom: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          left: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          right: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 0
                          ),
                        ),
                      ),
                      child: Icon(Icons.date_range,color: MyColor.redAT,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          hintText: "(DD/MM/YYYY)",
                          contentPadding: const EdgeInsets.only(left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColor.redAT, width: 1),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
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
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5,),
                      child: Text(
                        "Catatan",
                        style: TextStyle(color: MyColor.blackTextAT, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEEEEEE),
                    hintText: "Catatan",
                    contentPadding: const EdgeInsets.only(left: 20,top: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColor.redAT, width: 1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5,),
                      child: Text(
                        "Tanggal Ekspetasi Pengiriman",
                        style: TextStyle(color: MyColor.blackTextAT, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          bottom: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          left: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 2
                          ),
                          right: BorderSide(
                              color: Color(0xffC8C8C8),
                              width: 0
                          ),
                        ),
                      ),
                      child: Icon(Icons.date_range,color: MyColor.redAT,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          hintText: "(DD/MM/YYYY)",
                          contentPadding: const EdgeInsets.only(left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColor.redAT, width: 1),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
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
        ],
      ),
    ),
  );



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Expanded(
            child: Container(
              child: Text("Checkout"),
            ),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  print('klik notif');
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed(cartScreen);
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
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

      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: null,
            backgroundColor: MyColor.redAT,
            child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 25,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Distributor'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Promo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Pesanan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Akun'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25,
        currentIndex: _currentIndex,
        selectedItemColor: MyColor.redAT,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}