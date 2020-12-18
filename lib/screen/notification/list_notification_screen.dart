import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/helper/my_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListNotificationScreen extends StatefulWidget {
  @override
  _ListNotificationScreenState createState() => _ListNotificationScreenState();
}

class _ListNotificationScreenState extends State<ListNotificationScreen> {
  var listNotif = List<Item>();

  void _updateList() {
    listNotif?.clear();
    listNotif = [];
    // for (int i = 0; i < 6; i++) listNotif.add(Item(itemId: 'index$i'));
    listNotif.add(Item(
      itemId: '77',
      title: 'Promo Akhir Tahun',
      body: 'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah\n'
          'Selamat anda memenangkan hadiah',
      type: 'sms_notif_promo',
    ));
    listNotif.add(Item(
      itemId: '28613',
      title: 'Pengiriman Barang',
      body: 'Ada proses pengiriman barang',
      type: 'sms_notif_delivery',
    ));
    listNotif.add(Item(
      itemId: '28613',
      title: 'Pengiriman Barang',
      body: 'Ada proses pengiriman barang',
    ));
    setState(() {});
  }

  Widget _childItem(Item data) {
    // if (!validationNotif(data?.type)) return Container();
    return Card(
      elevation: 8,
      child: ListTile(
        onTap: () {
          debugPrint('notif ${data.itemId} ${data.type}');
          var map = data.toJson();
          if (isNotifValid(map))
            triggerOnResume?.call(map);
          else
            Get.defaultDialog(
                title: 'Informasi Salah',
                content: Text('Hapus informasi?'),
                textConfirm: 'Ya',
                confirmTextColor: Colors.white,
                textCancel: 'Abaikan',
                onConfirm: () {
                  listNotif?.remove(data);
                  setState(() {});
                  Get.back();
                });
        },
        title: Text(
          data?.title ?? '',
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data?.getType?.isNotEmpty ?? false)
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: data?.getColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Text(
                  data?.getType,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Text(
              data?.body ?? '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _updateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Informasi'),
      actions: [
        if (false)
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _updateList();
              }),
      ],
    );

    var body = ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      physics: BouncingScrollPhysics(),
      itemBuilder: (bc, idx) {
        var data = listNotif[idx];
        return _childItem(data);
      },
      separatorBuilder: (bc, idx) {
        return SizedBox(height: 4);
      },
      itemCount: listNotif?.length ?? 0,
    );

    var scaffold = Scaffold(
      appBar: appBar,
      body: body,
    );

    return scaffold;
  }
}
