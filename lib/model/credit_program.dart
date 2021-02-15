class CreditProgram {
  String title;
  String description;
  String image;
  String providedBy;
  String redirectView;
  String redirectForm;

  CreditProgram(
      {this.title,
        this.description,
        this.image,
        this.providedBy,
        this.redirectView,
        this.redirectForm});

  CreditProgram.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    providedBy = json['provided_by'];
    redirectView = json['redirect_view'] ??json['redirect'];
    redirectForm = json['redirect_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['provided_by'] = this.providedBy;
    data['redirect_view'] = this.redirectView;
    data['redirect_form'] = this.redirectForm;
    return data;
  }
}