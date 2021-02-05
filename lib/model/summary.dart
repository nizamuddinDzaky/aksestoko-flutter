class Summary {
  String tanggal;
  String bisniskokohidToko;
  String namaToko;
  String bisniskokohidDistributor;
  String namaDistributor;
  String idRegional;
  String namaRegional;
  String idProvinsi;
  String namaProvinsi;
  String idArea;
  String namaArea;
  String idKabupatenkota;
  String namaKabupatenkota;
  String nomorTransaksi;
  String kodeGudang;
  String namaGudang;
  String kodeProduk;
  String namaProduk;
  String satuan;
  String kuantitas;

  Summary(
      {this.tanggal,
      this.bisniskokohidToko,
      this.namaToko,
      this.bisniskokohidDistributor,
      this.namaDistributor,
      this.idRegional,
      this.namaRegional,
      this.idProvinsi,
      this.namaProvinsi,
      this.idArea,
      this.namaArea,
      this.idKabupatenkota,
      this.namaKabupatenkota,
      this.nomorTransaksi,
      this.kodeGudang,
      this.namaGudang,
      this.kodeProduk,
      this.namaProduk,
      this.satuan,
      this.kuantitas});

  Summary.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    bisniskokohidToko = json['bisniskokohid_toko'];
    namaToko = json['nama_toko'];
    bisniskokohidDistributor = json['bisniskokohid_distributor'];
    namaDistributor = json['nama_distributor'];
    idRegional = json['id_regional'];
    namaRegional = json['nama_regional'];
    idProvinsi = json['id_provinsi'];
    namaProvinsi = json['nama_provinsi'];
    idArea = json['id_area'];
    namaArea = json['nama_area'];
    idKabupatenkota = json['id_kabupatenkota'];
    namaKabupatenkota = json['nama_kabupatenkota'];
    nomorTransaksi = json['nomor_transaksi'];
    kodeGudang = json['kode_gudang'];
    namaGudang = json['nama_gudang'];
    kodeProduk = json['kode_produk'];
    namaProduk = json['nama_produk'];
    satuan = json['satuan'];
    kuantitas = json['kuantitas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['bisniskokohid_toko'] = this.bisniskokohidToko;
    data['nama_toko'] = this.namaToko;
    data['bisniskokohid_distributor'] = this.bisniskokohidDistributor;
    data['nama_distributor'] = this.namaDistributor;
    data['id_regional'] = this.idRegional;
    data['nama_regional'] = this.namaRegional;
    data['id_provinsi'] = this.idProvinsi;
    data['nama_provinsi'] = this.namaProvinsi;
    data['id_area'] = this.idArea;
    data['nama_area'] = this.namaArea;
    data['id_kabupatenkota'] = this.idKabupatenkota;
    data['nama_kabupatenkota'] = this.namaKabupatenkota;
    data['nomor_transaksi'] = this.nomorTransaksi;
    data['kode_gudang'] = this.kodeGudang;
    data['nama_gudang'] = this.namaGudang;
    data['kode_produk'] = this.kodeProduk;
    data['nama_produk'] = this.namaProduk;
    data['satuan'] = this.satuan;
    data['kuantitas'] = this.kuantitas;
    return data;
  }
}
