import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() =>
      _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
//              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding:
              EdgeInsets.only(top: 23, left: 25, right: 25, bottom: 48),
              width: Get.width,
              color: Color(0xFFB20838),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Daftar Produk',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Pada Distributor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
//              margin: EdgeInsets.only(top: 102),
              //color: Colors.green,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 20,
                padding: EdgeInsets.only(top: 102),
//                padding: EdgeInsets.symmetric(vertical: 8),
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 3 / 4,
                children: <Widget>[
                  productItem(),
                  productItem(),
                  productItem(),
                  productItem(),
                  productItem(),
                  productItem(),
                  productItem(),
                  productItem(),
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
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Expanded(
            child: TextField(
              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.0),
                hintText: 'Cari Produk',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
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

  Widget productItem() {
    return Card(
      elevation:4,
      child: Container(
        //color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Expanded(
                child: Container(
                  //color: Colors.blue,
                  child: Image.asset(
                    kImageDynamix,
                    height: 140,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Semen Lorem Ipsum Dolor Ismet PCC 50 KG',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Rp 5800',
                      style: TextStyle(
                        color: Color(0xffB20838),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / SAK',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {},
                      shape: CircleBorder(),
                      child: Text('-', style: TextStyle(color: Colors.white, fontSize: 24),),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Text(
                          "5",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      color: Color(0xFF387C2B),
                      onPressed: () {},
                      shape: CircleBorder(),
//                      padding: EdgeInsets.all(5),
                      child: Text('+', style: TextStyle(color: Colors.white, fontSize: 24),),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}