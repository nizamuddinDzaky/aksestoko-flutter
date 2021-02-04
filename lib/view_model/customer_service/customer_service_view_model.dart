import 'package:aksestokomobile/model/issue.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/customer_service/customer_service.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CustomerServiceViewModel extends State<CustomerServiceScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Issue> listIssue = [];
  String dropdownValue = 'One';

  Future<void> actionRefresh() async {
    getListIssue();
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }

  void getListIssue() async {
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
      'supplier_id': MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListIssue,
        customHandle: true, params: params, onBefore: (status) {
      listIssue.clear();
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      List<Issue> newListIssue = baseResponse?.data?.listIssue ?? [];
      listIssue.clear();
      listIssue.addAll(newListIssue);
    }, onFailed: (title, message) {
      var response = BaseResponse.fromString(message);
      Fluttertoast.showToast(
        msg: response?.message ?? 'Gagal',
        gravity: ToastGravity.CENTER,
      );
    }, onError: (title, message) {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan data / koneksi',
        gravity: ToastGravity.CENTER,
      );
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }
}
