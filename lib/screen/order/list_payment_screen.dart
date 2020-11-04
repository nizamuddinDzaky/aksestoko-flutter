import 'package:aksestokomobile/model/detail_payment.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPaymentScreen extends StatelessWidget{
  final int index;
  ListPembayaran listPembayaran;
  ListPaymentScreen(this.listPembayaran, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColor.redAT,
            ),
            child: Text(
              "P",
              style: TextStyle(fontSize: 70, color: Colors.white, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  MyNumber.toNumberRpStr(listPembayaran.nominal.toString()),
                  style: TextStyle(color: MyColor.redAT, fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Text(
                  listPembayaran.status,
                  style: TextStyle(color: statusColor(listPembayaran.labelStatus), fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(listPembayaran.tanggalUnggah, textAlign: TextAlign.right,),
          ),
        ],
      ),
    );
  }
}