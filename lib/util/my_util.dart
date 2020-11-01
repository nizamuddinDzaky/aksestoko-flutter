import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'my_color.dart';
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

  String changeComma() {
    //format ID
    return this
        .split('')
        .map((e) => e == ',' ? '.' : (e == '.' ? '' : e))
        .join();
  }

  int toInt() {
    return int.tryParse(this);
  }
}

Color statusColor(String status){
  if (status.toLowerCase() == 'success'){
    return MyColor.successTextAT;
  }

  if (status.toLowerCase() == 'warning'){
    return MyColor.warningTextAT;
  }

  if(status.toLowerCase() == 'info'){
    return MyColor.infoAT;
  }

  if(status.toLowerCase() == 'danger'){
    return MyColor.redAT;
  }

  return null;
}

String strToDate(String txtDate, {BuildContext context}) {
//  debugPrint("asdasd => ${DateTime.tryParse(txtDate)}");
  var dateFormatOut = DateFormat('dd MMMM yyyy');
  if (txtDate == null) return '';
  return dateFormatOut.format(DateTime.tryParse(txtDate));
}

extension DateTimeExtension on DateTime {
  String toStr() {
    if (this == null) return '';
    var dateFormatOut = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormatOut.format(this);
  }

  String toMonthStr({bool showDiffYear = false}) {
    if (this == null) return '';
    var now = DateTime.now();
    if (showDiffYear && now.year != this.year) {
      var dateFormatOut = DateFormat('MMMM yyyy', 'in_ID');
      return dateFormatOut.format(this);
    }
    var dateFormatOut = DateFormat('MMMM', 'in_ID');
    return dateFormatOut.format(this);
  }
}
