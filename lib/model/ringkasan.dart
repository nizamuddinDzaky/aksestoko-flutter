class Ringkasan {
  int jumlahBarang;
  int totalHarga;

  double calculateTotal({costDelivery = 0.0}) {
    return (totalHarga ?? 0).toDouble() - (costDelivery ?? 0.0);
  }

  Ringkasan({this.jumlahBarang, this.totalHarga});

  Ringkasan.fromJson(Map<String, dynamic> json) {
    jumlahBarang = json['jumlah_barang'];
    totalHarga = json['total_harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_barang'] = this.jumlahBarang;
    data['total_harga'] = this.totalHarga;
    return data;
  }
}
