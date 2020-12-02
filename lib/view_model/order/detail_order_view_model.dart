import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class DetailOrderViewModel extends State<DetailOrderScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();
  OrderDetail orderDetail;

  Future<void> actionRefresh() async {
    await getListOrder();
  }

  getListOrder() async {
    if (Get.arguments == null) {
      debugPrint('argument kosong123 ${Get.arguments}');
      return;
    }
    var status = await ApiClient.methodGet(ApiConfig.urlDetailOrder,
        params: {
          'id_pemesanan': Get.arguments?.toString(),
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      orderDetail = OrderDetail.fromJson(data['data']);
    }, onFailed: (title, message) { 
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }
  void putUpdateOrder(String idPurchase, int type) async {
    var url = '';
    if(type == 1){
      url = ApiConfig.urlConfirmUpdatePrice;
    }else if(type == 2){
      url = ApiConfig.urlCancelUpdatePrice;
    }else if(type == 3){
      url = ApiConfig.urlCancelOrder;
    }else{
      return;
    }
    var body = {
      'id_pemesanan': idPurchase,
    };
    var status = await ApiClient.methodPut(url, body, {},
        onBefore: (status) {
          Get.back();
        }, onSuccess: (data, _) {
          var baseResponse = BaseResponse.fromJson(data);
          debugPrint("result => ${baseResponse?.data?.idPurchase}");
          getListOrder();
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onAfter: (status) {
        });
    status.execute();
  }

  showDialogLoader(String idPurchase, int type) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });

    await putUpdateOrder(idPurchase, type);
  }

  actionPostUrlKreditPro(String idPurchase) async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });
    await _postUrlKreditPro(idPurchase);
  }

  _postUrlKreditPro(String idPurchase)async{
    var body = {
      'id_pemesanan': idPurchase,
    };
    var status = await ApiClient.methodPost(ApiConfig.urlGetUrlKreditPro, body, {},
        onBefore: (status) {
          Get.back();
        }, onSuccess: (data, _) {
          var baseResponse = BaseResponse.fromJson(data);
          var urlKrediPro = "${baseResponse.data.urlKreditPro}${baseResponse.data.paramKreditPro}";
          /*debugPrint("result => ${baseResponse?.data.urlKreditPro}");*/
          /*getListOrder();*/
          Map<String, dynamic> _portaInfoMap = {
            "urlKreditPro": urlKrediPro,
            "idPurchase": idPurchase
          };
          Get.toNamed(paymentKreditProScreen, arguments: _portaInfoMap);
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message ?? 'Gagal'));
        }, onAfter: (status) {
        });
    status.execute();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
