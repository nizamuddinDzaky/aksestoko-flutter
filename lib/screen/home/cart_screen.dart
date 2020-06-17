import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/helper/my_logo.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() =>
      _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                padding: EdgeInsets.only(top: 20),
                physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 16 / 9,
                children: <Widget>[
                  listProductCart(),
                  listProductCart(),
                  listProductCart(),
                  listProductCart(),
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
          child: Text("Keranjang"),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: formLayout,
      ),
      bottomNavigationBar: new Stack(
        overflow: Overflow.visible,
//        alignment: new FractionalOffset(.5, 1.0),
        children: [
          new Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 9), // changes position of shadow
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          "RP 200.000.000.000",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left:0),
                    width: double.maxFinite,
                    height: 50,
                    child: RaisedButton(
                      color: MyColor.redAT,
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: (){
                        print('You tapped on RaisedButton');
                      },
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                    ),
//                    alignment: FractionalOffset(1.0, 0),
                  ),
                )
              ],
            
            ),
          ),
        ],
      ),
    );
  }

  Widget listProductCart() {
    return Card(
      elevation: 4,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Image.asset(kImageDynamix),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Semen PCC Lorem Ipsum 50 KG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff999999),
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              '121-301-0060',
                              style:
                              TextStyle(color: Color(0xff999999), fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Harga',
                                        style:
                                        TextStyle(color: Color(0xff999999), fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Rp 60.000',
                                        style:
                                        TextStyle(color: Color(0xff333333), fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        'Jumlah',
                                        style:
                                        TextStyle(color: Color(0xff999999), fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '5 SAK',
                                        style:
                                        TextStyle(color: Color(0xff333333), fontSize: 16, fontWeight: FontWeight.bold),
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide( //                   <--- left side
                  color: MyColor.greyAT,
                  width: 3.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SUBTOTAL",
                  style: TextStyle(color: Color(0xff999999), fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp 10.000.000",
                  style: TextStyle(color: Color(0xff333333), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
