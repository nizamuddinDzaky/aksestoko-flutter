import 'dart:io';

import 'package:aksestokomobile/network/api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

bool isProd = kReleaseMode;

bool get isDebugQA => valDebug == 1 || isDebugMode;

bool get isDebugOnly => kDebugMode || isDebugMode;

bool get isDebugMode => valDebug == 2;

bool get isProdMode => valDebug == 0 || isProd;

int valDebug = kDebugMode ? 2 : ((kDebugMode || !isProd) ? 1 : 0);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> mainCommon(bool newProd) async {
  isProd = newProd;
  if (!newProd) HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ApiClient.addInterceptor();
  Get.config(enableLog: false);
  await Firebase.initializeApp();
}
