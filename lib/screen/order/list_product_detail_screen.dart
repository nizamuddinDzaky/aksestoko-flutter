import 'package:aksestokomobile/model/cart.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class ListProductDetailOrderScreen extends StatefulWidget {
  Cart cart;
  ListProductDetailOrderScreen(Cart cart){
    this.cart = cart;
  }
  _ListProductDetailOrderScreenState createState() =>
      _ListProductDetailOrderScreenState(cart);
}

class _ListProductDetailOrderScreenState
    extends State<ListProductDetailOrderScreen> {
  Cart cart;
  _ListProductDetailOrderScreenState(Cart cart){
    this.cart = cart;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: MyColor.greyTextAT,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              kImageDynamix,
              width: 100,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    cart != null ? cart.nama : "",
                    style: TextStyle(
                      color: MyColor.blackTextAT,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cart != null ? cart.code : "",
                        style: TextStyle(
                          color: MyColor.greyTextAT,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cart != null ? MyNumber.toNumberRpStr(cart.satuanHargaCash.toString()) : "",
                        style: TextStyle(
                          color: MyColor.greyTextAT,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Jumlah",
                            style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${cart != null ? cart.qty : "0"}",
                                style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                              ),
                              Text(
                                "${cart != null ? cart.unit : "SAK"}",
                                style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 16),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Harga",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              cart != null ? MyNumber.toNumberRpStr(cart.total.toString()) : "",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
