import 'package:aksestokomobile/model/order.dart';
import 'package:get/get.dart';

class ParentController extends GetController {
  List<Order> newOrders = [];

  List<Order> filter(status) {
    if (status != 'order_dalam_proses') return [];
    return newOrders;
  }

  addOrder(Order newOrder) {
    newOrders = newOrders ?? [];
    newOrders.add(newOrder);
    update();
  }

  clearOrder() {
    newOrders?.clear();
    newOrders = [];
    update();
  }
}
