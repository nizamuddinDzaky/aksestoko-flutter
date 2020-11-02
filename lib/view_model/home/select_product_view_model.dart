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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class SelectProductViewModel extends State<SelectProductScreen> {
  var needUpdate = 0;

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
        params: params, onBefore: (status) {}, onSuccess: (data, flag) {
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
        _updateDataToServer(vm);
      } else {
        _actionNextToCheckout(vm);
      }
    }
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

  _updateDataToServer(vm) async {
    vm.listCart?.forEach((product) {
      if (0 == (product.idCart ?? 0) && (product.countChange ?? 0) != 0) {
        _postAdd(product).then((_) => _actionNextToCheckout(vm));
      } else if (0 != (product.idCart ?? 0) &&
          (product.countChange ?? 0) != 0) {
        _postUpdate(product).then((_) => _actionNextToCheckout(vm));
      }
    });
  }

  Future<void> _postAdd(Product product) async {
    if (product.qty <= 0) {
      Fluttertoast.showToast(msg: 'Quantity tidak boleh <= 0');
      return;
    }
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
            data['data']['item_cart_id'] != null) {
          product.idCart = data['data']['item_cart_id'];
        }
        needUpdate--;
      },
    );
    status.execute();
  }

  Future<void> _postUpdate(Product product) async {
    if (product.qty <= 0) {
      Fluttertoast.showToast(msg: 'Quantity tidak boleh <= 0');
      return;
    }
    var fields = {
      'id_distributor': MyPref.getIdDistributor(),
      'id_cart': product?.idCart,
      'quantity': product?.qty,
      'price_group_id': MyPref.getPriceGroupId(),
      // 'promo': promoCode,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateItemCart,
      fields,
      {},
      customHandle: true,
      onSuccess: (data, _) {
        product.countChange = 0;
        needUpdate--;
      },
    );
    status.execute();
  }
}
