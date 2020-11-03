class Zone {
  String kode;
  String name;
  int id;

  Zone({this.kode, this.name, this.id});

  Zone.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  String getName() {
    return this.name;
  }
}

class Zona {
  int id;
  String provinceCode;
  String kabupatenCode;
  String kecamatanCode;
  String lat;
  String lng;
  String provinceName;
  String kabupatenName;
  String kecamatanName;
  String idWilayah;

  Zona(
      {this.provinceCode,
      this.kabupatenCode,
      this.kecamatanCode,
      this.lat,
      this.lng,
      this.provinceName,
      this.kabupatenName,
      this.kecamatanName,
      this.idWilayah});

  Zona.fromJson(Map<String, dynamic> json) {
    provinceCode = json['province_code'];
    kabupatenCode = json['kabupaten_code'];
    kecamatanCode = json['kecamatan_code'];
    lat = json['lat'];
    lng = json['lng'];
    provinceName = json['province_name'];
    kabupatenName = json['kabupaten_name'];
    kecamatanName = json['kecamatan_name'];
    idWilayah = json['id_wilayah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_code'] = this.provinceCode;
    data['kabupaten_code'] = this.kabupatenCode;
    data['kecamatan_code'] = this.kecamatanCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['province_name'] = this.provinceName;
    data['kabupaten_name'] = this.kabupatenName;
    data['kecamatan_name'] = this.kecamatanName;
    data['id_wilayah'] = this.idWilayah;
    return data;
  }
}
