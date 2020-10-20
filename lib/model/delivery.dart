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
  Null listDeliveries;

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
      this.listDeliveries});

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
    listDeliveries = json['list_deliveries'];
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
    data['list_deliveries'] = this.listDeliveries;
    return data;
  }
}
