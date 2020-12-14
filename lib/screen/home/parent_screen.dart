import 'package:aksestokomobile/at_icon.dart';
import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/helper/my_notification.dart';
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
  var myNotification = MyNotification();

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text(item?.title ?? 'Ada notifikasi masuk'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Tutup'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('Detail'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) {
      // return route is ParentScreen;
      debugPrint("route name ${route.settings.name}");
      return route is PageRoute;
    });
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    triggerOnMessage = (message) {
      _showItemDialog(message);
    };
    triggerOnResume = (message) {
      _navigateToItemDetail(message);
    };
    myNotification.init(context);
    myNotification.actionTriggerOnBackground((message) {
      debugPrint('pindah halaman ${message != null}');
      _navigateToItemDetail(message);
    });
    _myPage = PageController(initialPage: selectedPage);
  }

  @override
  void dispose() {
    myNotification.dispose();
    super.dispose();
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
            label: 'Berita',
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
