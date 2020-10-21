import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/screen/account/update_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class UpdateProfileController extends State<UpdateProfileScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String tlp;

  Future<void> actionRefresh() async {
    await getSalesPerson();
  }

  getSalesPerson() async {
    var status = await ApiClient.methodGet(ApiConfig.urlDetailProfile,
        onBefore: (status) {},
        onSuccess: (data, flag) {}, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
