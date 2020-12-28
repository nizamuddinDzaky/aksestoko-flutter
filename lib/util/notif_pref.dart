import 'dart:convert';

import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/util/my_pref.dart';

class NotifPref {
  void setNotif(List<Item> items) {
    var mapItem = {
      'items': items?.map((e) => e.toJson())?.toList(),
    };
    String json = jsonEncode(mapItem);
    MyPref.setString('notif', json);
  }

  List<Item> getNotif() {
    String json = MyPref.getString('notif', '{"items": null}');
    var data = jsonDecode(json);
    if (data['items'] is List) {
      // log('data ${data['items']} $data');
      return (data['items'] as List)
          .map((e) => Item(
                itemId: e['id'] ?? e['id_promo'] ?? e['id_pemesanan'],
                title: e['title'],
                body: e['body'],
                type: e['type'],
              )..status = e['status'])
          .toList();
    }
    // print('data empty ${data['items']} $data');
    return [];
  }
}
