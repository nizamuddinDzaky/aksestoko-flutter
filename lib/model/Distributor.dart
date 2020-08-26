class Distributor {
  String nama;
  String namaPrincipal;
  String alamatLengkap;
  String noTlpn;
  String imageUrl;

  Distributor(
      {this.nama,
        this.namaPrincipal,
        this.alamatLengkap,
        this.noTlpn,
        this.imageUrl});

  Distributor.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    namaPrincipal = json['nama_principal'];
    alamatLengkap = json['alamat_lengkap'];
    noTlpn = json['no_tlpn'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['nama_principal'] = this.namaPrincipal;
    data['alamat_lengkap'] = this.alamatLengkap;
    data['no_tlpn'] = this.noTlpn;
    data['image_url'] = this.imageUrl;
    return data;
  }
}