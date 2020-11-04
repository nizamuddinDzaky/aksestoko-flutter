import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/promo/list_promo.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class PromoViewModel extends State<ListPromoScreen> {

  List<Promo> listPromo = [];
  @override
  void initState() {
    getListPromo();
    super.initState();
  }

  void getListPromo() async {
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListPromo,
        params: params, onBefore: (status) {
//      Get.back();
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
          Get.defaultDialog(title: title, content: Text(message));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }
}