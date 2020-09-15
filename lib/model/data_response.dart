import 'package:aksestokomobile/model/Address.dart';
import 'package:aksestokomobile/model/Cart.dart';
import 'package:aksestokomobile/model/Distributor.dart';
import 'package:aksestokomobile/model/Product.dart';

class DataResponse {
  String token;
  int idBK;
  List<Distributor> listDistributor;
  List<Product> listProduct;
  List<Address> listAddress;
  List<Cart> listCart;
  Address address;
  String shipmentPrice;
  DataResponse({this.token});

  T ifExist<T>(json, key) {
    if (json[key] != null) {
      return json[key];
    }
    return null;
  }

  T ifExistObject<T>(json, key, Function fromJson) {
    if (json[key] != null) {
      return fromJson(json[key]);
    }
    return null;
  }

  List<T> ifExistList<T>(json, key, Function fromJson) {
    if (json[key] != null) {
      var tempList = new List<T>();
      json[key].forEach((v) {
        tempList.add(fromJson(v));
      });
      return tempList;
    }
    return null;
  }

  DataResponse.fromJson(Map<String, dynamic> json) {
    token = ifExist(json, 'token');
    shipmentPrice = ifExist(json, 'biaya_pengiriman');
    idBK = ifExist(json, 'id_bk_user');
    listDistributor = ifExistList(json, 'list_distributor', (obj) {
      return Distributor.fromJson(obj);
    });

    listProduct = ifExistList(json, 'list_product', (obj) {
      return Product.fromJson(obj);
    });

    listCart = ifExistList(json, 'list_cart', (obj) {
      return Cart.fromJson(obj);
    });

    address = ifExistObject(json, 'address', (obj){
      return Address.fromJson(obj);
    });

    listAddress = ifExistList(json, 'list_alamat', (obj) {
      return Address.fromJson(obj);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}