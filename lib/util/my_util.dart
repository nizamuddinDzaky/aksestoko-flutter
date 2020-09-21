import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'my_number.dart';

extension StringExtension on String {
  String toAlias() {
    var txt = this?.trim()?.toUpperCase();
    if (txt == null || txt.isEmpty) return '#';
    if (txt.length == 1) return txt;
    return txt.substring(0, 2);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  DateTime toDateTime() {
    var dateFormatIn = DateFormat('yyyy-MM-dd HH:mm:ss');
    var newDate = DateTime.now();
    try {
      newDate = dateFormatIn.parse(this);
    } catch (e) {
      debugPrint(e.message);
    }
    return newDate;
  }

  String toRp() {
    return MyNumber.toNumberRpStr(this);
  }

  String toNumId() {
    return MyNumber.toNumberIdStr(this);
  }

  String toDecId() {
    return MyNumber.toDecimalIdStr(this);
  }

  double toDouble() {
    return MyNumber.strUSToDouble(this);
  }

  double toDoubleID() {
    return MyNumber.strIDToDouble(this);
  }

  String strDoubleID() {
    return MyNumber.strIDToDouble(this).toString();
  }

  double tryIDtoDouble() {
    return MyNumber.tryStrIDToDouble(this);
  }

  double tryToDouble() {
    return MyNumber.tryStrUSToDouble(this);
  }

  String changeComma() { //format ID
    return this
        .split('')
        .map((e) => e == ',' ? '.' : (e == '.' ? '' : e))
        .join();
  }
}