import 'dart:io';

import 'package:aksestokomobile/app/my_app.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

const isProd = kReleaseMode;

// bool get isDebugQA => valDebug == 1 || (kDebugMode || !isProd);
bool get isDebugQA => valDebug == 1 || isDebugOnly;

// bool get isDebugOnly => valDebug == 2 || kDebugMode;
bool get isDebugOnly => valDebug == 2;

int valDebug = kDebugMode ? 2 : ((kDebugMode || !isProd) ? 1 : 0);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  if (!isProd) HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ApiClient.addInterceptor();
  Get.config(enableLog: false);
  await Firebase.initializeApp();
  return runApp(Phoenix(child: MyApp()));
}
