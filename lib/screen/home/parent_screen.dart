import 'package:aksestokomobile/at_icon.dart';
import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/home/select_product.dart'
    as selectProduct;
import 'package:aksestokomobile/screen/order/history_order_screen.dart'
    as historyOrder;
import 'package:aksestokomobile/screen/promo/list_promo.dart' as listPromo;
import 'package:aksestokomobile/screen/account/account_screen.dart' as Account;
import 'package:get/get.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int selectedPage;
  PageController _myPage;

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    _myPage = PageController(initialPage: selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ParentController>(
          init: ParentController(),
          builder: (controller) =>
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _myPage,
                children: <Widget>[
                  selectProduct.SelectProductScreen(),
                  listPromo.ListPromoScreen(),
                  historyOrder.HistoryOrderScreen(),
                  Account.AccountScreen(),
                ],
              ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconAT.home, size: 26),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Promo',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.list_sales, size: 26),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.store, size: 26),
            label: 'Akun',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25,
        currentIndex: selectedPage,
        selectedItemColor: MyColor.redAT,
        onTap: (index) {
          setState(() {
            _myPage.jumpToPage(index);
            selectedPage = index;
          });
        },
      ),
    );
  }
}
