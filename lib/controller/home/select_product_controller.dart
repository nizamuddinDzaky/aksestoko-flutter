import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/model/product.dart';
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
    } else if (step == 2) {} else if (step == 3) {} else {}
  }

  actionUpdate(Product product, int qty,
      {VoidCallback onRefresh, int cusQty}) async {
    var newQty = cusQty ?? ((product?.qty ?? 0.0) + qty);
    if (newQty < 0) {
      Fluttertoast.showToast(msg: 'Quantity tidak boleh kurang dari 0');
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
        SelectProductController controller = Get.find();
        if (cusQty != null) {
          controller?.addToCart(product, customQty: cusQty.toDouble());
        } else if (qty < 0) {
          controller?.reduceCart(product);
        } else if (qty > 0) {
          controller.addToCart(product);
        } else {
          Fluttertoast.showToast(
            msg: 'Terjadi kesalahan data / koneksi',
            gravity: ToastGravity.CENTER,
          );
        }
        if (onRefresh != null) onRefresh();
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

  _actionDeleteFromCart(data) async {
    SelectProductController controller = Get.find();
    controller?.removeCart(data);
  }

  _actionDelete(data) async {
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'id_cart': data?.idCart,
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
        _actionDeleteFromCart(data);
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
      promoCode = '';
      update();
    } else {
      promoCode = newCode;
      update();
    }
  }

/// cart_screen.dart end
}
