import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/cart.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/home/select_product.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SelectProductViewModel extends State<SelectProductScreen> {
  @override
  void initState() {
    getDataProduct();
    getDataCart();
    super.initState();
  }

  Future<void> actionRefresh() async {
    final SelectProductController controller = Get.find();
    controller?.clearCart();
    listProduct = [];
    listCart = [];
    setState(() {});
    await getDataProduct();
    getDataCart();
    return Future.value();
  }

  List<Product> listProduct = [];
  List<Cart> listCart = [];

  getDataProduct() async {
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListProduct,
        params: params, onBefore: (status) {
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      List<Product> newListProduct = baseResponse?.data?.listProduct ?? [];
      listProduct.clear();
      listProduct.addAll(newListProduct);
      buildCart();
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  getDataCart() async {
    var params = {
      'id_distributor': MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlCart,
        params: params,
        onBefore: (status) {},
        onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListCart = baseResponse?.data?.listCart ?? [];
          listCart?.clear();
          listCart?.addAll(newListCart);
          buildCart();
        },
        onFailed: (title, message) {},
        onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        },
        onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  void confirmMinus() {}

  void buildCart() {
    final SelectProductController controller = Get.find();
    controller?.clearCart();
    if (listCart != null && listProduct != null) {
      listCart.forEach((cart) {
        listProduct.forEach((product) {
          if (cart.productId == product.productId) {
            product.idCart = cart.itemCartId;
            debugPrint("product => ${product.productId}");
            controller.addToCart(product, customQty: cart.qty.toDouble());
          }
        });
      });
    }
    setState(() {});
  }

  void confirm(SelectProductController vm, _alertDialog()) {
    if (vm.listCart == null || vm.listCart.length < 1) {
      _alertDialog();
    } else {
      Get.toNamed(checkoutScreen, arguments: vm.listCart).then((value) {
        debugPrint('cek value $value');
        if (value != null && value['errorcode'] == 400) {
          debugPrint('hapus cart');
        }
      });
    }
  }
}
