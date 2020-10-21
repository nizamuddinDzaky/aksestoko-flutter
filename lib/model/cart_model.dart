import 'package:aksestokomobile/model/cart.dart';

class CartModel {
  int jumlahBelanja;
  List<Cart> listBelanja;

  CartModel({this.jumlahBelanja, this.listBelanja});

  CartModel.fromJson(Map<String, dynamic> json) {
    jumlahBelanja = json['jumlah_belanja'];
    if (json['list_belanja'] != null) {
      listBelanja = new List<Cart>();
      json['list_belanja'].forEach((v) {
        listBelanja.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_belanja'] = this.jumlahBelanja;
    if (this.listBelanja != null) {
      data['list_belanja'] = this.listBelanja.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
