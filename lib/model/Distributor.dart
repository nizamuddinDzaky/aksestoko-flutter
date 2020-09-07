class Distributor {
  String nama;
  String namaPrincipal;
  String alamatLengkap;
  String noTlpn;
  String imageUrl;
  int id;

  Distributor(
      {this.nama,
        this.namaPrincipal,
        this.alamatLengkap,
        this.noTlpn,
        this.imageUrl,
        this.id
      });

  Distributor.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    namaPrincipal = json['nama_principal'];
    alamatLengkap = json['alamat_lengkap'];
    noTlpn = json['no_tlpn'];
    imageUrl = json['image_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['nama_principal'] = this.namaPrincipal;
    data['alamat_lengkap'] = this.alamatLengkap;
    data['no_tlpn'] = this.noTlpn;
    data['image_url'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}