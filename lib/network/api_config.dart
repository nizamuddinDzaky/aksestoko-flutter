class ApiConfig {
  // static String host = 'http://10.15.4.102:9090/';
  // static String host = 'http://roufdev.000webhostapp.com/';
  static String host = 'https://qp.forca.id/';
  static String path = '${host}api/v1/retailer/';
  static String local = '${host}api/Local/';

  //auth
  static String urlLogin = '${path}Auth/login';
  static String urlRegisterCheck = '${path}Auth/register_check';
  static String urlRegisterSubmit = '${path}Auth/register_submit';
  static String urlGenerateEmail = '${path}Auth/generate_email';
  static String urlResetPass = '${path}auth/forgot_pasword';
  static String urlSendOTP = '${path}auth/send_otp';
  static String urlCheckOTP = '${path}auth/check_otp';
  static String urlChangePassword = '${path}auth/change_password';
  static String urlProfile = '${path}auth/profile';
  static String urlProfileUpdate = '${path}auth/update_profile';
  static String urlDetailProfile = '${path}auth/detail_profile';

  //profile
  static String urlListProduct = '${path}Profile/list_product';
  static String urlListDistributor = '${path}Profile/list_distributor';
  static String urlDetailAddress = '${path}Profile/detail_address';
  static String urlListAddress = '${path}Profile/list_address';
  static String urlDetailSalesPerson = '${path}Profile/detail_sales_person';

  //promo
  static String urlListPromo = '${path}Order/list_promo';

  //purchase
  static String urlCart = '${path}Purchase/list_cart';
  static String urlDeleteItemCart = '${path}Purchase/delete_item_cart';
  static String urlUpdateItemCart = '${path}Purchase/update_cart';
  static String urlListOrder = '${path}Purchase/list_order';
  static String urlDetailOrder = '${path}Purchase/detail_order';
  static String urlDetailCheckout = '${path}Purchase/detail_checkout';
  static String urlListPayment = '${path}Purchase/list_payment';
  static String urlActionOrder = '${path}Purchase/action_checkout';
  static String urlShipmentPrice = '${path}Purchase/shipment_group_price';

  //address
  static String urlListProvinsi = '${path}get_list_province.php';
  static String urlListKabupaten = '${path}get_list_kabupaten.php';
  static String urlListKecamatan = '${path}get_list_kecamatan.php';
  static String urlListDesa = '${path}get_list_kelurahan.php';
  static String urlAddAddress = '${path}post_tambah_alamat.php';
  static String urlEditAddress = '${path}put_update_alamat.php';

  //shipment
  static String urlListShipment = '${path}get_list_tipe_pengiriman.php';

  //local
  static String urlListProvince = '${local}list_province';
  static String urlListCity = '${local}list_city';
  static String urlListStates = '${local}list_states';
}
