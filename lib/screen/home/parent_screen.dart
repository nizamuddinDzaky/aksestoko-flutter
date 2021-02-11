import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/resource/at_icon.dart';
import 'package:aksestokomobile/controller/parent_controller.dart';
import 'package:aksestokomobile/helper/item.dart';
import 'package:aksestokomobile/helper/my_notification.dart';
import 'package:aksestokomobile/main_common.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_util.dart';
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
import 'package:aksestokomobile/model/question.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int selectedPage;
  PageController _myPage;
  List<Question> listQuestion = [];
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

  _dialogCustomerSurvei(){
    debugPrint("asdasdasdsadsdasdas12312");
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Survei Pelanggan'),
          content: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            child: FadeInImage.assetNetwork(
                              placeholder: kNoImageLandscape,
                              image: 'https://qp.forca.id/themes/aksestoko/assets/img/help/survey-at.png',
                              fit: BoxFit.fitWidth,
                            ),
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
                            "15 pengguna telah berpatisipasi dalam survei ini.",
                            style: TextStyle(
                              color: MyColor.blackTextAT,
                              fontStyle: FontStyle.italic,
                              // fontWeight: FontWeight.,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                ),
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
        )
    );
  }

  _getSurvei() async{
    listQuestion.clear();
    var status = await ApiClient.methodGet(ApiConfig.urlGetCustomerSurvey,
        params: {},
        onBefore: (status) {}, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          listQuestion = baseResponse.data.listQuestion;
          /*if(baseResponse.data.isSetSurvey){*/
            _dialogCustomerSurvei();
          /*}*/
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
    _getSurvei();
  }

  @override
  void dispose() {
    myNotification.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ParentController>(
          init: ParentController(),
          builder: (controller) =>
              PageView(
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
      ),
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
