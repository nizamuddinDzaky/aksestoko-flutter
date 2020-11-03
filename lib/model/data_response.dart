import 'package:aksestokomobile/model/address.dart';
import 'package:aksestokomobile/model/alamat.dart';
import 'package:aksestokomobile/model/cart.dart';
import 'package:aksestokomobile/model/customer.dart';
import 'package:aksestokomobile/model/distributor.dart';
import 'package:aksestokomobile/model/order_detail.dart';
import 'package:aksestokomobile/model/order_model.dart';
import 'package:aksestokomobile/model/product.dart';
import 'package:aksestokomobile/model/profile.dart';
import 'package:aksestokomobile/model/promo.dart';
import 'package:aksestokomobile/model/ringkasan.dart';
import 'package:aksestokomobile/model/sales_person.dart';
import 'package:aksestokomobile/model/zone.dart';
import 'package:aksestokomobile/util/my_util.dart';

class DataResponse {
  String token;
  int idBK;
  List<Distributor> listDistributor;
  List<Promo> listPromo;
  List<Product> listProduct;
  List<Address> listAddress;
  List<Cart> listCart;
  List<Zone> listProvinsi;
  List<Zone> listKabupaten;
  List<Zone> listKecamatan;
  List<Zone> listDesa;
  Profile profile;
  SalesPerson salesPerson;
  Address address;
  String shipmentPrice;
  String idPurchase;
  Customer customer;
  List<Alamat> listAlamat;
  OrderModel orderModelDalamProses;
  OrderDetail orderDetail;
  Distributor distributor;
  List<String> pengiriman;
  Ringkasan ringkasan;

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
    profile = ifExistObject(json, 'profile', (obj) {
      return Profile.fromJson(obj);
    });
    salesPerson = ifExistObject(json, 'sales_person', (obj) {
          return SalesPerson.fromJson(obj);
        }) ??
        ifExistObject(json, 'detail_sales_person', (obj) {
          return SalesPerson.fromJson(obj);
        });
    token = ifExist(json, 'token');
    shipmentPrice = ifExist(json, 'biaya_pengiriman');
    idBK = ifExist(json, 'id_bk_user') ??
        (ifExist(json, 'company_id')?.toString()?.toInt());
    listDistributor = ifExistList(json, 'list_distributor', (obj) {
      return Distributor.fromJson(obj);
    });

    listProduct = ifExistList(json, 'list_product', (obj) {
      return Product.fromJson(obj);
    });

    listCart = ifExistList(json, 'list_cart', (obj) {
      return Cart.fromJson(obj);
    }) ??
        ifExistList(json, 'product', (obj) {
          return Cart.fromJson(obj);
        }) ??
        ifExistList(json, 'list_product', (obj) {
          return Cart.fromJson(obj);
        });

    address = ifExistObject(json, 'address', (obj) {
      return Address.fromJson(obj);
    }) ?? ifExistObject(json, 'alamat_pengiriman', (obj) {
      return Address.fromJson(obj);
    });

    listAddress = ifExistList(json, 'list_alamat', (obj) {
      return Address.fromJson(obj);
    });

    listProvinsi = ifExistList(json, 'list_province', (obj) {
      return Zone.fromJson(obj);
    });

    listKabupaten = ifExistList(json, 'list_kabupaten', (obj) {
      return Zone.fromJson(obj);
    });

    listKecamatan = ifExistList(json, 'list_kecamatan', (obj) {
      return Zone.fromJson(obj);
    });

    listDesa = ifExistList(json, 'list_kelurahan', (obj) {
      return Zone.fromJson(obj);
    });
    customer = ifExistObject(json, 'customer', (obj) {
      return Customer.fromJson(obj);
    });
    listAlamat = ifExistList(json, 'list_alamat', (obj) {
      return Alamat.fromJson(obj);
    });
    orderModelDalamProses = json['order_dalam_proses'] != null
        ? new OrderModel.fromJson(json['order_dalam_proses'])
        : null;
    orderDetail = ifExistObject(json, 'detail_pemesanan', (obj) {
      return OrderDetail.fromJson(obj);
    });
    listPromo = ifExistList(json, 'list_promo', (obj) {
      return Promo.fromJson(obj);
    });
    pengiriman = ifExistList(json, 'pengiriman', (obj) {
      return obj?.toString();
    });
    ringkasan = ifExistObject(json, 'ringkasan', (obj) {
      return Ringkasan.fromJson(obj);
    });
    distributor = ifExistObject(json, 'distributor', (obj) {
      return Distributor.fromJson(obj);
    });
    idPurchase = ifExist(json, 'purchase_id');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
