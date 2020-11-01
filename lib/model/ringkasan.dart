class Ringkasan {
  int jumlahBarang;
  String operasi;
  String label;
  int cost;
  int totalHarga;
  int totalAkhir;

  int get grandTotal => totalAkhir ?? totalHarga;

  double calculateTotal({costDelivery = 0.0}) {
    return (totalHarga ?? 0).toDouble() - (costDelivery ?? 0.0);
  }

  Ringkasan(
      {this.jumlahBarang,
      this.operasi,
      this.label,
      this.cost,
      this.totalHarga,
      this.totalAkhir});

  Ringkasan.fromJson(Map<String, dynamic> json) {
    jumlahBarang = json['jumlah_barang'];
    operasi = json['operasi'];
    label = json['label'];
    cost = int.tryParse(json['cost']?.toString() ?? "");
    totalHarga = json['total_harga'];
    totalAkhir = json['total_akhir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_barang'] = this.jumlahBarang;
    data['operasi'] = this.operasi;
    data['label'] = this.label;
    data['cost'] = this.cost;
    data['total_harga'] = this.totalHarga;
    data['total_akhir'] = this.totalAkhir;
    return data;
  }
}
