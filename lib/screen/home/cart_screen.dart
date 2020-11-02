import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/screen/home/cart_item_screen.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool CheckBoxValue = false;

  Widget formLayout(SelectProductController controller) {
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child:
                  controller.listCart == null || controller.listCart.length < 1
                      ? new Text('Keranjang Kosong')
                      : _gridCart(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCart(SelectProductController controller) {
    return ListView.builder(
        itemCount: controller.listCart.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            CartItemScreen(controller.listCart[index]));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectProductController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Hero(
            tag: 'logoForcaPoS',
            child: Text("Keranjang"),
          ),
          bottom: controller.listCart?.isEmpty ?? true
              ? null
              : PreferredSize(
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
                                onPressed: () {
                                  // openDialog(step: 1, data: );
                                },
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
            child: formLayout(controller)),
        bottomNavigationBar: new Stack(
          overflow: Overflow.visible,
          children: [
            new Container(
              padding:
              EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              height: 100,
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
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          child: Text(
                            controller.promoCode ?? 'Kode Promo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            controller.inputPromoCode();
                          },
                        ),
                        SizedBox(height: 5),
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
                          Get.toNamed(checkoutScreen,
                              arguments: controller.listCart);
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
      ),
    );
  }
}
