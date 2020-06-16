import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';

class SelectDistributorScreen extends StatefulWidget {
  @override
  _SelectDistributorScreenState createState() =>
      _SelectDistributorScreenState();
}

class _SelectDistributorScreenState extends State<SelectDistributorScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 23, left: 25, right: 25, bottom: 48),
              width: Get.width,
              color: Color(0xFFB20838),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Daftar Distributor",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                padding: EdgeInsets.only(top: 65),
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 16 / 7,
                children: <Widget>[
                  listDistributor(),
                  listDistributor(),
                  listDistributor(),
                  listDistributor(),
                  listDistributor(),
                  listDistributor(),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColor.lineTxtField,
        ),
//        brightness: Brightness.light,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'logoForcaPoS',
          child: MyLogo.logoATWhite(width: 100),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: formLayout,
      ),
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

  Widget listDistributor() {
    return Card(
      elevation:2,
      child: InkWell(
        child: Container(
          //color: Colors.blue,
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(kDistributor),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Distributor Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff999999),
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          'SBJ',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Text(
                          'Jl. Lorem Ipsum No 40 Gresik Jawa Timur',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          '081335789789',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          Get.toNamed(selectProductScreen);
        },
      ),
    );
  }
}
