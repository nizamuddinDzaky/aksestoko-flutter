import 'package:aksestokomobile/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectProductController extends GetController {
  List<Product> listCart;
  static SelectProductController get to => Get.find();

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

  void removeCart(Product p){
    p.qty = 0;
    listCart.remove(p);
    update();
  }

  void reduceCart(Product p, {double qty = 1, double customQty}){
    var order = p.qty;
    p.qty = customQty ?? (order - qty);
    p.qty = p.qty < 1 ? 1 : p.qty;
    /*if (!listCart.contains(p)) listCart.add(p);*/
    update();
  }

  int getSumItem(){
    int totalQty = 0;
    this.listCart.forEach((cart) => totalQty += cart.qty.toInt());
    return totalQty;
  }

  double getTotalHarga(){
    double total = 0.0;
    this.listCart.forEach(
        (cart) => total += (cart.qty * int.parse(cart.satuanHargaCash)));
    return total;
  }
}