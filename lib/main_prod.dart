import 'package:aksestokomobile/app/my_app.dart';
import 'package:aksestokomobile/app/app_config.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  var configuredApp = AppConfig(
    serverName: "Prod",
    isTesting: 0,
    isProd: true,
    child: Phoenix(child: MyApp()),
  );

  mainCommon(configuredApp.isProd).then((value) {
    runApp(configuredApp);
  });
}
