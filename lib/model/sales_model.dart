class SalesModel {
  int id_distributor;
  int price_group_id;
  String delivery_date;
  String delivery_method;
  String company_address_id;
  String payment_method;
  String uuid;
  String promo;
  String note;
  String bank_id;
  int customer_group_id;
  String payment_durasi;
  int input_payment_durasi;

  SalesModel(
      {this.id_distributor,
      this.price_group_id,
      this.delivery_date,
      this.delivery_method,
      this.company_address_id,
      this.payment_method,
      this.uuid,
      this.promo,
      this.note,
      this.bank_id,
      this.customer_group_id,
      this.payment_durasi,
      this.input_payment_durasi});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_distributor'] = id_distributor;
    data['price_group_id'] = price_group_id;
    data['delivery_date'] = delivery_date;
    data['delivery_method'] = delivery_method;
    data['company_address_id'] = company_address_id;
    data['payment_method'] = payment_method;
    data['uuid'] = uuid;
    data['code_promo'] = promo;
    data['note'] = note;
    data['bank_id'] = bank_id;
    data['customer_group_id'] = customer_group_id;
    data['payment_durasi'] = payment_durasi;
    data['input_payment_durasi'] = input_payment_durasi;
    return data;
  }
}
