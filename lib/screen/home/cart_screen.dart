import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/Product.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_number.dart';
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


  @override
  void initState() {
    super.initState();
    /*_controller.text = "0"; */// Setting the initial value for the field.
  }

  // ignore: non_constant_identifier_names
  bool CheckBoxValue = false;
  Widget formLayout(SelectProductController controller){
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: controller.listCart == null || controller.listCart.length < 1 ?
              new Text('Keranjang Kosong') : _gridCart(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCart(SelectProductController controller){
    return ListView.builder(
        itemCount: controller.listCart.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)=>listProductCart(controller.listCart[index], controller)
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectProductController>(
        builder: (controller) => _rootView(controller),
    );
  }

  Widget _rootView(SelectProductController controller) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'logoForcaPoS',
          child: Text("Keranjang"),
        ),
        bottom: controller.listCart?.isEmpty ?? true ? null : PreferredSize(
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
                              '(${controller.listCart?.length})',
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

        child: formLayout(controller),
        // child: GetBuilder<SelectProductController>(
        //   builder: (controller) => formLayout(controller),
        // ),
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
                          "${MyNumber.toNumberRpStr(controller.getTotalHarga().toString())}",
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

  Widget listProductCart(Product _product, SelectProductController controller) {
    TextEditingController _controller = TextEditingController();
    _controller.text = _product.qty.toInt().toString();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: MyColor.greyAT,
                            width: 3.0,
                          ),
                        ),
                      ),
                      height: 40,
                      margin: EdgeInsets.only(top: 5, left: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Checkbox(
                            value: CheckBoxValue,
                            onChanged: (bool value) {
                              setState(() {
                                CheckBoxValue = value;
                              });
                            },
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: MyColor.redAT,
                                size: 20,
                              ),
                              onPressed: () {
                                controller.removeCart(_product);
                              }
                          ),
                        ],
                      ),
                      alignment: Alignment(-1.0, 0.0),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 120,
//                color: Colors.amber,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
//                        width image
                        child: Image.asset(
                          kImageDynamix,
                          width: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                            children: [
                              Container(
                                  height: 70,
//                                color: Colors.blue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 5,),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${_product.nama}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff333333),
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              _product.kodeUnit,
                                              style: TextStyle(
                                                  color: Color(0xff999999), fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                height: 40,
//                                color: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              'Harga',
                                              style: TextStyle(
                                                  color: Color(0xff999999),
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${MyNumber.toNumberRpStr(_product.satuanHargaCash)}',
                                              style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                height: 20,
                                                width: 20,
                                                child: FittedBox(
                                                  child: FloatingActionButton(
                                                    heroTag: "btnMinus${_product.nama}",
                                                    backgroundColor: Color(0xFF387C2B),
                                                    onPressed: () {
                                                      controller.reduceCart(_product);
                                                    },
                                                    child: Icon(Icons.remove),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                width: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 14, color: Color(0xFF333333),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(0.0),
                                                    border: InputBorder.none,
                                                  ),
                                                  controller: _controller,
                                                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true,),
                                                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                                                ),
                                              ),

                                              Container(
                                                height: 20,
                                                width: 20,
                                                child: FittedBox(
                                                  child: FloatingActionButton(
                                                    heroTag: "btnPlus${_product.nama}",
                                                    backgroundColor: Color(0xFF387C2B),
                                                    onPressed: () {
                                                      debugPrint("${_controller.text}");
                                                      int currentValue = _product.qty.toInt();
                                                      _product.qty = currentValue.toDouble();
                                                      //controller.addToCart(_product, qty: currentValue.toDouble());
                                                      controller.addToCart(_product);
                                                      setState(() {
                                                      });
                                                    },
                                                    child: Icon(Icons.add),
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
                            ]),
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
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
                            color: Color(0xff999999), fontWeight: FontWeight.bold, fontSize: 14,),
                      ),
                      Text(
                        count(_product.satuanHargaCash, _product.qty),
                        style: TextStyle(
                            color: Color(0xff333333), fontWeight: FontWeight.bold, fontSize: 14,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String count(String satuanHarga, double qty) {
    var harga = MyNumber.strUSToDouble(satuanHarga);
    var total = harga * qty;
    return "${MyNumber.toNumberRpStr(total.toString())}";
  }
}
