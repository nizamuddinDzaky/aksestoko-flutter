class Order {
  String idPemesanan;
  String pesan;
  int duration;
  String notifikasi;
  int charge;
  String notikasiCharge;
  String company;
  String noPemesanan;
  String tanggalPemensanan;
  String notikasiPemesanan;
  String statusPemesanan;
  String notikasiPembayaran;
  String statusPembayaran;
  String productImage;
  String productName;
  String productCode;
  int unitCost;
  int quantity;
  String satuan;
  int jumlahBarang;
  int hargaBarang;
  int totalHarga;
  String notifikasiProduct;
  bool konfirmasiPenerimaan;

  Order({
    this.idPemesanan,
    this.pesan,
    this.duration,
    this.notifikasi,
    this.charge,
    this.notikasiCharge,
    this.company,
    this.noPemesanan,
    this.tanggalPemensanan,
    this.notikasiPemesanan,
    this.statusPemesanan,
    this.notikasiPembayaran,
    this.statusPembayaran,
    this.productImage,
    this.productName,
    this.productCode,
    this.unitCost,
    this.quantity,
    this.satuan,
    this.jumlahBarang,
    this.hargaBarang,
    this.totalHarga,
    this.notifikasiProduct,
    this.konfirmasiPenerimaan,
  });

  Order.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    pesan = json['pesan'];
    duration = json['duration'];
    notifikasi = json['notifikasi'];
    charge = json['charge'];
    notikasiCharge = json['notikasi_charge'];
    company = json['company'];
    noPemesanan = json['no_pemesanan'];
    tanggalPemensanan = json['tanggal_pemensanan'];
    notikasiPemesanan = json['notikasi_pemesanan'];
    statusPemesanan = json['status_pemesanan'];
    notikasiPembayaran = json['notikasi_pembayaran'];
    statusPembayaran = json['status_pembayaran'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unitCost = json['unit_cost'];
    quantity = json['quantity'];
    satuan = json['satuan'];
    jumlahBarang = json['jumlah_barang'];
    hargaBarang = json['harga_barang'];
    totalHarga = json['total_harga'];
    notifikasiProduct = json['notifikasi_product'];
    konfirmasiPenerimaan = json['konfirmasi_penerimaan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['pesan'] = this.pesan;
    data['duration'] = this.duration;
    data['notifikasi'] = this.notifikasi;
    data['charge'] = this.charge;
    data['notikasi_charge'] = this.notikasiCharge;
    data['company'] = this.company;
    data['no_pemesanan'] = this.noPemesanan;
    data['tanggal_pemensanan'] = this.tanggalPemensanan;
    data['notikasi_pemesanan'] = this.notikasiPemesanan;
    data['status_pemesanan'] = this.statusPemesanan;
    data['notikasi_pembayaran'] = this.notikasiPembayaran;
    data['status_pembayaran'] = this.statusPembayaran;
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['unit_cost'] = this.unitCost;
    data['quantity'] = this.quantity;
    data['satuan'] = this.satuan;
    data['jumlah_barang'] = this.jumlahBarang;
    data['harga_barang'] = this.hargaBarang;
    data['total_harga'] = this.totalHarga;
    data['notifikasi_product'] = this.notifikasiProduct;
    data['konfirmasi_penerimaan'] = this.konfirmasiPenerimaan;
    return data;
  }
}
