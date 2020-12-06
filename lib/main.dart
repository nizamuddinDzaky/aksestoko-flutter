import 'package:aksestokomobile/app/my_app.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const isProd = true;

void main() async {
  ApiClient.addInterceptor();
  Get.config(enableLog: false);
  return runApp(MyApp());
}
