import 'package:aksestokomobile/network/api_config.dart';

class MyString {
  static const KEY_AT_TOKEN = "Aksestoko-Token";
  static const KEY_TOKEN = "token";
  static const KEY_IS_REMEMBER = "isRemember";
  static const KEY_USERNAME = "username";
  static const KEY_PASSWORD = "password";

  //
  static const KEY_ID_BK = "id_bk";
  static const KEY_ID_DISTRIBUTOR = "id_distributor";
  static const KEY_ID_CART = "id_cart";
  static const KEY_DISTRIBUTOR_NAME = "distributor_name";
  static const KEY_DISTRIBUTOR_CODE = "distributor_code";
  static const KEY_ID_PROVINSI = "id_provinsi";
  static const KEY_ID_KABUPATEN = "id_kabupaten";
  static const KEY_ID_KECAMATAN = "id_kecamatan";

  // sales booking
  static const KEY_ID_SALES_BOOKING = "id_sales_booking";
  static const KEY_SALE_STATUS = "sale_status";
  static const KEY_DELIVERY_STATUS_SALE = "delivery_status_sale";

  // good received
  static const KEY_ID_GOODS_RECEIVED = "id_goods_received";
  static const KEY_GR_STATUS = "goods_received_status";
  static const KEY_GR_PRICE = "price";
  static const KEY_GOOD_RECEIVED = "good_received";

  // auth
  static const KEY_ID_USER = "id_user";

  // customer
  static const KEY_ID_CUSTOMER = "id_customers";

  // issue
  static const KEY_ID_ISSUE = "id_issue";

  // warehouse
  static const KEY_ID_WAREHOUSE = "id_warehouse";

  // supplier
  static const KEY_ID_SUPPLIER = "supplier_id";

  // product
  // customer group
  static const KEY_CUSTOMER_GROUP = "customer_group";
  static const KEY_ID_CUSTOMER_GROUP = "id_customer_group";

  // price group
  static const KEY_PRICE_GROUP = "price_group";
  static const KEY_ID_PRICE_GROUP = "id_price_group";

  // payment
  static const KEY_PAYMENT_STATUS = "payment_status";
  static const KEY_ID_PAYMENT = "id_payments";

  // delivery
  static const KEY_ID_DELIVERY = "id_delivery";
  static const KEY_ID_DELIVERIES_BOOKING = "id_deliveries_booking";

  // dashboard
  static const KEY_PIE_CHART_DATE = "year_month";

  // filter
  static const KEY_IS_SEARCH = "isSearch";
  static const KEY_SEARCH = "search";
  static const KEY_FILTER = "filter";
  static const KEY_SORT_BY = "sortBy";
  static const KEY_SORT_TYPE = "sortType";
  static const KEY_START_DATE = "start_date";
  static const KEY_END_DATE = "end_date";

  // role
  static const KEY_ROLE_USER = 'roleUser';
  static const ROLE_SUPER_ADMIN = 2;
  static const ROLE_WAREHOUSE_ADMIN = 8;
  static const ROLE_CASHIER = 5;

  // txt
  static const TXT_CONNECTION_FAILED = "Gagal tersambung, cek koneksi.";

  //  payment
  static const TXT_COD = "Bayar Di Tempat";
  static const TXT_KREDIT = "Tempo Dengan Distributor";
  static const TXT_CBD = "Bayar Sebelum Dikirim";
  static String BASE_PATH_ICON_BANK = ApiConfig.host+"assets/uploads/" ;
}
