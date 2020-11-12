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

  void confirm(SelectProductController vm, _alertDialog()) async {
    if (vm.currentFocus != null) {
      vm.currentFocus?.unfocus();
      await Future.delayed(Duration(milliseconds: 200));
    }
    if (vm.listCart == null || vm.listCart.length < 1) {
      _alertDialog();
    } else {
      needUpdate = 0;
      vm.listCart?.forEach((product) {
        debugPrint('cek countUpdate ${product.countChange}');
        if (1 > (product.idCart ?? 0) || (product.countChange ?? 0) > 0) {
          needUpdate++;
        }
      });
      debugPrint('action check cart $needUpdate');
      if (needUpdate > 0) {
        _addDataToServer(vm);
      } else {
        _actionNextToCheckout(vm);
      }
    }
  }

  _addDataToServer(vm) {
    vm.listCart?.forEach((product) {
      if (0 == (product.idCart ?? 0) && (product.countChange ?? 0) != 0) {
        _postAddCart(product).then((_) => _actionNextToCheckout(vm));
      } else if (0 != (product.idCart ?? 0) &&
          (product.countChange ?? 0) != 0) {
        // _postUpdate(product).then((_) => _actionNextToCheckout(vm));
      }
    });
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

  _actionNextToCheckout(vm) {
    if (needUpdate == 0) {
      Get.toNamed(checkoutScreen, arguments: vm.listCart).then((value) {
        debugPrint('cek value $value');
        if (value != null && value['errorcode'] == 400) {
          debugPrint('hapus cart');
        }
      });
    }
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
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child:
                  controller.listCart == null || controller.listCart.length < 1
                      ? new Text('Keranjang Kosong')
                      : _gridCart(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCart(SelectProductController controller) {
    return ListView.builder(
        itemCount: controller.listCart.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            CartItemScreen(controller.listCart[index]));
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
          // bottom: controller.listCart?.isEmpty ?? true
          bottom: true
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Container(
                    color: Colors.white,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: CheckBoxValue,
                              onChanged: (bool value) {
                                setState(() {
                                  CheckBoxValue = value;
                                });
                              },
                            ),
                            Text("Pilih Semua"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: CupertinoButton(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 2),
                                      child: Text(
                                        'Hapus',
                                        style: TextStyle(
                                            color: MyColor.blackTextAT,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '(${controller.listCart?.length})',
                                      style: TextStyle(
                                          color: MyColor.blackTextAT,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // openDialog(step: 1, data: );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          child: Text(
                            controller.promoCode != null ? "${controller.promoName}(${controller.promoCode})": 'Kode Promo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            controller.inputPromoCode();
                          },
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
                        if(controller.promoValue != null)
                        Row(
                          children: [
                            Text(
                              "Diskon",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: MyColor.redAT,
                                  size: 15,
                                ),
                                onPressed: () {
                                  controller.deletePromoCode();
                                }
                                )
                          ],
                        ),
                        if(controller.promoValue != null)
                        Flexible(
                          child: Text(
                            "${MyNumber.toNumberRpStr(controller.promoValue)}",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 0),
                      width: double.maxFinite,
                      height: 50,
                      child: RaisedButton(
                        color: MyColor.redAT,
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          // debugPrint("token : ${MyPref.getATToken()}");
                          confirm(controller, _alertDialog);
                          // Get.toNamed(checkoutScreen,
                          //     arguments: controller.listCart);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      ),
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
