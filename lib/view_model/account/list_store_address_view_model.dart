import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/list_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class ListStoreAddressViewModel extends State<ListAddressScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Alamat> listAddress;

  Future<void> actionRefresh() async {
    await getListAddress();
  }

  postDeleteAddress(Alamat alamat) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlDeleteAddress,
      {
        'address_id': alamat?.addressId,
      },
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: 'Success',
          gravity: ToastGravity.CENTER,
        );
        listAddress?.remove(alamat);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  void getListAddress() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListAddress,
        onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      var newListAddress = baseResponse?.data?.listAlamat ?? [];
      listAddress = listAddress ?? [];
      listAddress
        ..clear()
        ..addAll(newListAddress);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text('Gagal'));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text('Gagal'));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
