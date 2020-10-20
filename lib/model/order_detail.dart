import 'package:aksestokomobile/model/cart_model.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/model/order_summary.dart';

class OrderDetail {
  DetailPemesanan detailPemesanan;
  List<String> pembayaranKreditPro;
  Penerimaan penerimaan;
  Delivery pengiriman;
  OrderSummary ringkasan;
  CartModel daftarBelanja;
  Null pesan;
  Null info1;
  Null info2;
  Null info3;
  Null info4;
  Null konfirmasiHargaPesanan;

  OrderDetail(
      {this.detailPemesanan,
      this.pembayaranKreditPro,
      this.penerimaan,
      this.pengiriman,
      this.ringkasan,
      this.daftarBelanja,
      this.pesan,
      this.info1,
      this.info2,
      this.info3,
      this.info4,
      this.konfirmasiHargaPesanan});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    detailPemesanan = json['detail_pemesanan'] != null
        ? new DetailPemesanan.fromJson(json['detail_pemesanan'])
        : null;
    if (json['pembayaran_kredit_pro'] != null) {
      pembayaranKreditPro = new List<Null>();
      json['pembayaran_kredit_pro'].forEach((v) {
        pembayaranKreditPro.add(v);
      });
    }
    penerimaan = json['penerimaan'] != null
        ? new Penerimaan.fromJson(json['penerimaan'])
        : null;
    pengiriman = json['pengiriman'] != null
        ? new Delivery.fromJson(json['pengiriman'])
        : null;
    ringkasan = json['ringkasan'] != null
        ? new OrderSummary.fromJson(json['ringkasan'])
        : null;
    daftarBelanja = json['daftar_belanja'] != null
        ? new CartModel.fromJson(json['daftar_belanja'])
        : null;
    pesan = json['pesan'];
    info1 = json['info_1'];
    info2 = json['info_2'];
    info3 = json['info_3'];
    info4 = json['info_4'];
    konfirmasiHargaPesanan = json['konfirmasi_harga_pesanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailPemesanan != null) {
      data['detail_pemesanan'] = this.detailPemesanan.toJson();
    }
    if (this.pembayaranKreditPro != null) {
      data['pembayaran_kredit_pro'] = this.pembayaranKreditPro;
    }
    if (this.penerimaan != null) {
      data['penerimaan'] = this.penerimaan.toJson();
    }
    if (this.pengiriman != null) {
      data['pengiriman'] = this.pengiriman.toJson();
    }
    if (this.ringkasan != null) {
      data['ringkasan'] = this.ringkasan.toJson();
    }
    if (this.daftarBelanja != null) {
      data['daftar_belanja'] = this.daftarBelanja.toJson();
    }
    data['pesan'] = this.pesan;
    data['info_1'] = this.info1;
    data['info_2'] = this.info2;
    data['info_3'] = this.info3;
    data['info_4'] = this.info4;
    data['konfirmasi_harga_pesanan'] = this.konfirmasiHargaPesanan;
    return data;
  }
}

class DetailPemesanan {
  String idPemesanan;
  String noPemesanan;
  String idBk;
  String tanggalPeesanan;
  String ekpestasi;
  String kodeDistributor;
  String namaDistributor;
  String caraPengiriman;
  String caraPembayaran;
  Null jenisPembayaran;
  String notifikasiPemesanan;
  String statusPemesanan;
  String notifikasiPembayaran;
  String statusPembayaran;
  Null urlInvoice;
  Null konfirmasiPembayaran;
  Null daftarPembayaran;

  DetailPemesanan(
      {this.idPemesanan,
      this.noPemesanan,
      this.idBk,
      this.tanggalPeesanan,
      this.ekpestasi,
      this.kodeDistributor,
      this.namaDistributor,
      this.caraPengiriman,
      this.caraPembayaran,
      this.jenisPembayaran,
      this.notifikasiPemesanan,
      this.statusPemesanan,
      this.notifikasiPembayaran,
      this.statusPembayaran,
      this.urlInvoice,
      this.konfirmasiPembayaran,
      this.daftarPembayaran});

