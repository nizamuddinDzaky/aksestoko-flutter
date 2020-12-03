import 'dart:convert';
import 'dart:io';

import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/notification/detail_page.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/subjects.dart';

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
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

Future<void> showNotification(String title, String body,
    {Map<String, dynamic> message}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'FLUTTER_NOTIFICATION_CLICK',
    'your channel name',
    'your channel description',
    channelAction: AndroidNotificationChannelAction.CreateIfNotExists,
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
    payload: message.toString(),
  );
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  var messageData = message['data'];
  print('on background $message');
  if (messageData is Map && messageData.isNotEmpty) {
    final data = message['data'];
    final title = data['title'];
    final body = data['message'];
    showNotification(title, body, message: message);
  }
  return Future<void>.value();
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
Function(Map<String, dynamic>) triggerOnMessage;
Function(Map<String, dynamic>) triggerOnLaunch;
Function(Map<String, dynamic>) triggerOnResume;
Function(String) triggerOnBackground;

class MyNotification {
  BuildContext context;

  void fcmSubscribe() {
    _firebaseMessaging.subscribeToTopic('promo');
    _firebaseMessaging.subscribeToTopic('alluser');
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('promo');
  }

  void _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      // onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print(
            "${triggerOnResume == null} ${DateTime.now()} $triggerOnResume onMessage: $message");
        triggerOnMessage?.call(message);
        // _showItemDialog(message);
        // showNotification('title', 'body');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        triggerOnLaunch?.call(message);
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        triggerOnResume?.call(message);
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
      debugPrint("Push Messaging token: $token");
      _actionGetToken(token);
    });
    fcmSubscribe();
  }

  _actionPostToken(String token) async {
    String deviceName = 'unknown';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await deviceInfoPlugin.androidInfo;
      deviceName = info.model;
    } else if (Platform.isIOS) {
      var info = await deviceInfoPlugin.iosInfo;
      deviceName = info.model;
    }
    var body = {
      'token': token,
      'device_name': deviceName,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlUpdateToken,
      body,
      {},
      customHandle: true,
      onSuccess: (data, _) {
        debugPrint("success add token: $data");
      },
      onFailed: (title, message) {
        debugPrint("fail add token: $message");
      },
      onError: (title, message) {
        debugPrint("error add token: $message");
      },
    );
    status.execute();
  }

  _actionGetToken(String token) async {
    String deviceName = 'unknown';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await deviceInfoPlugin.androidInfo;
      deviceName = info.model;
    } else if (Platform.isIOS) {
      var info = await deviceInfoPlugin.iosInfo;
      deviceName = info.model;
    }
    (await ApiClient.methodGet(
      ApiConfig.urlGetToken,
      params: {
        'device': deviceName,
      },
      onSuccess: (data, _) async {
        debugPrint("post token: $data");
        if (data['data'] != null && data['data']['token'] != null) {
          var oldToken = data['data']['token'];
          if (oldToken != token) _actionPostToken(token);
        }
      },
      onFailed: (data, _) async {
        debugPrint("post token: $data");
        _actionPostToken(token);
      },
    ))
        .execute();
  }

  _initLocalNotification() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        triggerOnBackground?.call(payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  actionTriggerOnBackground(Function(Map<String, dynamic>) action) {
    triggerOnBackground = (payload) {
      action?.call(jsonDecode(payload));
    };
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      debugPrint('show dialog');
    });
  }

  void _configureSelectNotificationSubject() {
    debugPrint('init notif subject ${selectNotificationSubject?.length}');
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('action push subject ${selectNotificationSubject?.length}');
      // triggerOnBackground?.call(payload);
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => DetailPage(payload)),
      );
    });
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }

  void init(context) {
    this.context = context;
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    // _initLocalNotification();
    _initFirebaseMessaging();
  }
}
