import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/model/ringkasan.dart';

class CheckoutModel {
  Address alamatPengiriman;
  Distributor distributor;
  List<String> pengiriman;
  List<Shipment> listPengiriman;
  Ringkasan ringkasan;
  List<Product> listProduct;

  CheckoutModel(
      {this.alamatPengiriman,
      this.distributor,
      this.pengiriman,
      this.ringkasan,
      this.listProduct});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    alamatPengiriman = json['alamat_pengiriman'] != null
        ? new Address.fromJson(json['alamat_pengiriman'])
        : null;
    distributor = json['distributor'] != null
        ? new Distributor.fromJson(json['distributor'])
        : null;
    pengiriman = json['pengiriman'].cast<String>();
    ringkasan = json['ringkasan'] != null
        ? new Ringkasan.fromJson(json['ringkasan'])
        : null;
    if (json['list_product'] != null) {
      listProduct = new List<Product>();
      json['list_product'].forEach((v) {
        listProduct.add(new Product.fromJson(v));
      });
    }
    listPengiriman = pengiriman?.map((e) => Shipment(value: e))?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alamatPengiriman != null) {
      data['alamat_pengiriman'] = this.alamatPengiriman.toJson();
    }
    if (this.distributor != null) {
      data['distributor'] = this.distributor.toJson();
    }
    data['pengiriman'] = this.pengiriman;
    if (this.ringkasan != null) {
      data['ringkasan'] = this.ringkasan.toJson();
    }
    if (this.listProduct != null) {
      data['list_product'] = this.listProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipment {
  String name;
  String value;
  int totalHarga;
  int totalAkhir;

  Shipment({this.name, this.value, this.totalHarga, this.totalAkhir}) {
    name = convertName(value);
  }

  Shipment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    totalHarga = json['total_harga'];
    totalAkhir = json['total_akhir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['total_harga'] = totalHarga;
    data['total_akhir'] = totalAkhir;
    return data;
  }

  convertName(String valueShipment) {
    return valueShipment == 'delivery'
        ? 'Pengiriman Distributor'
        : (valueShipment == 'pickup' ? 'Pengambilan Sendiri' : valueShipment);
  }

  @override
  String toString() {
    return name;
  }
}
