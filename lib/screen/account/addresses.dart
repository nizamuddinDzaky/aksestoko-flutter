import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/screen/account/edit_alamat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';

class ListAddress extends StatefulWidget {
  final Alamat address;

  ListAddress(this.address);

  _ListAddressState createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {
  @override
  Widget build(BuildContext context) {
    List<String> line1 = [
      widget.address?.addressName,
      widget.address?.addressPhone,
    ];
    List<String> line2 = [
      widget.address?.address,
      widget.address?.addressPostalCode,
    ];
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 10),
      padding: EdgeInsets.all(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.home,
                        color: MyColor.redAT,
                      ),
                    ),
                    Text(
                      "{{Nama Toko}}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 22,
                          color: MyColor.redAT,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 10, left: 10),
            child: Text(
              line1.join(', '),
              style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              line2.join(', '),
              style: TextStyle(fontSize: 16, color: MyColor.greyTextAT),
            ),
          ),
          Container(
            child: CupertinoButton(
              child: Text(
                "Perbarui Alamat",
                style: TextStyle(
                  color: MyColor.redAT,
                ),
              ),
              onPressed: () {
                Get.to(EditAlamatScreen(widget.address));
              },
            ),
          ),
        ],
      ),
    );
  }
}
