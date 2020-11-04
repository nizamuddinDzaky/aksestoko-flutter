class SalesPerson {
  String salesPersonId;
  String name;
  String refenceNo;
  String email;
  String noTlp;
  String alamat;
  String kecamatan;
  String kabupaten;
  String provincy;
  String company;

  SalesPerson(
      {this.salesPersonId,
      this.name,
      this.refenceNo,
      this.email,
      this.noTlp,
      this.alamat,
      this.kecamatan,
      this.kabupaten,
      this.provincy});

  SalesPerson.fromJson(Map<String, dynamic> json) {
    salesPersonId = json['sales_person_id'];
    name = json['name'];
    company = json['company'];
    refenceNo = json['refence_no'] ?? json['reference_no'];
    email = json['email'];
    noTlp = json['no_tlp'] ?? json['phone'];
    alamat = json['alamat'] ?? json['address'];
    kecamatan = json['kecamatan'] ?? json['state'];
    kabupaten = json['kabupaten'] ?? json['city'];
    provincy = json['provincy'] ?? json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_person_id'] = this.salesPersonId;
    data['name'] = this.name;
    data['refence_no'] = this.refenceNo;
    data['email'] = this.email;
    data['no_tlp'] = this.noTlp;
    data['alamat'] = this.alamat;
    data['kecamatan'] = this.kecamatan;
    data['kabupaten'] = this.kabupaten;
    data['provincy'] = this.provincy;
    return data;
  }
}
