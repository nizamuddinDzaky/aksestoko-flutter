import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/edit_alamat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EditAlamatViewModel extends State<EditAlamatScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  dynamic vm;
  Address address;
  var village;
  var selectVillage;
  var province;
  var selectProvince;
  var district;
  var subDistrict;
  var selectSubDistrict;
  var selectDistrict;

  void _getAddress() async {
    var params = {
      'id_address': widget.address?.addressId ?? '',
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailAddress,
      params: params,
      onBefore: (status) {},
      onSuccess: (data, flag) {},
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text('Gagal'));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text('Gagal'));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    _getAddress();
    super.initState();
  }
}
