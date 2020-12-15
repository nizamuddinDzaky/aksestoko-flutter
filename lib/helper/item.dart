import 'dart:async';

import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:aksestokomobile/screen/promo/detail_promo.dart';
import 'package:flutter/material.dart';

final Map<String, Item> items = <String, Item>{};

Item itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId =
      data['id'] ?? '${DateTime.now().millisecondsSinceEpoch}';
  final Item item = items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['id_promo'] ?? data['id_pemesanan']
    ..title = data['title']
    ..body = data['body']
    ..type = data['type'];
  return item;
}

class Item {
  Item({this.itemId});

  final String itemId;
  String title;
  String body;
  String type;

  StreamController<Item> _controller = StreamController<Item>.broadcast();

  Stream<Item> get onChanged => _controller.stream;

  String _status;

  String get status => _status;

  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};

  Route<void> get route {
    final String routeName = '/detail/$itemId';
    // var now = DateTime.now();
    // final String routeName = '/detail/$itemId${now.millisecondsSinceEpoch}';
    switch (type) {
      case 'sms_notif_promo':
        return routes.putIfAbsent(
          routeName,
          () => MaterialPageRoute<void>(
            settings: RouteSettings(name: routeName),
            builder: (BuildContext context) => DetailPromoScreen(
              promo: Promo(id: status, name: title, description: body)
                ..getDetail = true,
            ),
          ),
        );
    }
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailOrderScreen(
          idPemesanan: status,
        ),
      ),
    );
  }
}
