class Alamat {
  String addressId;
  String addressCompany;
  String addressName;
  String addressPhone;
  String address;
  String addressState;
  String addressCity;
  String addressCountry;
  String addressPostalCode;
  bool canBeRemove;

  Alamat({
    this.addressId,
    this.addressCompany,
    this.addressName,
    this.addressPhone,
    this.address,
    this.addressState,
    this.addressCity,
    this.addressCountry,
    this.addressPostalCode,
  });

  Alamat.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressCompany = json['address_company'];
    addressName = json['address_name'];
    addressPhone = json['address_phone'];
    address = json['address'];
    addressState = json['address_state'];
    addressCity = json['address_city'];
    addressCountry = json['address_country'];
    addressPostalCode = json['address_postal_code'];
    canBeRemove = json['can_be_removed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_company'] = this.addressCompany;
    data['address_name'] = this.addressName;
    data['address_phone'] = this.addressPhone;
    data['address'] = this.address;
    data['address_state'] = this.addressState;
    data['address_city'] = this.addressCity;
    data['address_country'] = this.addressCountry;
    data['address_postal_code'] = this.addressPostalCode;
    return data;
  }
}
