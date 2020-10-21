import 'package:aksestokomobile/model/order.dart';

class OrderModel {
  String rows;
  int jumlahPesananProses;
  List<Order> listOrderDalamProses;

  OrderModel({
    this.rows,
    this.jumlahPesananProses,
    this.listOrderDalamProses,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    rows = json['rows'];
    jumlahPesananProses = json['jumlah_pesanan_proses'];
    if (json['list_order_dalam_proses'] != null) {
      listOrderDalamProses = new List<Order>();
      json['list_order_dalam_proses'].forEach((v) {
        listOrderDalamProses.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rows'] = this.rows;
    data['jumlah_pesanan_proses'] = this.jumlahPesananProses;
    if (this.listOrderDalamProses != null) {
      data['list_order_dalam_proses'] =
          this.listOrderDalamProses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
