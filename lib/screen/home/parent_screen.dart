import 'package:aksestokomobile/at_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/home/select_product.dart'
    as selectProduct;
import 'package:aksestokomobile/screen/order/history_order_screen.dart'
    as historyOrder;
import 'package:aksestokomobile/screen/account/account_screen.dart' as Account;

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final tabs = [
    selectProduct.SelectProductScreen(),
    Center(
      child: Text("Promo"),
    ),
    historyOrder.HistoryOrderScreen(),
    Account.AccountScreen(),
  ];
  TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 3);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              IconAT.home,
            ),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_activity,
              size: 28,
            ),
            title: Text('Promo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.list_sales, size: 24),
            title: Text('Pesanan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.store),
            title: Text('Akun'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25,
        currentIndex: _currentIndex,
        selectedItemColor: MyColor.redAT,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
