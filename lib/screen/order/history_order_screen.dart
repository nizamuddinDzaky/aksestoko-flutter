import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/order/in_proses.dart' as inProses;
import 'package:aksestokomobile/screen/order/order_done.dart' as done;


class HistoryOrderScreen extends StatefulWidget {
  @override
  _HistoryOrderScreenState createState() =>
      _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        brightness: Brightness.light,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Expanded(
            child: Container(
              child: Text(
                "Pemesanan",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  print('klik notif');
                },
              ),
              Positioned(
                right: 5,
                top: 4,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: MyColor.redAT,
                  child: Text(
                    '20',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(

          controller: controller,
          tabs: <Widget>[
            Tab(text: "Dalam Proses",),
            Tab(text: "Selesei",),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          children: <Widget>[
            inProses.InProsesScreen(),
            done.OrderDoneScreen(),
          ],
        ),
      ),
    );
  }
}
