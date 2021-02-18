import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/at_icon.dart';
import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/helper/my_notification.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/screen/home/select_product.dart'
    as selectProduct;
import 'package:aksestokomobile/screen/order/history_order_screen.dart'
    as historyOrder;
import 'package:aksestokomobile/screen/promo/list_promo.dart' as listPromo;
import 'package:aksestokomobile/screen/account/account_screen.dart' as Account;
import 'package:get/get.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:upgrader/upgrader.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int selectedPage;
  PageController _myPage;
  var myNotification = MyNotification();

  Widget _buildDialog(BuildContext context, Item item) {
    var content = [item?.title, item?.body]
        ?.where((element) => element != null)
        ?.join('\n');
    content = content.isEmpty ? null : content;
    return AlertDialog(
      content: Text(content ?? 'Ada notifikasi masuk'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Tutup'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('Detail'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) {
      // return route is ParentScreen;
      debugLog("route name ${route.settings.name}");
      return route is PageRoute;
    });
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  Widget _layoutDialog({String img, String feedbackTotal, bool status}) {
    return AlertDialog(
      title: Text('Survei Pelanggan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isDebugOnly) Text('Status: $status'),
          Flexible(
            child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: CachedNetworkImage(
                        height: 128,
                        width: 128,
                        imageUrl: img ??
                            'https://qp.forca.id/themes/aksestoko/assets/img/help/survey-at.png',
                        placeholder: (context, url) =>
                            Image.asset(kNoImageLandscape),
                        errorWidget: (context, url, error) =>
                            Image.asset(kNoImageLandscape),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        "Berikan pengalaman terbaik anda bersama AksesToko agar kami dapat terus memberikan pelayanan yang terbaik bagi anda",
                        style: TextStyle(
                          color: MyColor.blackTextAT,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        "${feedbackTotal ?? '0'} pengguna telah berpatisipasi dalam survei ini.",
                        style: TextStyle(
                          color: MyColor.warningTextAT,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('Skip'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: MyColor.redAT,
                child: Text(
                  'Ya',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Get.toNamed(customerSurvey);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _dialogCustomerSurvei({String img, String feedbackTotal, bool status}) {
    return showDialog(
      context: context,
      builder: (context) {
        return _layoutDialog(
          img: img,
          feedbackTotal: feedbackTotal,
          status: status,
        );
      },
    );
  }

  _getSurvei() async {
    var status = await ApiClient.methodGet(ApiConfig.urlGetCustomerSurvey,
        params: {}, onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      if (isDebugOnly || (baseResponse?.data?.isSetSurvey ?? false)) {
        _dialogCustomerSurvei(
          img: baseResponse?.data?.imageSurvey,
          feedbackTotal: baseResponse?.data?.feedbackTotal,
          status: (baseResponse?.data?.isSetSurvey ?? false),
        );
      }
    }, onFailed: (title, message) {
      debugPrint("failed");
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      debugPrint("error");
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedPage = isDebugMode ? 3 : 0;
    triggerOnMessage = (message) {
      _showItemDialog(message);
    };
    triggerOnResume = (message) {
      _navigateToItemDetail(message);
    };
    triggerOnSave = (message) {
      try {
        ParentController to = Get.find();
        to.addNotif(item: itemForMessage(message));
      } catch (e) {
        debugLog('$e');
      }
    };
    myNotification.init(context);
    myNotification.actionTriggerOnBackground((message) {
      debugLog('pindah halaman ${message != null}');
      _navigateToItemDetail(message);
    });
    _myPage = PageController(initialPage: selectedPage);
    if (isDebugQA) _getSurvei();
  }

  @override
  void dispose() {
    myNotification.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var body = GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<ParentController>(
        init: ParentController(),
        builder: (controller) => PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          children: <Widget>[
            selectProduct.SelectProductScreen(),
            listPromo.ListPromoScreen(),
            historyOrder.HistoryOrderScreen(),
            Account.AccountScreen(),
          ],
        ),
      ),
    );
    var upgrader = UpgradeAlert(
      // appcastConfig: cfg,
      debugLogging: isDebugOnly,
      showIgnore: false,
      showLater: false,
      child: body,
    );

    return Scaffold(
      body: upgrader,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconAT.home, size: 26),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.list_sales, size: 26),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconAT.store, size: 26),
            label: 'Akun',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25,
        currentIndex: selectedPage,
        selectedItemColor: MyColor.redAT,
        onTap: (index) {
          setState(() {
            _myPage.jumpToPage(index);
            selectedPage = index;
          });
        },
      ),
    );
  }
}
