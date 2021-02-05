import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/profile.dart';
import 'package:aksestokomobile/model/reward.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/account/reward_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class RewardViewModel extends State<RewardScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  Profile profile;
  List<Reward> listReward = [];

  Future<void> actionRefresh() async {
    await getListReward();
  }

  getListReward() async {
    var params = {
      'kode_bk': profile?.kodeBk,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlGetReward,
      params: params,
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        List<Reward> newListReward = baseResponse?.data?.listReward ?? [];
        listReward.clear();
        listReward.addAll(newListReward);
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

  @override
  void initState() {
    super.initState();
    profile = Profile.fromJson(MyPref.getMap('profile'));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }
}
