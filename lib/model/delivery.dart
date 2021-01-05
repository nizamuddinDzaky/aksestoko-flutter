class Delivery {
  String idToko;
  String namaToko;
  String nama;
  String noTlp;
  String alamat;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String kodePos;
  int jumlahDeliveries;
  List<DetailDelivery> listDetailDelivery;

  Delivery(
      {this.idToko,
      this.namaToko,
      this.nama,
      this.noTlp,
      this.alamat,
      this.kecamatan,
      this.kabupaten,
      this.provinsi,
      this.kodePos,
      this.jumlahDeliveries,
      this.listDetailDelivery
      });

  Delivery.fromJson(Map<String, dynamic> json) {
    idToko = json['id_toko'];
    namaToko = json['nama_toko'];
    nama = json['nama'];
    noTlp = json['no_tlp'];
    alamat = json['alamat'];
    kecamatan = json['kecamatan'];
    kabupaten = json['kabupaten'];
    provinsi = json['provinsi'];
    kodePos = json['kode_pos'];
    jumlahDeliveries = json['jumlah_deliveries'];
    if (json['list_deliveries'] != null) {
      listDetailDelivery = new List<DetailDelivery>();
      json['list_deliveries'].forEach((v) {
        listDetailDelivery.add(new DetailDelivery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_toko'] = this.idToko;
    data['nama_toko'] = this.namaToko;
    data['nama'] = this.nama;
    data['no_tlp'] = this.noTlp;
    data['alamat'] = this.alamat;
    data['kecamatan'] = this.kecamatan;
    data['kabupaten'] = this.kabupaten;
    data['provinsi'] = this.provinsi;
    data['kode_pos'] = this.kodePos;
    data['jumlah_deliveries'] = this.jumlahDeliveries;
    if (this.listDetailDelivery != null) {
      data['list_deliveries'] =
          this.listDetailDelivery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailDelivery {
  String idDelivery;
  String noSpj;
  String labelStatus;
  String statuPengiriman;
  String tanggalDikirim;
  String dikirimOleh;
  bool konfirmasiPenerimaan;
  bool konfirmasiBadQty;
  String urlSpj;
  int jumlahDetailDelivery;
  List<ItemDetailDelivery> listItemDetailDelivery;

  DetailDelivery(
      {this.idDelivery,
        this.noSpj,
        this.labelStatus,
        this.statuPengiriman,
        this.tanggalDikirim,
        this.dikirimOleh,
        this.konfirmasiPenerimaan,
        this.konfirmasiBadQty,
        this.urlSpj,
        this.jumlahDetailDelivery,
        this.listItemDetailDelivery
      });

  DetailDelivery.fromJson(Map<String, dynamic> json) {
    idDelivery = json['id_delivery'];
    noSpj = json['no_spj'];
    labelStatus = json['label_status'];
    statuPengiriman = json['statu_pengiriman'];
    tanggalDikirim = json['tanggal_dikirim'];
    dikirimOleh = json['dikirim_oleh'];
    konfirmasiPenerimaan = json['konfirmasi_penerimaan'];
    konfirmasiBadQty = json['konfirmasi_bad_qty'];
    urlSpj = json['url_spj'];
    jumlahDetailDelivery = json['jumlah_detail_delivery'];
    if (json['list_detail_delivery'] != null) {
      listItemDetailDelivery = new List<ItemDetailDelivery>();
      json['list_detail_delivery'].forEach((v) {
        listItemDetailDelivery.add(new ItemDetailDelivery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_delivery'] = this.idDelivery;
    data['no_spj'] = this.noSpj;
    data['label_status'] = this.labelStatus;
    data['statu_pengiriman'] = this.statuPengiriman;
    data['tanggal_dikirim'] = this.tanggalDikirim;
    data['dikirim_oleh'] = this.dikirimOleh;
    data['konfirmasi_penerimaan'] = this.konfirmasiPenerimaan;
    data['konfirmasi_bad_qty'] = this.konfirmasiBadQty;
    data['url_spj'] = this.urlSpj;
    data['jumlah_detail_delivery'] = this.jumlahDetailDelivery;
    if (this.listItemDetailDelivery != null) {
      data['list_detail_delivery'] =
          this.listItemDetailDelivery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetailDelivery {
  String idProduct;
  String deliveryItemId;
  String namaProduct;
  String kodeProduct;
  int jumlah;
  String satuan;
  int baik;
  int buruk;
  String imageBarang;

  ItemDetailDelivery(
      {this.idProduct,
      this.deliveryItemId,
      this.namaProduct,
      this.kodeProduct,
      this.jumlah,
      this.satuan,
      this.baik,
      this.buruk});

  ItemDetailDelivery.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    deliveryItemId = json['delivery_item_id'];
    namaProduct = json['nama_product'];
    kodeProduct = json['kode_product'];
    jumlah = json['jumlah'];
    satuan = json['satuan'];
    baik = json['baik'];
    buruk = json['buruk'];
    imageBarang = json['image_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['delivery_item_id'] = this.deliveryItemId;
    data['nama_product'] = this.namaProduct;
    data['kode_product'] = this.kodeProduct;
    data['jumlah'] = this.jumlah;
    data['satuan'] = this.satuan;
    data['baik'] = this.baik;
    data['buruk'] = this.buruk;
    return data;
  }
}
