import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    this.serverName,
    this.isTesting,
    this.isProd,
    Widget child,
  }) : super(child: child);

  final String serverName;
  final int isTesting;
  final bool isProd;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
