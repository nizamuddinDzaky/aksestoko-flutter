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
    ..status = data['id_promo'] ?? data['id_pemesanan'] ?? data['status']
    ..title = data['title']
    ..body = data['body']
    ..isRead = data['is_read']
    ..type = data['type'];
  return item;
}

class Item {
  Item({this.itemId, this.title, this.body, this.type});

  final String itemId;
  String title;
  String body;
  String type;
  bool isRead;

  StreamController<Item> _controller = StreamController<Item>.broadcast();

  Stream<Item> get onChanged => _controller.stream;

  String _status;

  String get status => _status;

  Color get getColor {
    switch (getType) {
      case 'Berita':
        return Colors.green;
      case 'Pesanan':
        return Colors.orange;
      default:
        return Colors.white;
    }
  }

  String get getType {
    switch (this.type ?? '') {
      case 'sms_notif_promo':
      case 'sms_notif_berita':
        return 'Berita';
      case 'sms_notif_delivery':
      case 'sms_notif_change_price':
      case 'sms_notif_return_approve':
      case 'sms_notif_return_reject':
      case 'sms_notif_payment_paid':
      case 'sms_notif_payment_partial':
      case 'sms_notif_payment_reject':
      case 'sms_notif_update_status':
      case 'sms_notif_update_payment':
      case 'sms_notif_reminder_payment':
        return 'Pesanan';
      default:
        return '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['status'] = this.status;
    data['is_read'] = this.isRead;
    switch (this.type ?? '') {
      case 'sms_notif_promo':
      case 'sms_notif_berita':
      case '':
        data['id_promo'] = this.status;
        break;
      case 'sms_notif_delivery':
      case 'sms_notif_':
        data['id_pemesanan'] = this.status;
        break;
      default:
        data['id'] = this.status;
    }
    data['id'] = this.itemId;
    return data;
  }

  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};

  Route<void> get route {
    // final String routeName = '/detail/$itemId';
    var now = DateTime.now();
    final String routeName = '/detail/$itemId${now.millisecondsSinceEpoch}';
    switch (type) {
      case 'sms_notif_promo':
        return routes.putIfAbsent(
          routeName,
          () => MaterialPageRoute<void>(
            settings: RouteSettings(name: routeName),
            builder: (BuildContext context) => DetailPromoScreen(
              promo: Promo(id: status, name: title, description: body)
                ..getDetail = true,
              item: this,
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
          item: this,
        ),
      ),
    );
  }
}
