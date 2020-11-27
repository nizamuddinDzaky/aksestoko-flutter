import 'package:aksestokomobile/controller/home/checkout_controller.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/payment_model.dart';
import 'package:aksestokomobile/model/sales_model.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/payment_screen.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class PaymentController extends State<PaymentScreen> {
  static CheckoutController get to => Get.find();
  final SelectProductController productController = Get.find();
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
  static const List<String> listPaymentMethod = [
    'cash on delivery',
    'cash before delivery',
    'kredit',
    'kredit_pro'
  ];
  List<Color> colorBank;
  List<int> indexBank = [0, 0];
  int indexTempo;
  bool isFirst = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  bool get isEmptyCredit =>
      paymentModel != null &&
      paymentModel.kreditPro == null &&
      paymentModel.tempoDenganDistributor == null;

  bool get isEmptyCash =>
      paymentModel != null &&
      paymentModel.bayarDitempat == null &&
      paymentModel.bayarSebelumDikirim == null;

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

  actionSubmit() {
    var salesModel = SalesModel();
    salesModel?.id_distributor = MyPref.getIdDistributor();
    salesModel?.price_group_id = MyPref.getPriceGroupId();
    salesModel?.customer_group_id = MyPref.getCustomerGroupId();
    salesModel?.uuid = paymentModel?.uuid;
    salesModel?.payment_method = paymentMethod;
    if (paymentMethod == listPaymentMethod[1]) {
      salesModel?.bank_id = selectedDelivery?.bankId;
    }
    if (paymentMethod == listPaymentMethod[2]) {
      salesModel?.bank_id = selectedDue?.bankId;
      salesModel?.payment_durasi = selectedDuration?.duration;
    }
    if (paymentMethod == listPaymentMethod[3]) {
      salesModel?.payment_durasi = selectedKreditPro?.durasiPembayaran;
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
    to.savePaymentScreen(salesModel);
  }

  void getPaymentMethod() async {
    SalesModel salesModel = Get.arguments;
    salesModel = salesModel ?? to.salesModel;
    var status = await ApiClient.methodGet(
      ApiConfig.urlListPayment,
      params: {
        'id_distributor': MyPref.getIdDistributor().toString(),
        'price_group_id': MyPref.getPriceGroupId().toString(),
        if (productController?.promoCode?.isNotEmpty ?? false)
          'promo': productController.promoCode,
        'is_checkout': 'true',
        'delivery_method': salesModel?.delivery_method,
      },
      customHandle: true,
      onBefore: (status) {
        isFirst = false;
      },
      onSuccess: (data, flag) {
        paymentModel = PaymentModel.fromJson(data['data']);
        // paymentModel.kreditPro = null;
        reInitConfig();
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Get.defaultDialog(
            title: "Pemberitahuan",
            content: Text(response?.message),
            textCancel: 'Tutup',
            onCancel: () {
              Get.back();
            }).then((value) {
          Get.back();
        });
      },
      onError: (title, message) {
        // Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
  }

  Future<void> actionRefresh() async {
    getPaymentMethod();
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
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
  }
}
