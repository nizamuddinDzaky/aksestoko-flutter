import 'package:aksestokomobile/util/my_util.dart';

class Product {
  String nama;
  String satuanHargaCash;
  String satuanHargaCredit;
  String kodeUnit;
  String imageUrl;
  double qty;
  int productId;
  String productCode;
  double productPrice;
  double totalPrice;
  int idCart;
  int countChange;
  int minOrder;
  int isMultiple;

  Product({
    this.nama,
    this.satuanHargaCash,
    this.satuanHargaCredit,
    this.kodeUnit,
    this.imageUrl,
    this.qty,
    this.productId,
    this.productCode,
    this.productPrice,
    this.totalPrice,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productCode = json['code_product'];
    productPrice = json['harga_product']?.toString()?.toDouble();
    totalPrice = json['jumlah_harga']?.toString()?.toDouble();
    nama = json['nama'] ?? json['product_name'] ?? json['nama_product'];
    satuanHargaCash = toStr(json['satuan_harga_cash'] ?? json['product_price']);
    satuanHargaCredit = json['satuan_harga_credit'];
    qty = json['quantity']?.toString()?.toDouble();
    kodeUnit = json['kode_unit'] ?? json['unit_name'] ?? json[''];
    imageUrl = json['image_url'] ?? json['images'] ?? json['image'];
    productId = json['product_id']?.toString()?.toInt();
    minOrder = json['min_order']?.toString()?.toInt();
    isMultiple = json['is_multiple']?.toString()?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['satuan_harga_cash'] = this.satuanHargaCash;
    data['satuan_harga_credit'] = this.satuanHargaCredit;
    data['kode_unit'] = this.kodeUnit;
    data['image_url'] = this.imageUrl;
    data['product_id'] = this.productId;
    return data;
  }

  T cek<T>(dynamic) => dynamic is T ? dynamic : null;

  int toInt(dynamic) => dynamic is int ? dynamic : int.tryParse(dynamic ?? '');

  String toStr(dynamic) => dynamic is String ? dynamic : dynamic?.toString();

  List<T> cekList<T>(dynamic) =>
      dynamic is List<T> ? dynamic.map((e) => e).toList() : null;
}
