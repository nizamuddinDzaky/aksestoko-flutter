class Notif {
  String title;
  String body;
  int idSales;
  int idPromo;
  String image;

  Notif({this.title, this.body, this.idSales, this.idPromo, this.image});

  Notif.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    idSales = json['id_sales'];
    idPromo = json['id_promo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['id_sales'] = this.idSales;
    data['id_promo'] = this.idPromo;
    data['image'] = this.image;
    return data;
  }
}
