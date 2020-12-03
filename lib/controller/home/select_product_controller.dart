import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SelectProductController extends GetController {
  static SelectProductController get to => Get.find();
  List<Product> listCart;
  String promoCode;
  String promoName;
  String promoValue;
  FocusNode currentFocus;
  Promo currentPromo;
  Function onThen;

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (listCart == null) listCart = [];
    var order = p.qty;
    p.qty = customQty ?? (order + qty);
    p.qty = p.qty < 1 ? 1 : p.qty;
    Product product;
    if (listCart.length > 0) {
      product = listCart.firstWhere(
        (p2) => p2.productId == p.productId,
        orElse: () => null,
      );
    }
    if (product == null) {
      listCart.add(p);
    }
    update();
  }

  void removeCart(Product p) {
    p?.qty = 0;
    listCart?.remove(p);
    update();
  }

  resetCart() {
    promoCode = null;
    currentPromo = null;
    listCart?.forEach((product) {
      product.idCart = 0;
      product.qty = 0;
    });
    listCart?.clear();
    update();
  }

  clearCart() {
    listCart?.clear();
    update();
  }

  void refresh() {
    update();
  }

  int getSumItem() {
    int totalQty = 0;
    this.listCart?.forEach((cart) => totalQty += cart.qty.toInt());
    return totalQty;
  }

  void reduceCart(Product p, {double qty = 1, double customQty}) {
    var order = p.qty;
    p.qty = customQty ?? (order - qty);
    p.qty = p.qty < 1 ? 1 : p.qty;
    update();
  }

  double getTotalHarga() {
    double total = 0.0;
    this.listCart?.forEach(
            (cart) => total += (cart.qty * cart.satuanHargaCash.toDouble()));
    return total;
  }

  /// cart_screen.dart start
  openDialog(context, {int step = 0, data}) async {
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
    if (step == 1) {
      await _actionDelete(data);
    } else if (step == 2) {
    } else if (step == 3) {
    } else {}
  }

  actionAdd(Product product, {VoidCallback onRefresh}) async {
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
        },
        onAfter: (_) {
          onRefresh?.call();
        }
    );
    status.execute();
  }

  actionUpdate(Product product, int qty,
      {VoidCallback onRefresh, int cusQty}) async {
    var newQty = cusQty ?? ((product?.qty ?? 0.0) + qty);
    if (newQty < 0) {
      Fluttertoast.showToast(msg: 'Quantity tidak boleh kurang dari 0');
      return;
    }
    int multiple = product?.isMultiple == 1 ? 1 : 0;
    int minQty = product?.minOrder ?? 1;
    minQty = minQty < 1 ? 1 : minQty;
    if (qty >= 0) {
      minQty = minQty == 0 ? 1 : minQty;
      var add = minQty - (newQty % minQty);
      newQty += (add % minQty) * (newQty < minQty ? 1 : multiple);
    } else {
      var min = newQty % minQty;
      newQty -= (min * (newQty < minQty ? 1 : multiple));
    }
    if (product != null && product.idCart == null) {
      actionAdd(product, onRefresh: onRefresh);
      return;
    }
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'id_cart': product?.idCart,
      'quantity': newQty,
      'price_group_id': MyPref.getPriceGroupId(),
      'promo': promoCode,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateItemCart,
      fields,
      {},
      customHandle: true,
      onBefore: (status) {},
      onSuccess: (data, _) {
        product.countChange = 0;
        var response = BaseResponse.fromJson(data);
        currentPromo = response?.data?.promo;
        SelectProductController controller = Get.find();
        controller?.addToCart(product, customQty: newQty.toDouble());
        if (currentPromo == null && promoCode != null &&
            response?.data?.statusPromo != null) {
          Fluttertoast.showToast(
            msg: response?.data?.statusPromo ?? '',
            gravity: ToastGravity.CENTER,
          );
        }
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {
        if (onRefresh != null) onRefresh();
      },
    );
    status.execute();
  }

  _actionDeleteFromCart(Product product) async {
    SelectProductController controller = Get.find();
    product?.idCart = null;
    controller?.removeCart(product);
    checkPromo();
  }

  checkPromo() {
    if ((promoCode?.isNotEmpty ?? false) && (listCart?.isNotEmpty ?? false))
      _actionGetPromo(promoCode);
  }

  _actionDelete(Product product) async {
    if (product != null && product.idCart == null) {
      _actionDeleteFromCart(product);
      Get.back();
      return;
    }
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'id_cart': product?.idCart,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlDeleteItemCart,
      fields,
      {},
      customHandle: true,
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, _) {
        _actionDeleteFromCart(product);
      },
      onFailed: (title, message) {
        var response = BaseResponse.fromString(message);
        Fluttertoast.showToast(
          msg: response?.message ?? 'Gagal',
          gravity: ToastGravity.CENTER,
        );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  inputPromoCode() {
    var promoTextController = TextEditingController(text: promoCode);
    Get.defaultDialog(
      title: 'Masukkan Kode Promo',
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: TextFormField(
          controller: promoTextController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Kode Promo',
          ),
        ),
      ),
      textCancel: 'Batal',
      textConfirm: 'Cek',
      confirmTextColor: Colors.white,
      onConfirm: () {
        _actionPromo(promoTextController.text);
      },
    );
  }

  _actionPromo(String newCode) {
    Get.back();
    if (newCode?.isEmpty ?? false) {
      promoCode = null;
      update();
    } else {
      _actionGetPromo(newCode);
      /*promoCode = newCode;*/
      update();
    }
  }

  _actionGetPromo(String codePromo) async{
    var body = {
      'id_distributor': MyPref.getIdDistributor(),
      'code_promo': codePromo,
      'price_group_id' : MyPref.getPriceGroupId()
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddPromo,
      body,
      {},
      customHandle: true,
      onBefore: (status) {

      },
      onSuccess: (data, _) {
        var response = BaseResponse.fromJson(data);
        currentPromo = response.data.promo;
        promoCode = response.data.promo.codePromo;
        promoName = response.data.promo.name;
        promoValue = response.data.promo.value.toString();
        debugPrint("value : ${response.data.promo.value}");
        update();
      },
      onFailed: (title, message) {
        currentPromo = null;
        // sudah di handle saat action update
        // var response = BaseResponse.fromString(message);
        // Fluttertoast.showToast(
        //   msg: response?.message ?? 'Gagal',
        //   gravity: ToastGravity.CENTER,
        // );
      },
      onError: (title, message) {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan data / koneksi',
          gravity: ToastGravity.CENTER,
        );
      },
      onAfter: (status) {
        onThen?.call();
        update();
      },
    );
    status.execute();
  }

  deletePromoCode() {
    promoCode = null;
    promoName = null;
    promoValue = null;
    currentPromo = null;
    update();
  }

  var needUpdate = 0;

  void validationCart(Function nextAct) {
    needUpdate = 0;
    listCart?.forEach((product) {
      var idCart = (product.idCart ?? 0);
      var countChange = (product.countChange ?? 0);
      needUpdate += (idCart == 0 || countChange == 1) ? 1 : 0;
    });
    if (needUpdate > 0) {
      listCart?.forEach((product) {
        var idCart = (product.idCart ?? 0);
        var countChange = (product.countChange ?? 0);
        // if ((0 == idCart && countChange != 0) || (0 != idCart && countChange != 0)) {
        if (idCart == 0 || countChange == 1) {
          debugPrint('action update');
          actionUpdate(
            product,
            0,
            cusQty: product.qty?.toInt() ?? 0,
            onRefresh: () {
              needUpdate--;
              if (needUpdate == 0) {
                nextAct?.call();
              }
            },
          );
        }
      });
    } else {
      nextAct?.call();
    }
  }

/// cart_screen.dart end
}
