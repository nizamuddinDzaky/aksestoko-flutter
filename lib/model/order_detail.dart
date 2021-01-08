import 'package:aksestokomobile/model/cart_model.dart';
import 'package:aksestokomobile/model/delivery.dart';
import 'package:aksestokomobile/model/order_summary.dart';

class OrderDetail {
  DetailPemesanan detailPemesanan;
  OrderSummary ringkasan;
  Delivery pengiriman;
  CartModel daftarBelanja;
  String pesan;
  String info1;
  String info2;
  String info3;
  String info4;
  bool konfirmasiHargaPesanan;
  PembayaranKreditPro pembayaranKreditPro;

  /*Penerimaan penerimaan;
  Delivery pengiriman;

  ;

  */

  OrderDetail(
      {this.detailPemesanan,
      this.ringkasan,
      this.pengiriman,
      this.daftarBelanja,
      this.pesan,
      this.info1,
      this.info2,
      this.info3,
      this.info4,
      this.konfirmasiHargaPesanan
      /*this.pembayaranKreditPro,
      this.penerimaan,

      ,

      ,
      */});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    detailPemesanan = json['detail_pemesanan'] != null
        ? new DetailPemesanan.fromJson(json['detail_pemesanan'])
        : null;

    ringkasan = json['ringkasan'] != null
        ? new OrderSummary.fromJson(json['ringkasan'])
        : null;

    pengiriman = json['pengiriman'] != null
        ? new Delivery.fromJson(json['pengiriman'])
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
    if (json['pembayaran_kredit_pro'] is Map<String, dynamic>) {
      pembayaranKreditPro =
          PembayaranKreditPro.fromJson(json['pembayaran_kredit_pro']);
    }
    /*penerimaan = json['penerimaan'] != null
        ? new Penerimaan.fromJson(json['penerimaan'])
        : null;




    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailPemesanan != null) {
      data['detail_pemesanan'] = this.detailPemesanan.toJson();
    }

    if (this.ringkasan != null) {
      data['ringkasan'] = this.ringkasan.toJson();
    }

    if (this.pengiriman != null) {
      data['pengiriman'] = this.pengiriman.toJson();
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
    /*if (this.pembayaranKreditPro != null) {
      data['pembayaran_kredit_pro'] = this.pembayaranKreditPro;
    }
    if (this.penerimaan != null) {
      data['penerimaan'] = this.penerimaan.toJson();
    }




    */
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
  String jenisPembayaran;
  String notifikasiPemesanan;
  String statusPemesanan;
  String notifikasiPembayaran;
  String statusPembayaran;
  String urlInvoice;
  bool konfirmasiPembayaran;
  bool daftarPembayaran;
  bool ajukanKredit;
  bool pilihMetodePembayaran;
  String tanggalJatuhTempo;

  String get statusPembayaranStr =>
      statusPembayaran?.trim()?.toLowerCase() == 'telah dibayar'
          ? 'Lunas'
          : statusPembayaran;

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
        this.daftarPembayaran,
        this.ajukanKredit,
        this.pilihMetodePembayaran,
        this.tanggalJatuhTempo
      });

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
    ajukanKredit = json['ajukan_kredit'];
    pilihMetodePembayaran = json['pilih_metode_pembayaran'];
    tanggalJatuhTempo = json['tanggal_jatuh_tempo'];
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
    data['ajukan_kredit'] = this.ajukanKredit;
    data['pilih_metode_pembayaran'] = this.pilihMetodePembayaran;
    data['tanggal_jatuh_tempo'] = this.tanggalJatuhTempo;
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

class PembayaranKreditPro {
  String image;
  String progress;
  String proses;
  String perbandingan;
  int start;
  int end;

  double get percent {
    if ((end ?? 0) <= 0) return 0;
    // start = 200000;
    return (start ?? 0) / end;
  }

  String format(double n) {
    return '${n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1)}%';
  }

  String get status {
    if (proses?.isNotEmpty ?? false) return proses;
    //return progress ?? '';
    return format(percent * 100) ?? '';
  }

  int get unPaid => end - start;

  PembayaranKreditPro(
      {this.image, this.progress, this.proses, this.perbandingan});

  PembayaranKreditPro.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    progress = json['progress'];
    proses = json['proses'];
    perbandingan = json['perbandingan'];
    if (perbandingan != null) {
      var vals = perbandingan.split('/');
      if (vals?.length == 2) {
        try {
          start = int.tryParse(vals[0]);
          end = int.tryParse(vals[1]);
        } catch (e) {}
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['progress'] = this.progress;
    data['proses'] = this.proses;
    data['perbandingan'] = this.perbandingan;
    return data;
  }
}
