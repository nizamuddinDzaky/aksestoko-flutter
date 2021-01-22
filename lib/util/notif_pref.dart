import 'dart:convert';
import 'dart:developer';

import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/util/my_pref.dart';

class NotifPref {
  void setNotif(List<Item> items) {
    var mapItem = {
      'items': items?.map((e) => e?.toJson())?.toList(),
    };
    String json = jsonEncode(mapItem);
    var distributorId = MyPref.getIdDistributor();
    MyPref.setKeyNotif('notif${distributorId ?? ''}');
    MyPref.setString('notif${distributorId ?? ''}', json);
  }

  List<Item> getNotif() {
    var distributorId = MyPref.getIdDistributor();
    String json =
        MyPref.getString('notif${distributorId ?? ''}', '{"items": null}');
    var data = jsonDecode(json);
    if (data['items'] is List) {
      if (isDebugOnly) log('data ${data['items']} $data');
      return (data['items'] as List)
          .map((e) => e == null
              ? null
              : (Item(
                  itemId: e['id'] ?? e['id_promo'] ?? e['id_pemesanan'],
                  title: e['title'],
                  body: e['body'],
                  type: e['type'],
                )
                ..status = e['status']
                ..isRead = e['is_read']))
          .toList();
    }
    return [];
  }
}
