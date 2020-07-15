import 'package:aksestokomobile/at_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/home/select_distributor.dart'
    as selectDistributor;
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
    selectDistributor.SelectDistributorScreen(),
    Center(
      child: Text("Promo"),
    ),
    selectProduct.SelectProductScreen(),
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
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: MyColor.lineTxtField,
//        ),
////        brightness: Brightness.light,
//        backgroundColor: Colors.black,
//        elevation: 0,
//        centerTitle: true,
//        title: Hero(
//          tag: 'logoForcaPoS',
//          child: MyLogo.logoATWhite(width: 100),
//        ),
//        bottom: TabBar(
//          controller: controller,
//          tabs: <Widget>[
//            Tab(icon: Icon(Icons.headset), text: "Komputer",),
//            Tab(icon: Icon(Icons.settings),),
//            Tab(icon: Icon(Icons.train),),
//          ],
//        ),
//      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: tabs[_currentIndex],
//        TabBarView(
//          controller: controller,
//          children: <Widget>[
//            halSatu.HalKomputer(),
//            halDua.HalDua(),
//            halTiga.HalTiga(),
//          ],
//        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconAT.warehouse, size: 20,),
            title: Text('Distributor'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Promo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.home, size: 25,),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Pesanan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
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
