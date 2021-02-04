import 'package:aksestokomobile/model/issue.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/customer_service/detail_issue_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class DetailIssueViewModel extends State<DetailIssueScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController commentController = TextEditingController();

  Issue oldIssue;
  Issue newIssue;

  Issue get issue => newIssue ?? oldIssue;

  @override
  void initState() {
    oldIssue = Get.arguments;
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }

  Future<void> actionRefresh() async {
    getDetailIssue();
  }

  void getDetailIssue() async {
    var params = {
      MyString.KEY_ID_ISSUE: oldIssue.id,
    };
    var status = await ApiClient.methodGet(ApiConfig.urlDetailIssue,
        customHandle: true,
        params: params,
        onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      newIssue = baseResponse?.data?.detailIssue;
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

  void actionSubmitComment() async {
    if (commentController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Comment Harus Di isi',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CircularProgressIndicator()],
            ),
          );
        });

    var body = {
      'id_issue': oldIssue.id,
      'comment': commentController.text,
    };

    var status = await ApiClient.methodPost(
      ApiConfig.urlAddComment,
      body,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        Fluttertoast.showToast(
          msg: data['message'],
          gravity: ToastGravity.CENTER,
        );
        refresh();
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

  void refresh() {
    commentController.text = '';
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }
}
