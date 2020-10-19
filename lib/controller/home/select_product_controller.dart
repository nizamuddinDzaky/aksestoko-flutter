import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:get/get.dart';

class SelectProductController extends GetController {
  static SelectProductController get to => Get.find();
  List<Product> listCart;

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (listCart == null) listCart = [];
    var order = p.qty;
    p.qty = customQty ?? (order + qty);
    p.qty = p.qty < 1 ? 1 : p.qty;
    if (!listCart.contains(p)) {
      listCart.add(p);
    }
    update();
  }

  void removeCart(Product p) {
    p.qty = 0;
    listCart.remove(p);
    update();
  }

  clearCart() {
    listCart.clear();
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
        // (cart) => total += (cart.qty * int.parse(cart.satuanHargaCash)));
        (cart) => total += (cart.qty * cart.satuanHargaCash.toDouble()));
    return total;
  }
}
