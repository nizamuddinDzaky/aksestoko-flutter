import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:aksestokomobile/screen/order/list_history_order_screen.dart'
    as listOrder;

class InProsesScreen extends StatefulWidget {
  @override
  _InProsesScreenState createState() => _InProsesScreenState();
}

class _InProsesScreenState extends State<InProsesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    blurRadius: 8,
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
                    borderSide:
                        BorderSide(color: Color(0xffC8C8C8), width: 2.0),
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
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (buildcontext, index) {
                  return listOrder.ListHistoryOrderProductScreen(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
