import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/sales_person.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/sales_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class SalesPersonViewModel extends State<SalesPersonScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  SalesPerson salesPerson = SalesPerson();
  var referralCodeTextController = TextEditingController();

  Future<void> actionRefresh() async {
    await getSalesPerson();
  }

  getSalesPerson() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailSalesPerson,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        salesPerson = response?.data?.salesPerson;
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  void putReferralCode(String referralCode) async {
    if (referralCode?.isEmpty ?? true) return;
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateSalesPerson,
      {
        'sales_person': referralCode,
      },
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var response = BaseResponse.fromJson(data);
        salesPerson = response?.data?.salesPerson;
        _actionRefresh();
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        var length = response?.message?.length ?? 0;
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
          toastLength: length > 50 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        );
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  void _actionRefresh() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }

  @override
  void initState() {
    super.initState();
    _actionRefresh();
  }
}
