import 'package:aksestokomobile/util/my_util.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  String nama;
  String code;
  String unit;
  int total;
  int satuanHargaCash;
  int qty;
  int itemCartId;
  String imageUrl;
  int productId;

  Cart({
    this.nama,
    this.satuanHargaCash,
    this.qty,
    this.itemCartId,
    this.imageUrl,
    this.productId,
    this.code,
    this.unit,
    this.total,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] ?? json['nama_produk'];
    satuanHargaCash = json['satuan_harga_cash'] ?? (json['harga_product'] ?? json['harga']);
    code = json['code_product'] ?? json['kode_produk'];
    unit = json['satuan'];
    total = json['total_harga'];
    qty = json['qty'] ?? json['quantity'];
    itemCartId = json['item_cart_id'] ?? json['id_cart']?.toString()?.toInt();
    imageUrl = json['image_url'] ?? json['image_produk'];
    productId = json['product_id']?.toString()?.toInt() ?? json['id_produk']?.toString()?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['satuan_harga_cash'] = this.satuanHargaCash;
    data['qty'] = this.qty;
    data['item_cart_id'] = this.itemCartId;
    data['image_url'] = this.imageUrl;
    data['product_id'] = this.productId;
    data['code_product'] = this.code;
    data['satuan'] = this.unit;
    data['total_harga'] = this.total;
    return data;
  }
}
