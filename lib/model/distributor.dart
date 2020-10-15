import 'package:aksestokomobile/util/my_util.dart';

class Distributor {
  String nama;
  String kode;
  String namaPrincipal;
  String alamatLengkap;
  String noTlpn;
  String imageUrl;
  int id;
  int customerGroupId;
  int priceGroupId;

  Distributor({
    this.nama,
    this.kode,
    this.namaPrincipal,
    this.alamatLengkap,
    this.noTlpn,
    this.imageUrl,
    this.id,
    this.customerGroupId,
    this.priceGroupId,
  });

  Distributor.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] ?? json['name'];
    kode = json['kode'];
    namaPrincipal = json['nama_principal'] ?? json['company_name'];
    alamatLengkap = json['alamat_lengkap'] ?? json['address'];
    noTlpn = json['no_tlpn'] ?? json['phone'];
    imageUrl = json['image_url'] ?? json['logo'];
    id = json['id'] ?? json['company_id']?.toString()?.toInt();
    customerGroupId = json['customer_group_id']?.toString()?.toInt();
    priceGroupId = json['price_group_id']?.toString()?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['kode'] = this.kode;
    data['nama_principal'] = this.namaPrincipal;
    data['alamat_lengkap'] = this.alamatLengkap;
    data['no_tlpn'] = this.noTlpn;
    data['image_url'] = this.imageUrl;
    data['id'] = this.id;
    data['customer_group_id'] = this.customerGroupId;
    data['price_group_id'] = this.priceGroupId;
    return data;
  }
}
