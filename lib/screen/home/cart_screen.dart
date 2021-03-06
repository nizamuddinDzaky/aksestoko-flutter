import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/screen/home/cart_item_screen.dart';
import 'package:aksestokomobile/util/my_number.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool CheckBoxValue = false;
  var needUpdate = 0;

  @override
  void initState() {
    super.initState();
    SelectProductController controller = Get.find();
    controller.onThen = () => setState(() {});
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      controller.validationCart(() {
        controller?.checkPromo();
      });
    });
  }

  void validationCart(SelectProductController vm, Function nextAct) {
    needUpdate = 0;
    vm.listCart?.forEach((product) {
      if (1 > (product.idCart ?? 0) || (product.countChange ?? 0) > 0) {
        needUpdate++;
      }
    });
    if (needUpdate > 0) {
      vm.listCart?.forEach((product) {
        if (0 == (product.idCart ?? 0) && (product.countChange ?? 0) != 0) {
          _postAddCart(product).then((_) {
            if (needUpdate == 0) {
              nextAct?.call();
            }
          });
        }
      });
    } else {
      nextAct?.call();
    }
  }

  void confirm(SelectProductController vm, _alertDialog()) async {
    if (vm.currentFocus != null) {
      vm.currentFocus?.unfocus();
      await Future.delayed(Duration(milliseconds: 200));
    }
    if (vm.listCart == null || vm.listCart.length < 1) {
      _alertDialog();
    } else {
      vm.validationCart(() {
        Get.toNamed(checkoutScreen, arguments: vm.listCart);
      });
    }
  }

  _postAddCart(Product product) async {
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'product_id': product?.productId,
      'quantity': product?.qty,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddItemCart,
      fields,
      {},
      customHandle: true,
      onSuccess: (data, _) {
        if (data != null &&
            data['data'] != null &&
            data['data']['id_cart'] != null) {
          product.idCart = data['data']['id_cart'];
          product.countChange = 0;
        }
        needUpdate--;
      },
    );
    status.execute();
  }

  void _alertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Perhatian"),
          content: Text("Keranjang masih kosong. Silahkan pilih produk."),
          actions: <Widget>[
            FlatButton(
              child: Text("Tutup"),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Widget formLayout(SelectProductController controller) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: controller.listCart == null || controller.listCart.length < 1
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/pemesanan-grey.png',
                        width: 64,
                        height: 64,
                        color: MyColor.redAT,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keranjang Kosong',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ))
                : _gridCart(controller),
          ),
        ],
      ),
    );
  }

  Widget _gridCart(SelectProductController controller) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      itemCount: controller.listCart.length,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        // key: UniqueKey(),
        child: CartItemScreen(controller.listCart[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectProductController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Hero(
            tag: 'logoForcaPoS',
            child: Text("Keranjang"),
          ),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: formLayout(controller)),
        bottomNavigationBar: new Column(
          mainAxisSize: MainAxisSize.min,
          /*overflow: Overflow.visible,*/
          children: [
            new Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              /*height: 100,*/
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 9), // changes position of shadow
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            if (controller.currentPromo == null &&
                                controller.promoCode != null)
                              SizedBox(width: 8),
                            if (controller.currentPromo != null ||
                                controller.promoCode != null)
                              Flexible(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        minSize: 0,
                                        child: Text(
                                          controller.currentPromo != null
                                              ? "${controller.currentPromo
                                              .name} (${controller.currentPromo
                                              .codePromo})"
                                              : (controller.promoCode ??
                                              'Kode Promo'),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        onPressed: () {
                                          validationCart(controller, () {
                                            controller.inputPromoCode();
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: MyColor.redAT,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          controller.deletePromoCode();
                                        })
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Flexible(
                          child: Text(
                            "${MyNumber.toNumberRpStr(controller.getTotalHarga().toString())}",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 5),
                        if (controller.currentPromo != null)
                          Row(
                            children: [
                              Text(
                                "Diskon",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        if (controller.currentPromo != null)
                          Flexible(
                            child: Text(
                              "${MyNumber.toNumberRpStr(controller.currentPromo?.value)}",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 45,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          width: double.maxFinite,
                          height: 30,
                          child: RaisedButton(
                            color: MyColor.blueDio,
                            child: Text(
                              'Kode Promo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: (controller.currentPromo != null ||
                                controller.promoCode != null)
                                ? null
                                : () {
                              validationCart(controller, () {
                                controller.inputPromoCode();
                              });
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          width: double.maxFinite,
                          height: 50,
                          child: RaisedButton(
                            color: MyColor.redAT,
                            child: Text(
                              'Lanjutkan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: (controller.currentPromo == null &&
                                controller.promoCode != null)
                                ? null
                                : () {
                              confirm(controller, _alertDialog);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
