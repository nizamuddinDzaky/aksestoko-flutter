class OrderSummary {
  int jumlahPesanan;
  int jumlahDiterima;
  int sisaPesanan;
  int totalHarga;
  String labelDiscount;
  int discount;
  Null labelCharge;
  String notifikasiCharge;
  String charge;
  Null labelCorrection;
  String notifikasiCorrection;
  String correction;
  Null labelThirdParty;
  String chargeThirdParty;
  int totalPembayaran;

  OrderSummary(
      {this.jumlahPesanan,
      this.jumlahDiterima,
      this.sisaPesanan,
      this.totalHarga,
      this.labelDiscount,
      this.discount,
      this.labelCharge,
      this.notifikasiCharge,
      this.charge,
      this.labelCorrection,
      this.notifikasiCorrection,
      this.correction,
      this.labelThirdParty,
      this.chargeThirdParty,
      this.totalPembayaran});

  OrderSummary.fromJson(Map<String, dynamic> json) {
    jumlahPesanan = json['jumlah_pesanan'];
    jumlahDiterima = json['jumlah_diterima'];
    sisaPesanan = json['sisa_pesanan'];
    totalHarga = json['total_harga'];
    labelDiscount = json['label_discount'];
    discount = json['discount'];
    labelCharge = json['label_charge'];
    notifikasiCharge = json['notifikasi_charge'];
    charge = json['charge'];
    labelCorrection = json['label_correction'];
    notifikasiCorrection = json['notifikasi_correction'];
    correction = json['correction'];
    labelThirdParty = json['label_third_party'];
    chargeThirdParty = json['charge_third_party'];
    totalPembayaran = json['total_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_pesanan'] = this.jumlahPesanan;
    data['jumlah_diterima'] = this.jumlahDiterima;
    data['sisa_pesanan'] = this.sisaPesanan;
    data['total_harga'] = this.totalHarga;
    data['label_discount'] = this.labelDiscount;
    data['discount'] = this.discount;
    data['label_charge'] = this.labelCharge;
    data['notifikasi_charge'] = this.notifikasiCharge;
    data['charge'] = this.charge;
    data['label_correction'] = this.labelCorrection;
    data['notifikasi_correction'] = this.notifikasiCorrection;
    data['correction'] = this.correction;
    data['label_third_party'] = this.labelThirdParty;
    data['charge_third_party'] = this.chargeThirdParty;
    data['total_pembayaran'] = this.totalPembayaran;
    return data;
  }
}
