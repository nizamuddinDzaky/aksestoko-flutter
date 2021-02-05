import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/summary.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

abstract class SummaryViewModel extends State<SummaryScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  List<Summary> listSummary;
  DateTime initialDate;
  DateTime selectedDate;

  DateTime get currentDate => selectedDate ?? initialDate;

  pickMonth() {
    showMonthPicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDate: currentDate,
      locale: Locale("id"),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
          refreshKey.currentState.show();
        });
      }
    });
  }

  Future<void> actionRefresh() async {
    await getSummaryOrder();
  }

  getSummaryOrder() async {
    var params = {
      'date': DateFormat('yyyy-MM-dd').format(currentDate),
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlGetSummaryOrder,
      params: params,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        if (data['data']['data'] is List) {
          listSummary = (data['data']['data'] as List)
              .map((e) => Summary.fromJson(e))
              .toList();
        } else if (data['data']['data'] == null) {
          listSummary?.clear();
        }
      },
      onFailed: (title, message) {
        listSummary?.clear();
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

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    initialDate = DateTime(now.year, now.month, 1);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }
}
