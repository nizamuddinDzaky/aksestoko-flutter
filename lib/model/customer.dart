class Customer {
  String storeName;
  String email;
  String handphone;
  String firstname;
  String lastname;

  Customer({
    this.storeName,
    this.email,
    this.handphone,
    this.firstname,
    this.lastname,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    email = json['email'];
    handphone = json['handphone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['handphone'] = this.handphone;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
