import 'package:intl/intl.dart';
/*import 'my_util.dart';*/


class MyNumber {
  static String toNumberRpStr(String newValue) {
    final fc = NumberFormat.currency(locale: 'id', symbol: 'Rp');
    return fc.format(strUSToDouble(newValue));
  }
  static double strUSToDouble(String newValue) {
    final f = NumberFormat('#,###', 'en');
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return f.parse(resValue) ?? 0;
  }
}