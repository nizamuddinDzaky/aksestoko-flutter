import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/promo/list_promo.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class PromoViewModel extends State<ListPromoScreen>
    with AutomaticKeepAliveClientMixin {
  List<Promo> listPromo = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }

  Future<void> actionRefresh() async {
    getListPromo();
  }

  void getListPromo() async {
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
      'supplier_id': MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListPromo,
        customHandle: true, params: params, onBefore: (status) {
      listPromo.clear();
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      List<Promo> newListPromo = baseResponse?.data?.listPromo ?? [];
      listPromo.clear();
      listPromo.addAll(newListPromo);
      /*
          listProduct.clear();
          listProduct.addAll(newListProduct);
          buildCart();*/
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
