import 'package:aksestokomobile/app/middle_ware.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AksesToko',
      theme: ThemeData(
        primaryColor: MyColor.mainRed,
        accentColor: MyColor.mainRed,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Get.key,
      initialRoute: "/",
      supportedLocales: [
        const Locale('en', 'US'), // American English
        const Locale('in', 'ID'),
      ],
      localizationsDelegates: [
        CustomMaterialLocalizations(),
        CustomCupertinoLocalizations(),
        CustomWidgetsLocalizations(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('in', 'ID'),
      navigatorObservers: [
        GetObserver(MiddleWare.observer),
      ],
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}

class CustomMaterialLocalizations
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();

  @override
  bool shouldReload(_) => false;
}

class CustomCupertinoLocalizations
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async =>
      DefaultCupertinoLocalizations();

  @override
  bool shouldReload(_) => false;
}

class CustomWidgetsLocalizations
    extends LocalizationsDelegate<WidgetsLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) async =>
      DefaultWidgetsLocalizations();

  @override
  bool shouldReload(_) => false;
}