import 'package:aksestokomobile/screen/account/address_controller.dart';
import 'package:aksestokomobile/screen/account/addresses.dart';
import 'package:aksestokomobile/screen/account/edit_alamat_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/view_model/account/list_store_address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/app/my_router.dart';
import 'package:get/get.dart';

class ListAddressScreen extends StatefulWidget {



  @override
  _ListAddressScreenState createState() => _ListAddressScreenState();
}

class _ListAddressScreenState extends ListStoreAddressViewModel {
  AddressController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                  width: double.maxFinite,
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: actionRefresh,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (bc, idx) {
                        var alamat = listAddress[idx];
                        return InkWell(
                          onTap: () {
                            Get.back(result: alamat);
                          },
                          child: ListAddress(
                            listAddress[idx],
                            () {
                              var address = listAddress[idx];
                              Get.defaultDialog(
                                  title: 'Hapus Alamat?',
                                  middleText: address.addressName ?? '',
                                  textConfirm: 'Lanjut',
                                  confirmTextColor: Colors.white,
                                  textCancel: 'Batal',
                                  onConfirm: () {
                                    Get.back(result: -1);
                                  }).then((value) {
                                if (value == -1) {
                                  postDeleteAddress(address);
                                }
                              });
                            },
                            () {
                              var address = listAddress[idx];
                              Get.to(EditAlamatScreen(address)).then((value) {
                                if (value == -1) {
                                  actionRefresh();
                                }
                              });
                            },
                          ),
                        );
                      },
                      itemCount: listAddress?.length ?? 0,
                    ),
                  ))),
          /**/
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Tambah Alamat',
                style: TextStyle(color: MyColor.redAT),
              ),
              onPressed: () {
                Get.toNamed(addAddressScreen)
                    .then((value) {
                  if (value == -1) {
                    refreshKey.currentState.show();
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
