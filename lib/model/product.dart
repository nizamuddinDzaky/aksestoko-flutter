class Product {
  String nama;
  String satuanHargaCash;
  String satuanHargaCredit;
  String kodeUnit;
  String imageUrl;
  double qty;
  int productId;

  Product(
      {this.nama,
        this.satuanHargaCash,
        this.satuanHargaCredit,
        this.kodeUnit,
        this.imageUrl,
        this.qty,
        this.productId});

  Product.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    satuanHargaCash = json['satuan_harga_cash'];
    satuanHargaCredit = json['satuan_harga_credit'];
    kodeUnit = json['kode_unit'];
    imageUrl = json['image_url'];
    productId = json['product_id'];
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
}