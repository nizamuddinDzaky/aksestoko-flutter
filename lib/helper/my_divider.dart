import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDivider {
  static spaceDividerLogin({double custom}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: custom ?? 6));
  }
  static spaceDividerElementsAT({double custom}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: custom ?? 6));
  }

  static lineDivider({
    double custom,
    Color customColor,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double vertical,
    double horizontal,
    double thickness,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: horizontal ?? left,
        right: horizontal ?? right,
        top: vertical ?? top,
        bottom: vertical ?? bottom,
      ),
      child: Divider(
        height: custom ?? 0,
        thickness: thickness,
        color: customColor ?? MyColor.lineDivider,
      ),
    );
  }
}
