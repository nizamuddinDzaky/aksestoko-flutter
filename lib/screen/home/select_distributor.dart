import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/view_model/home/select_distributor_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/screen/home/list_distributor_screen.dart';
import 'package:get/get.dart';

class SelectDistributorScreen extends StatefulWidget {
  @override
  _SelectDistributorScreenState createState() =>
      _SelectDistributorScreenState();
}

class _SelectDistributorScreenState extends SelectDistributorViewModel {
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 16),
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 23, left: 25, right: 25, bottom: 48),
              width: MediaQuery.of(context).size.width * 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgHeaderTop),
                  fit: BoxFit.cover,
                ),
              ),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listDistributor.length,
                itemBuilder: (context, index) => ListDistributorScreen()
                    .listItem(context, listDistributor[index], index),
                padding: EdgeInsets.only(top: 65),
                physics: NeverScrollableScrollPhysics(),
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
        leading: canBack == false
            ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(loginScreen);
            })
            : null,
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
