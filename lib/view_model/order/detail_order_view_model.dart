import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/order.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/model/sales_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/order/detail_order_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
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
    var idPemesanan = Get.arguments ?? widget.idPemesanan;
    if (idPemesanan == null) {
      debugPrint('argument kosong123 ${idPemesanan}');
      return;
    }
    var status = await ApiClient.methodGet(ApiConfig.urlDetailOrder,
        params: {
          'id_pemesanan': '$idPemesanan',
        },
        customHandle: true,
        onBefore: (status) {}, onSuccess: (data, flag) {
      orderDetail = OrderDetail.fromJson(data['data']);
    }, onFailed: (title, message) {
      var response = BaseResponse.fromString(message);
      Get.defaultDialog(
        title: 'Gagal',
        content: Text(response?.message ?? 'Gagal'),
      );
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

  String textButton(){
    if(orderDetail?.detailPemesanan?.statusPemesanan.toLowerCase() == 'menunggu konfirmasi'){
      return "Batalkan Pesanan";
    }else if(orderDetail?.detailPemesanan.ajukanKredit != null){
      return "Ajukan Kredit";
    }else if(orderDetail?.detailPemesanan.konfirmasiPembayaran != null){
      return "Selesaikan Pembayaran";
    }else if(orderDetail?.detailPemesanan.pilihMetodePembayaran != null){
      return "Pilih Metode Pembayaran";
    }
  }

  toPaymentScreent(){
    var salesModel = SalesModel()
      ..delivery_method = _getShipmentMethod()
        ..id_pemesanan = orderDetail?.detailPemesanan.idPemesanan;
    Get.toNamed(paymentScreen, arguments: salesModel);
  }

  String _getShipmentMethod(){
    if(orderDetail?.detailPemesanan.caraPengiriman.toLowerCase() == "pengiriman distributor"){
      return "delivery";
    }else if(orderDetail?.detailPemesanan.caraPengiriman.toLowerCase() == "pengambilan sendiri"){
      return "pickup";
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshKey?.currentState?.show();
    });
  }
}
