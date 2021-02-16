import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math' as math;

import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
      debugLog(e.message);
    }
    return newDate;
  }

  String htmlToStr() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return this.replaceAll(exp, '');
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

Color statusColor(String status) {
  if (status == null) return null;

  if (status.toLowerCase() == 'success') {
    return MyColor.successTextAT;
  }

  if (status.toLowerCase() == 'warning') {
    return MyColor.warningTextAT;
  }

  if (status.toLowerCase() == 'info') {
    return MyColor.infoAT;
  }

  if(status.toLowerCase() == 'danger'){
    return MyColor.redAT;
  }

  return null;
}

Future<File> compressAndGetFile(File file, String targetPath) async {
  var decodeImage = await decodeImageFromList(file.readAsBytesSync());
  var w = decodeImage.width;
  var h = decodeImage.height;
  var max = [decodeImage.width, decodeImage.height].reduce(math.max);
  max = max > 1000 ? 1000 : max;
  var isVertical = w < h;
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 90,
    minHeight: isVertical ? max : (h * max ~/ w),
    minWidth: isVertical ? (w * max ~/ h) : max,
    rotate: isVertical ? 0 : 90,
  );
  return result;
}

String paymentMethode(String payment){
  if(payment.toLowerCase() == "cash on delivery"){
    return MyString.TXT_COD;
  }
  if(payment.toLowerCase() == "kredit"){
    return MyString.TXT_KREDIT;
  }

  if(payment.toLowerCase() == "cash before delivery"){
    return MyString.TXT_CBD;
  }
  return "";
}

String paymentIcon(String payment){
  if(payment.toLowerCase() == "cash on delivery"){
    return atPaymentCOD;
  }
  if(payment.toLowerCase() == "kredit"){
    return atPaymentTempoDistributor;
  }

  if(payment.toLowerCase() == "cash before delivery"){
    return atPaymentCBD;
  }
  return atPaymentCOD;
}

String strToDate(String txtDate, {BuildContext context}) {
  var dateFormatOut = DateFormat('dd MMMM yyyy');
  if (txtDate == null) return '';
  return dateFormatOut.format(DateTime.tryParse(txtDate));
}

String getKabupatenName(String kabupatenName){
  if(kabupatenName.toLowerCase().contains("kabupaten")){
    return kabupatenName.toLowerCase().replaceAll("kabupaten", "").trim();
  }

  if(kabupatenName.toLowerCase().contains("kota")){
    return kabupatenName.toLowerCase().replaceAll("kota", "").trim();
  }

  return kabupatenName.toLowerCase().trim();
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

void actionDelay(int milis, Function function) {
  Future.delayed(Duration(milliseconds: milis ?? 500), () => function?.call());
}

void debugLog(String message) {
  if (kDebugMode) dev.log(message ?? '-emptylog-');
}

void debugLogs(List message) {
  if (kDebugMode) dev.log('printLog ${message?.join(' | ') ?? '-emptylog-'}');
}

bool checkHost(String url, {String domain = 'aksestoko.id'}) {
  if (url?.isEmpty ?? true) return false;
  var uri = Uri.tryParse(url);
  return uri.host.endsWith(domain ?? 'aksestoko.id');
}

bool validateMobilePhoneNumber(String value) {
  String pattern = r'^8[0-9]{8,11}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

String trimMobilePhoneNumber(String tlp) {
  var newTlp = tlp ?? '';
  if (newTlp.startsWith('0')) return newTlp.substring(1);
  if (newTlp.startsWith('62')) return newTlp.substring(2);
  if (newTlp.startsWith('+62')) return newTlp.substring(3);
  if (newTlp.startsWith('+')) return newTlp.substring(1);
  return newTlp;
}

TextEditingController cursorToEnd(String newText) {
  return TextEditingController()
    ..text = newText
    ..selection = TextSelection(
      baseOffset: newText.length,
      extentOffset: newText.length,
    );
}