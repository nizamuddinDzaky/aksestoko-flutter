class Sales {
  int orderId;
  String orderCode;
  String tanggalPemesanan;
  String statusPembayaran;
  String statusPemesanan;
  int tempo;
  String totalAkhir;
  String shipmentMethod;
  String catatan;

  Sales(
      {this.orderId,
        this.orderCode,
        this.tanggalPemesanan,
        this.statusPembayaran,
        this.statusPemesanan,
        this.tempo,
        this.totalAkhir,
        this.shipmentMethod,
        this.catatan
      });

  Sales.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderCode = json['order_code'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    statusPembayaran = json['status_pembayaran'];
    statusPemesanan = json['status_pemesanan'];
    tempo = json['tempo'];
    totalAkhir = json['total_akhir'];
    shipmentMethod = json['methode_pengiriman'];
    catatan = json['catatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['tanggal_pemesanan'] = this.tanggalPemesanan;
    data['status_pembayaran'] = this.statusPembayaran;
    data['status_pemesanan'] = this.statusPemesanan;
    data['tempo'] = this.tempo;
    data['total_akhir'] = this.totalAkhir;
    data['methode_pengiriman'] = this.shipmentMethod;
    data['catatan'] = this.catatan;
    return data;
  }
}