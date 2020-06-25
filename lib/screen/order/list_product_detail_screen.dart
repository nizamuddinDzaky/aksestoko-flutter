import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/resource/my_image.dart';

class ListProductDetailOrderScreen extends StatefulWidget {
  _ListProductDetailOrderScreenState createState() =>
      _ListProductDetailOrderScreenState();
}

class _ListProductDetailOrderScreenState
    extends State<ListProductDetailOrderScreen> {
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
                    "Semen PCC ZAK 50",
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
                        "121-301-0060",
                        style: TextStyle(
                          color: MyColor.greyTextAT,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Rp 50.000",
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
                                "2",
                                style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                              ),
                              Text(
                                "SAK",
                                style: TextStyle(
                                  color: MyColor.blackTextAT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rp 100.000.000",
                              style: TextStyle(
                                color: MyColor.blackTextAT,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
