class Cart {
  String nama;
  String satuanHargaCash;
  int qty;
  int itemCartId;
  String imageUrl;
  int productId;

  Cart(
      {this.nama,
        this.satuanHargaCash,
        this.qty,
        this.itemCartId,
        this.imageUrl,
        this.productId});

  Cart.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    satuanHargaCash = json['satuan_harga_cash'];
    qty = json['qty'];
    itemCartId = json['item_cart_id'];
    imageUrl = json['image_url'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['satuan_harga_cash'] = this.satuanHargaCash;
    data['qty'] = this.qty;
    data['item_cart_id'] = this.itemCartId;
    data['image_url'] = this.imageUrl;
    data['product_id'] = this.productId;
    return data;
  }
}