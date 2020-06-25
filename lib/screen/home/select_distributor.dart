import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/screen/home/list_distributor_screen.dart'
    as listDistributor;

class SelectDistributorScreen extends StatefulWidget {
  @override
  _SelectDistributorScreenState createState() =>
      _SelectDistributorScreenState();
}

class _SelectDistributorScreenState extends State<SelectDistributorScreen>
    with SingleTickerProviderStateMixin {
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
                  listDistributor.ListDistributorScreen(),
                  listDistributor.ListDistributorScreen(),
                  listDistributor.ListDistributorScreen(),
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
}
