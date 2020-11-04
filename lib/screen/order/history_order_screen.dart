import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/order/list_order_screen.dart'
    as inProses;

class HistoryOrderScreen extends StatefulWidget {
  @override
  _HistoryOrderScreenState createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController controller;

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            "Pemesanan",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: <Widget>[],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: "Dalam Proses",
            ),
            Tab(
              text: "Selesai",
            ),
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
            inProses.ListOrderScreen('order_dalam_proses'),
            inProses.ListOrderScreen('order_selesai'),
            /*done.OrderDoneScreen(),*/
          ],
        ),
      ),
    );
  }
}
