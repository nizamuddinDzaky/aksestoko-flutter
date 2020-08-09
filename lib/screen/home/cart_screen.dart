import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  bool CheckBoxValue = false;

  @override
  Widget build(BuildContext context) {
    var formLayout = SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'logoForcaPoS',
          child: Text("Keranjang"),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.white,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: CheckBoxValue,
                      onChanged: (bool value) {
                        setState(() {
                          CheckBoxValue = value;
                        });
                      },
                    ),
                    Text("Pilih Semua"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      child: CupertinoButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 2),
                              child: Text(
                                'Hapus',
                                style: TextStyle(
                                    color: MyColor.blackTextAT,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '(1)',
                              style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          "Rp 200.000.000.000",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 0),
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
                      onPressed: () {
                        Get.toNamed(checkoutScreen);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
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
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 5, left: 0, bottom: 0),
            child: Checkbox(
              value: CheckBoxValue,
              onChanged: (bool value) {
                setState(() {
                  CheckBoxValue = value;
                });
              },
            ),
            alignment: Alignment(-1.0, 0.0),
          ),
          Expanded(
            child: Container(
              //color: Colors.blue,
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Semen PCC Lorem Ipsum 50 KG',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff333333),
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: MyColor.redAT,
                                    ),
                                    onPressed: null),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              '121-301-0060',
                              style: TextStyle(
                                  color: Color(0xff999999), fontSize: 16),
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
                                        style: TextStyle(
                                            color: Color(0xff999999),
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Rp 60.000',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: RaisedButton(
                                        color: Color(0xFF387C2B),
                                        shape:
                                        CircleBorder(),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.white, fontSize: 24),
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          int currentValue = int.parse(_controller.text);
                                          setState(() {
                                            print("tes minus");
                                            currentValue--;
                                            _controller.text = (currentValue > 0 ? currentValue : 0).toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18, color: Color(0xFF333333),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(0.0),
                                            ),
                                            controller: _controller,
                                            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true,),
                                            inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: RaisedButton(
                                        color: Color(0xFF387C2B),
                                        shape: CircleBorder(),
                                        child: Text(
                                          '+',
                                          style: TextStyle(color: Colors.white, fontSize: 24),
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          int currentValue = int.parse(_controller.text);
                                          setState(() {
                                            currentValue++;
                                            _controller.text = (currentValue).toString();
                                          });
                                        },
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  //                   <--- left side
                  color: MyColor.greyAT,
                  width: 3.0,
                ),
              ),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "SUBTOTAL",
                    style: TextStyle(
                        color: Color(0xff999999), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp 10.000.000",
                    style: TextStyle(
                        color: Color(0xff333333), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
