class Reward {
  String id;
  String title;
  String description;
  String image;
  String validUntil;
  Null companyId;
  String type;
  Null isDeleted;
  String isActive;
  String createdAt;
  String createdBy;
  String updatedAt;

  Reward(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.validUntil,
      this.companyId,
      this.type,
      this.isDeleted,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.updatedAt});

  Reward.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    validUntil = json['valid_until'];
    companyId = json['company_id'];
    type = json['type'];
    isDeleted = json['is_deleted'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['valid_until'] = this.validUntil;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['is_deleted'] = this.isDeleted;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
