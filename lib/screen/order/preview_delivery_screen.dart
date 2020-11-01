import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewDeliveryScreen extends StatefulWidget {
  @override
  _PreviewDeliveryScreenState createState() => _PreviewDeliveryScreenState();
}

class _PreviewDeliveryScreenState extends State<PreviewDeliveryScreen> {

  Widget _delivery(){
    return new Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
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
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "No SPJ",
                        style: TextStyle(
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        "DO/2020/10/0016",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Status Pengiriman",
                        style: TextStyle(
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        "Dalam Pengiriman",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor("danger")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tanggal Dikirim",
                        style: TextStyle(
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        "27 Oktober 2020",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dikirim Oleh",
                        style: TextStyle(
                            fontSize: 14, color: MyColor.greyTextAT),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Color(0xffEAEAEA),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: MyColor.greenAT,
              borderRadius: BorderRadius.circular(30),
            ),
            child: FlatButton(
              child: Text(
                "Terima",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => _delivery(),
      itemCount: 2,
    );
  }
}