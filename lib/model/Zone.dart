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

  String getName(){
    return this.name;
  }
}