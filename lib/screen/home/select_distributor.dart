import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/helper/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:get/get.dart';

class SelectDistributorScreen extends StatefulWidget {
  @override
  _SelectDistributorScreenState createState() => _SelectDistributorScreenState();
}

class _SelectDistributorScreenState extends State<SelectDistributorScreen>{
  @override


  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 23, left: 25, right: 25, bottom: 48),
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
                padding: EdgeInsets.only(top: 80),
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 16 / 7,
                children: <Widget>[
                  productItem(),
                  productItem(),
                  productItem(),productItem(),productItem(),productItem(),
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
    );
  }

  Widget productItem() {
    return Card(
      child: Container(
        //color: Colors.blue,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 20),
                child: Image.asset(kDistributor),
              ),
            Container(
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
                        fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      'SBJ',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      'Jl. Lorem Ipsum No 40 Gresik Jawa Timur',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      '081335789789',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

