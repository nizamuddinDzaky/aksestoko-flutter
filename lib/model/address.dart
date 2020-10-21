import 'package:aksestokomobile/util/my_util.dart';

class Address {
  String namaPenerima;
  String email;
  String noTlpn;
  String alamat;
  String provinceName;
  int provinceId;
  String kabupatenName;
  int kabupatenId;
  String kecamatanName;
  int kecamatanId;
  String kelurahanName;
  int kelurahanId;
  int addressId;
  int kodePos;

  Address(
      {this.namaPenerima,
        this.email,
        this.noTlpn,
        this.alamat,
        this.provinceName,
        this.provinceId,
        this.kabupatenName,
        this.kabupatenId,
        this.kecamatanName,
        this.kecamatanId,
        this.kelurahanName,
        this.kelurahanId,
        this.addressId,
        this.kodePos});

  Address.fromJson(Map<String, dynamic> json) {
    namaPenerima = json['nama_penerima'];
    email = json['email'];
    noTlpn = json['no_tlpn'];
    alamat = json['alamat'];
    provinceName = json['province_name'];
    provinceId = json['province_id'];
    kabupatenName = json['kabupaten_name'];
    kabupatenId = json['kabupaten_id'];
    kecamatanName = json['kecamatan_name'];
    kecamatanId = json['kecamatan_id'];
    kelurahanName = json['kelurahan'];
    kelurahanId = json['kelurahan_id'];
    addressId = json['address_id']?.toString()?.toInt();
    kodePos = json['kode_pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_penerima'] = this.namaPenerima;
    data['email'] = this.email;
    data['no_tlpn'] = this.noTlpn;
    data['alamat'] = this.alamat;
    data['province_name'] = this.provinceName;
    data['province_id'] = this.provinceId;
    data['kabupaten_name'] = this.kabupatenName;
    data['kabupaten_id'] = this.kabupatenId;
    data['kecamatan_name'] = this.kecamatanName;
    data['kecamatan_id'] = this.kecamatanId;
    data['kelurahan'] = this.kelurahanName;
    data['kelurahan_id'] = this.kelurahanId;
    data['address_id'] = this.addressId;
    data['kode_pos'] = this.kodePos;
    return data;
  }
}