  DetailPemesanan.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    noPemesanan = json['no_pemesanan'];
    idBk = json['id_bk'];
    tanggalPeesanan = json['tanggal_peesanan'];
    ekpestasi = json['ekpestasi'];
    kodeDistributor = json['kode_distributor'];
    namaDistributor = json['nama_distributor'];
    caraPengiriman = json['cara_pengiriman'];
    caraPembayaran = json['cara_pembayaran'];
    jenisPembayaran = json['jenis_pembayaran'];
    notifikasiPemesanan = json['notifikasi_pemesanan'];
    statusPemesanan = json['status_pemesanan'];
    notifikasiPembayaran = json['notifikasi_pembayaran'];
    statusPembayaran = json['status_pembayaran'];
    urlInvoice = json['url_invoice'];
    konfirmasiPembayaran = json['konfirmasi_pembayaran'];
    daftarPembayaran = json['daftar_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['no_pemesanan'] = this.noPemesanan;
    data['id_bk'] = this.idBk;
    data['tanggal_peesanan'] = this.tanggalPeesanan;
    data['ekpestasi'] = this.ekpestasi;
    data['kode_distributor'] = this.kodeDistributor;
    data['nama_distributor'] = this.namaDistributor;
    data['cara_pengiriman'] = this.caraPengiriman;
    data['cara_pembayaran'] = this.caraPembayaran;
    data['jenis_pembayaran'] = this.jenisPembayaran;
    data['notifikasi_pemesanan'] = this.notifikasiPemesanan;
    data['status_pemesanan'] = this.statusPemesanan;
    data['notifikasi_pembayaran'] = this.notifikasiPembayaran;
    data['status_pembayaran'] = this.statusPembayaran;
    data['url_invoice'] = this.urlInvoice;
    data['konfirmasi_pembayaran'] = this.konfirmasiPembayaran;
    data['daftar_pembayaran'] = this.daftarPembayaran;
    return data;
  }
}

class Penerimaan {
  String idBarang;
  String namaBarang;
  String kodeBarang;
  int jumlahPesanan;
  int jumlahDiterima;
  DetailDiterima detailDiterima;
  int sisaPesanan;
  String satuan;

  Penerimaan(
      {this.idBarang,
      this.namaBarang,
      this.kodeBarang,
      this.jumlahPesanan,
      this.jumlahDiterima,
      this.detailDiterima,
      this.sisaPesanan,
      this.satuan});

  Penerimaan.fromJson(Map<String, dynamic> json) {
    idBarang = json['id_barang'];
    namaBarang = json['nama_barang'];
    kodeBarang = json['kode_barang'];
    jumlahPesanan = json['jumlah_pesanan'];
    jumlahDiterima = json['jumlah_diterima'];
    detailDiterima = json['detail_diterima'] != null
        ? new DetailDiterima.fromJson(json['detail_diterima'])
        : null;
    sisaPesanan = json['sisa_pesanan'];
    satuan = json['satuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_barang'] = this.idBarang;
    data['nama_barang'] = this.namaBarang;
    data['kode_barang'] = this.kodeBarang;
    data['jumlah_pesanan'] = this.jumlahPesanan;
    data['jumlah_diterima'] = this.jumlahDiterima;
    if (this.detailDiterima != null) {
      data['detail_diterima'] = this.detailDiterima.toJson();
    }
    data['sisa_pesanan'] = this.sisaPesanan;
    data['satuan'] = this.satuan;
    return data;
  }
}

class DetailDiterima {
  int barangBaik;
  int barangRusak;

  DetailDiterima({this.barangBaik, this.barangRusak});

  DetailDiterima.fromJson(Map<String, dynamic> json) {
    barangBaik = json['barang_baik'];
    barangRusak = json['barang_rusak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barang_baik'] = this.barangBaik;
    data['barang_rusak'] = this.barangRusak;
    return data;
  }
}
