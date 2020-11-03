class PaymentData {
  String metodePembayaran;
  String melalui;
  bool showDetailBank;
  bool showPelunasan;
  String durasiPembayaran;
  String rekening;
  String atasNama;
  String logo;
  String harga;
  String diskon;
  String telahDibayar;
  String labelBiaya;
  String textBiaya;
  String biaya;
  String koreksiHarga;
  String total;

  PaymentData(
      {this.metodePembayaran,
        this.melalui,
        this.showDetailBank,
        this.showPelunasan,
        this.durasiPembayaran,
        this.rekening,
        this.atasNama,
        this.logo,
        this.harga,
        this.diskon,
        this.telahDibayar,
        this.labelBiaya,
        this.textBiaya,
        this.biaya,
        this.koreksiHarga,
        this.total});

  PaymentData.fromJson(Map<String, dynamic> json) {
    metodePembayaran = json['metode_pembayaran'];
    melalui = json['melalui'];
    showDetailBank = json['show_detail_bank'];
    showPelunasan = json['show_pelunasan'];
    durasiPembayaran = json['durasi_pembayaran'];
    rekening = json['rekening'];
    atasNama = json['atas_nama'];
    logo = json['logo'];
    harga = json['harga'];
    diskon = json['diskon'];
    telahDibayar = json['telah_dibayar'];
    labelBiaya = json['label_biaya'];
    textBiaya = json['text_biaya'];
    biaya = json['biaya'];
    koreksiHarga = json['koreksi_harga'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metode_pembayaran'] = this.metodePembayaran;
    data['melalui'] = this.melalui;
    data['show_detail_bank'] = this.showDetailBank;
    data['show_pelunasan'] = this.showPelunasan;
    data['durasi_pembayaran'] = this.durasiPembayaran;
    data['rekening'] = this.rekening;
    data['atas_nama'] = this.atasNama;
    data['logo'] = this.logo;
    data['harga'] = this.harga;
    data['diskon'] = this.diskon;
    data['telah_dibayar'] = this.telahDibayar;
    data['label_biaya'] = this.labelBiaya;
    data['text_biaya'] = this.textBiaya;
    data['biaya'] = this.biaya;
    data['koreksi_harga'] = this.koreksiHarga;
    data['total'] = this.total;
    return data;
  }
}