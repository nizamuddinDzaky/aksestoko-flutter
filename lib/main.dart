import 'package:aksestokomobile/app/my_app.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const isProd = kReleaseMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ApiClient.addInterceptor();
  Get.config(enableLog: false);
  await Firebase.initializeApp();
  return runApp(MyApp());
}
