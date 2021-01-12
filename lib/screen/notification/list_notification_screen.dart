import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/helper/my_notification.dart';
import 'package:aksestokomobile/main.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:aksestokomobile/screen/promo/detail_promo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListNotificationScreen extends StatefulWidget {
  @override
  _ListNotificationScreenState createState() => _ListNotificationScreenState();
}

class _ListNotificationScreenState extends State<ListNotificationScreen> {
  Widget _empty() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Riwayat Notifikasi Kosong',
            ),
          ],
        ),
      ),
    );
  }

  Widget _childItem(Item data) {
    // if (!validationNotif(data?.type)) return Container();
    return Card(
      elevation: 8,
      child: ListTile(
        onTap: () {
          debugPrint('notif ${data.itemId} ${data.type}');
          var map = data.toJson();
          if (isNotifValid(map)) {
            // triggerOnResume?.call(map);
            switch (data.type) {
              case 'sms_notif_promo':
                Get.to(DetailPromoScreen(
                  promo: Promo(
                      id: data.status, name: data.title, description: data.body)
                    ..getDetail = true,
                  item: data,
                ));
                break;
              default:
                Get.to(DetailOrderScreen(
                  idPemesanan: data.status,
                  item: data,
                ));
                break;
            }
          } else
            Get.defaultDialog(
                title: 'Informasi Salah',
                content: Text('Hapus informasi?'),
                textConfirm: 'Ya',
                confirmTextColor: Colors.white,
                textCancel: 'Abaikan',
                onConfirm: () {
                  ParentController parentController = Get.find();
                  parentController?.removeItem(data);
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
            Row(
              children: [
                if (data?.isRead != true)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Text(
                      'new',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (data?.isRead != true) SizedBox(width: 8),
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
              ],
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
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Daftar Informasi'),
      actions: [
        if (isDebugOnly)
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                ParentController parentController = Get.find();
                parentController?.updateItems();
              }),
        if (isDebugOnly)
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                ParentController parentController = Get.find();
                parentController?.clearItems();
              }),
      ],
    );

    return GetBuilder<ParentController>(
        builder: (vm) => Scaffold(
              appBar: appBar,
              body: (vm.items?.isEmpty ?? true)
                  ? _empty()
                  : ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (bc, idx) {
                        var newIdx = (vm.items.length - idx) - 1;
                        var data = vm.items[newIdx];
                        return Dismissible(
                          // key: Key(data.itemId ?? '$newIdx'),
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (status) {
                            vm.removeItem(data);
                          },
                          confirmDismiss: (direction) async {
                            return direction == DismissDirection.endToStart;
                          },
                          background: Container(
                            padding: EdgeInsets.only(right: 20.0),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Text(
                              'Hapus',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          child: _childItem(data),
                        );
                      },
                      separatorBuilder: (bc, idx) {
                        return SizedBox(height: 4);
                      },
                      itemCount: vm?.items?.length ?? 0,
                    ),
            ));
  }
}
