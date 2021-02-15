import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/credit_program.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/credit_program/credit_program_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class CreditProgramViewModel extends State<CreditProgramScreen> {

  List<CreditProgram> listCreditProgram = [];
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
    super.initState();
  }

  getListCreditProgram() async {
    listCreditProgram.clear();
    var status = await ApiClient.methodGet(ApiConfig.urlListCreditProgram,
        params: {}, onBefore: (status) {}, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          listCreditProgram = baseResponse.data.listCreditProgram;
          // debugLogs([data]);
        }, onFailed: (title, message) {
          debugPrint("failed");
          Get.defaultDialog(title: title, content: Text(message));
        }, onError: (title, message) {
          debugPrint("error");
          Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  Future<void> actionRefresh() async {
    await getListCreditProgram();
  }
}