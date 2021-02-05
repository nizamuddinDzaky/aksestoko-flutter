class Profile {
  String userId;
  String namaDepan;
  String namaBelakang;
  String email;
  String kodeBk;
  String namaToko;
  String noTlp;
  String phoneIsVerified;
  String imgKtp;

  bool get isVerified => phoneIsVerified?.toLowerCase() == 'terverifikasi';

  Profile(
      {this.userId,
      this.namaDepan,
      this.namaBelakang,
      this.email,
      this.kodeBk,
      this.namaToko,
      this.noTlp,
      this.phoneIsVerified,
      this.imgKtp});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    namaDepan = json['nama_depan'];
    namaBelakang = json['nama_belakang'];
    email = json['email'];
    kodeBk = json['kode_bk'];
    namaToko = json['nama_toko'];
    noTlp = json['no_tlp'];
    phoneIsVerified = json['phone_is_verified'];
    imgKtp = json['img_ktp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['nama_depan'] = this.namaDepan;
    data['nama_belakang'] = this.namaBelakang;
    data['email'] = this.email;
    data['kode_bk'] = this.kodeBk;
    data['nama_toko'] = this.namaToko;
    data['no_tlp'] = this.noTlp;
    data['phone_is_verified'] = this.phoneIsVerified;
    data['img_ktp'] = this.imgKtp;
    return data;
  }
}
