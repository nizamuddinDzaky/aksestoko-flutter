import 'package:flutter/cupertino.dart';

class MyDimen {
  /// text field
  static EdgeInsetsGeometry paddingRememberPass() =>
      EdgeInsets.only(left: 12, right: 12);

  static EdgeInsetsGeometry paddingTxtField() =>
      EdgeInsets.symmetric(horizontal: 8);

  static EdgeInsetsGeometry marginLayout() =>
      EdgeInsets.symmetric(horizontal: 25);

  static double circularMedium = 25;
  static int timerSplash = 1;

  static double paddingFieldLoginSize() => 40;

  static EdgeInsetsGeometry paddingItem() =>
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);

  static EdgeInsetsGeometry paddingFieldLogin() =>
      EdgeInsets.symmetric(horizontal: paddingFieldLoginSize());

  static Size sizeCardTitle() => Size(140, 50);

  static double fontSizeLogoLarge() => 50;

  static double fontSizeLogoMedium() => 30;

  static double circularInput() => 50;

  // Custom Dio
  static EdgeInsets marginButtonLoginCustom() =>
      EdgeInsets.only(left: 46.0, right: 46.0, top: 50);

  static EdgeInsetsGeometry marginButtonRegister() =>
      EdgeInsets.symmetric(horizontal: 46);

}
