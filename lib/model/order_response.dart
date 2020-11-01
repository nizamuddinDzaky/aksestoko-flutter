class OrderResponse {
  int saleId;
  int purchaseId;
  String idPemesanan;
  String caraPembayaran;
  String bank;
  String noRekening;

  OrderResponse(
      {this.saleId,
      this.purchaseId,
      this.idPemesanan,
      this.caraPembayaran,
      this.bank,
      this.noRekening});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    purchaseId = json['purchase_id'];
    idPemesanan = json['id_pemesanan'];
    caraPembayaran = json['cara_pembayaran'];
    bank = json['bank'];
    noRekening = json['no_rekening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['purchase_id'] = this.purchaseId;
    data['id_pemesanan'] = this.idPemesanan;
    data['cara_pembayaran'] = this.caraPembayaran;
    data['bank'] = this.bank;
    data['no_rekening'] = this.noRekening;
    return data;
  }
}
