import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/screen/order/list_history_order_done_screen.dart' as listOrder;

class OrderDoneScreen extends StatefulWidget{
  @override
  _OrderDoneScreenState createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.greyTextAT,
                    spreadRadius: 0,
                    blurRadius: 8 ,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  contentPadding: EdgeInsets.only(top: 15.0),
                  hintText: 'Cari Pesanan Anda',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC8C8C8), width: 2.0),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                      topLeft: Radius.circular(5.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColor.redAT, width: 1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyColor.redAT,
                  ),
                ),
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  listOrder.ListHistoryOrderDoneScreen(),
                  listOrder.ListHistoryOrderDoneScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}