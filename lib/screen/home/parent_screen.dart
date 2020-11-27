import 'dart:io';

import 'package:aksestokomobile/at_icon.dart';
import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/home/select_product.dart'
    as selectProduct;
import 'package:aksestokomobile/screen/order/history_order_screen.dart'
    as historyOrder;
import 'package:aksestokomobile/screen/promo/list_promo.dart' as listPromo;
import 'package:aksestokomobile/screen/account/account_screen.dart' as Account;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  requestAlertPermission: false,
  requestBadgePermission: false,
  requestSoundPermission: false,
);
final InitializationSettings initializationSettings = InitializationSettings(
  initializationSettingsAndroid,
  initializationSettingsIOS,
);

Future<void> showNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.Max,
    priority: Priority.Max,
    ticker: 'ticker',
    color: Colors.red,
    playSound: true,
    // sound: RawResourceAndroidNotificationSound('arrive')
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  var messageData = message['data'];
  print('on background $message');
  if (messageData is Map && messageData.isNotEmpty) {
    final data = message['data'];
    final title = data['title'];
    final body = data['message'];
    showNotification(title, body);
  }
  return Future<void>.value();
}

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int selectedPage;
  PageController _myPage;
  String _homeScreenText = "Waiting for token...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void fcmSubscribe() {
    _firebaseMessaging.subscribeToTopic('promo');
    _firebaseMessaging.subscribeToTopic('alluser');
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('promo');
  }

  void _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
        showNotification('title', 'body');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
    fcmSubscribe();
  }

  _initLocalNotification() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      // selectNotificationSubject.add(payload);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    _myPage = PageController(initialPage: selectedPage);
    _initLocalNotification();
    _initFirebaseMessaging();
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
