import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/util/notif_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ParentController extends GetController {
  List<Order> newOrders = [];
  List<Item> items = [];
  NotifPref notifPref = NotifPref();

  ParentController() {
    _getNotif();
  }

  int get countItems =>
      items?.where((element) => element.isRead != true)?.length ?? 0;

  void addNotif({Item item}) {
    if (kReleaseMode && item == null) return;
    debugPrint('add notif ${item?.toJson()}');
    if (DateTime.now().millisecond % 2 == 0) {
      items?.add(item ??
          Item(
            itemId: '77',
            title: 'Promo Akhir Tahun',
            body: 'Selamat anda memenangkan hadiah\n'
                'Selamat anda memenangkan hadiah\n'
                'Selamat anda memenangkan hadiah\n'
                'Selamat anda memenangkan hadiah\n'
                'Selamat anda memenangkan hadiah',
            type: 'sms_notif_promo',
          )
        ..status = '77');
    } else {
      items?.add(item ??
          Item(
            // itemId: '28613',
            // itemId: '28517',
            itemId: '28616',
            title: 'Pengiriman Barang',
            body: 'Ada proses pengiriman barang',
            type: 'sms_notif_delivery',
          )
        ..status = '28616');
    }
    if (items != null && items.length > 10) {
      items.removeAt(0);
    }
    notifPref.setNotif(items);
    update();
  }

  void removeItem(Item item) {
    items?.remove(item);
    notifPref.setNotif(items);
    update();
  }

  void _getNotif() {
    var oldItems = notifPref.getNotif();
    items = oldItems ?? [];
    print('items ${items.length} $items');
    update();
  }

  void clearItems() {
    items?.clear();
    notifPref.setNotif(items);
    update();
  }

  void updateItems() {
    items?.clear();
    items = [];
    // for (int i = 0; i < 6; i++) listNotif.add(Item(itemId: 'index$i'));
    items.add(Item(
      itemId: '77',
      title: 'Promo Akhir Tahun',
      body: 'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah',
      type: 'sms_notif_promo',
    ));
    items.add(Item(
      itemId: '28613',
      title: 'Pengiriman Barang',
      body: 'Ada proses pengiriman barang',
      type: 'sms_notif_delivery',
    ));
    items.add(Item(
      itemId: '28613',
      title: 'Pengiriman Barang',
      body: 'Ada proses pengiriman barang',
    ));
    update();
  }

  List<Order> filter(status) {
    if (status != 'order_dalam_proses') return [];
    return newOrders;
  }

  addOrder(Order newOrder) {
    newOrders = newOrders ?? [];
    newOrders.add(newOrder);
    update();
  }

  clearOrder() {
    newOrders?.clear();
    newOrders = [];
    update();
  }
}
