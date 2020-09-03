import 'package:aksestokomobile/model/Product.dart';
import 'package:get/get.dart';

class SelectProductController extends GetController {
  List<Product> listCart;
  static SelectProductController get to => Get.find();

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (listCart == null) listCart = [];
    var order = p.qty;
    p.qty = customQty ?? (order + qty);
    if (!listCart.contains(p)) listCart.add(p);
    update();
  }

  void removeCart(Product p){
    p.qty = 0;
    listCart.remove(p);
    update();
  }
}