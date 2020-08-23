import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/screen/home/list_product_item_screen.dart'
    as listProduct;

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
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
                      'Daftar Distributor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(selectDistributorScreen);
                      },
                      icon: Icon(
                        Icons.settings,
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
            margin: EdgeInsets.only(bottom: 100),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 20,
              padding: EdgeInsets.only(top: 102),
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 3 / 4,
              children: <Widget>[
                listProduct.ListProductScreen(),
                listProduct.ListProductScreen(),
                listProduct.ListProductScreen(),
                listProduct.ListProductScreen(),
                listProduct.ListProductScreen(),
              ],
            ),
          ),
        ],
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
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
//      floatingActionButton: Container(
//        child: FittedBox(
//          child: FloatingActionButton(
//            onPressed: null,
//            backgroundColor: MyColor.redAT,
//            child: Icon(
//              Icons.add_shopping_cart,
//              color: Colors.white,
//              size: 25,
//            ),
//          ),
//        ),
//      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric( horizontal: 15, vertical: 10 ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: MyColor.greyTextAT,
              spreadRadius: 0,
              blurRadius: 8,
              offset:
              Offset(0, 2), // changes position of shadow
            )
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(checkoutScreen);
          },
          backgroundColor: MyColor.greenAT,
          icon: Icon(Icons.payment),
          label: Text(
              "Lanjutkan",
              style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
