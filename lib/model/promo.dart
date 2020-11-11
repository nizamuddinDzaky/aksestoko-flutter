class Promo {
  String id;
  String date;
  String supplierId;
  String supplier;
  String name;
  String typeNews;
  String description;
  String linkPromo;
  String codePromo;
  String startDate;
  String endDate;
  String urlImage;
  String syarat;
  String createdBy;
  String linkOutsite;
  String urlOutsite;
  String totalItems;
  String quota;
  String region;
  String tipe;
  String maxToko;
  String isDeleted;
  String status;
  String value;
  String maxTotalDisc;
  String minPembelian;
  String isPopup;
  String imagePopup;
  String videoPopup;

  Promo(
      {this.id,
      this.date,
      this.supplierId,
      this.supplier,
      this.name,
      this.typeNews,
      this.description,
      this.linkPromo,
      this.codePromo,
      this.startDate,
      this.endDate,
      this.urlImage,
      this.syarat,
      this.createdBy,
      this.linkOutsite,
      this.urlOutsite,
      this.totalItems,
      this.quota,
      this.region,
      this.tipe,
      this.maxToko,
      this.isDeleted,
      this.status,
      this.value,
      this.maxTotalDisc,
      this.minPembelian,
      this.isPopup,
      this.imagePopup,
      this.videoPopup});

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    supplierId = json['supplier_id'];
    supplier = json['supplier'];
    name = json['name'];
    typeNews = json['type_news'];
    description = json['description'];
    linkPromo = json['link_promo'];
    codePromo = json['code_promo'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    urlImage = json['url_image'];
    syarat = json['syarat'];
    createdBy = json['created_by'];
    linkOutsite = json['link_outsite'];
    urlOutsite = json['url_outsite'];
    totalItems = json['total_items'];
    quota = json['quota'];
    region = json['region'];
    tipe = json['tipe'];
    maxToko = json['max_toko'];
    isDeleted = json['is_deleted'];
    status = json['status'];
    value = json['value'];
    maxTotalDisc = json['max_total_disc'];
    minPembelian = json['min_pembelian'];
    isPopup = json['is_popup'];
    imagePopup = json['image_popup'];
    videoPopup = json['video_popup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['supplier_id'] = this.supplierId;
    data['supplier'] = this.supplier;
    data['name'] = this.name;
    data['type_news'] = this.typeNews;
    data['description'] = this.description;
    data['link_promo'] = this.linkPromo;
    data['code_promo'] = this.codePromo;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['url_image'] = this.urlImage;
    data['syarat'] = this.syarat;
    data['created_by'] = this.createdBy;
    data['link_outsite'] = this.linkOutsite;
    data['url_outsite'] = this.urlOutsite;
    data['total_items'] = this.totalItems;
    data['quota'] = this.quota;
    data['region'] = this.region;
    data['tipe'] = this.tipe;
    data['max_toko'] = this.maxToko;
    data['is_deleted'] = this.isDeleted;
    data['status'] = this.status;
    data['value'] = this.value;
    data['max_total_disc'] = this.maxTotalDisc;
    data['min_pembelian'] = this.minPembelian;
    data['is_popup'] = this.isPopup;
    data['image_popup'] = this.imagePopup;
    data['video_popup'] = this.videoPopup;
    return data;
  }
}