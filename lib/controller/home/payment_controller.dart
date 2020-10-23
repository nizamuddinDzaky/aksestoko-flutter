import 'package:aksestokomobile/model/payment_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/payment_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PaymentController extends State<PaymentScreen> {
  PaymentModel paymentModel;
  Detail selectedKreditPro;
  ListBank selectedDue;
  ListBank selectedDelivery;
  ListPaymentDurasi selectedDuration;
  bool cashOnDelivery = false;
  bool cashBeforeDelivery = false;
  bool kreditPro = false;
  bool tempoDistributor = false;
  int currentTab = 0;
  String paymentMethod;
  List<String> listPaymentMethod = [
    'cash on delivery',
    'cash before delivery',
    'kredit',
    'kredit_pro'
  ];
  List<Color> colorBank;
  List<int> indexBank;
  int indexTempo;

  reInitConfig() {
    indexBank = [0, 0];
    selectedDuration =
        paymentModel?.tempoDenganDistributor?.listPaymentDurasi?.first;
    var listKreditPro = paymentModel?.kreditPro?.detail;
    listKreditPro
        ?.sort((a, b) => a.durasiPembayaran.compareTo(b.durasiPembayaran));
    selectedKreditPro = listKreditPro?.first;
  }

  setIndexMethod(paymentMethodValue) {
    cashOnDelivery = paymentMethodValue == listPaymentMethod[0];
    cashBeforeDelivery = paymentMethodValue == listPaymentMethod[1];
    tempoDistributor = paymentMethodValue == listPaymentMethod[2];
    kreditPro = paymentMethodValue == listPaymentMethod[3];
    paymentMethod = paymentMethodValue;
  }

  void getPaymentMethod() async {
    /*
is_checkout (riquired) = true
id_distributor (riquired)
delivery_method (riquired)
price_group_id
promo
    */
    var status = await ApiClient.methodGet(ApiConfig.urlListPayment,
        params: {
          'id_distributor': MyPref.getIdDistributor().toString(),
          'is_checkout': 'true',
          'delivery_method': 'delivery',
          // 'delivery_method': 'pickup',
        },
        onBefore: (status) {}, onSuccess: (data, flag) {
      paymentModel = PaymentModel.fromJson(data['data']);
      reInitConfig();
    }, onFailed: (title, message) {
      Get.defaultDialog(
          title: "Pemberitahuan",
          content: Text("Proses tidak bisa dilanjutkan $message"),
          textCancel: 'Tutup',
          onCancel: () {
            Get.back();
          }).then((value) {
        Get.back();
      });
    }, onError: (title, message) {
      // Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    colorBank = [
      Color(0xFFff8a65),
      Color(0xFF4fc3f7),
      Color(0xFF9575cd),
      Color(0xFF4db6ac)
    ];
    indexTempo = 0;
    getPaymentMethod();
  }
}
