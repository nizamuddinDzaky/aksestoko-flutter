import 'package:aksestokomobile/app/my_router.dart';
import 'package:aksestokomobile/controller/home/select_product_controller.dart';
import 'package:aksestokomobile/model/cart.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/model/base_response.dart';
import 'package:aksestokomobile/network/api_client.dart';
import 'package:aksestokomobile/network/api_config.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/resource/my_string.dart';
import 'package:aksestokomobile/screen/home/select_product.dart';
import 'package:aksestokomobile/util/my_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class SelectProductViewModel extends State<SelectProductScreen>
    with AutomaticKeepAliveClientMixin<SelectProductScreen> {
  var needUpdate = 0;
  var searchTextController = TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshKey.currentState.show();
    });
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
  List<Product> listSearch;

  List<Product> get listFilter => listSearch ?? listProduct ?? [];
  List<Cart> listCart = [];

  searchProduct(String query) {
    listSearch = listProduct?.where((p) {
      var result =
          p.nama?.toLowerCase()?.contains(query?.toLowerCase()) ?? false;
      if (result) debugPrint('filter ${p.nama} $query $result');
      return result;
    })?.toList();
    setState(() {});
  }

  getDataProduct() async {
    var params = {
      MyString.KEY_ID_DISTRIBUTOR: MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListProduct,
        params: params,
        onBefore: (status) {},
        customHandle: true, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      List<Product> newListProduct = baseResponse?.data?.listProduct ?? [];
      listProduct.clear();
      listProduct.addAll(newListProduct);
      buildCart();
    }, onFailed: (title, message) {
      var baseResponse = BaseResponse.fromString(message);
      Fluttertoast.showToast(
        msg: baseResponse.message,
        gravity: ToastGravity.CENTER,
      );
    }, onError: (title, message) {
          Fluttertoast.showToast(
            msg: 'Terjadi kesalahan data / koneksi',
            gravity: ToastGravity.CENTER,
          );
        }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
  }

  getDataCart() async {
    var params = {
      'id_distributor': MyPref.getIdDistributor(),
    };
    var status = await ApiClient.methodGet(ApiConfig.urlCart, params: params,
        onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListCart = baseResponse?.data?.listCart ?? [];
          listCart?.clear();
          listCart?.addAll(newListCart);
          buildCart();
        });
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
            data['data']['id_cart'] != null) {
          product.idCart = data['data']['id_cart'];
          product.countChange = 0;
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

  showDetailDistributor() {
    var distributor = Distributor.fromJson(MyPref.getMap('distributor'));
    debugPrint('klik ${distributor.imageUrl}');
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            kReleaseMode
                ? Image.asset(kDistributor, width: 112)
                : Container(
              height: 100,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FadeInImage.assetNetwork(
                  placeholder: kDistributor,
                  image: distributor?.imageUrl ?? '',
                  fit: BoxFit.cover,
                  // width: 100,
                  // height: 100,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Company',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,
            ),
            Text(
              distributor?.namaPrincipal ?? '',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            SizedBox(height: 8),
            Text(
              'Telepon',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,
            ),
            Text(
              distributor?.noTlpn ?? '',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            SizedBox(height: 8),
            Text(
              'Alamat',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,
            ),
            Text(
              distributor?.alamatLengkap ?? '',
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ));
  }
}
