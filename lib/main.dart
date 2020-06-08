import 'package:aksestokomobile/app/my_app.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:flutter/material.dart';

void main() async {
  ApiClient.addInterceptor();
  return runApp(MyApp());
}
