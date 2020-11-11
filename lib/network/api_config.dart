class ApiConfig {
  // static const String host = 'http://10.15.4.102:9090/';
  // static String host = 'http://roufdev.000webhostapp.com/';
  static const String host = 'https://qp.forca.id/';
  static const String path = '${host}api/v1/retailer/';
  static const String local = '${host}api/Local/';
  static const String urlRajaAPi = 'https://x.rajaapi.com';

  //auth
  static String urlLogin = '${path}Auth/login';
  static String urlRegisterCheck = '${path}Auth/register_check';
  static String urlRegisterSubmit = '${path}Auth/register_submit';
  static String urlGenerateEmail = '${path}Auth/generate_email';
  static String urlResetPass = '${path}auth/forgot_pasword';
  static String urlSendCode = '${path}auth/send_activation_code';
  static String urlSendOTP = '${path}auth/send_otp';
  static String urlCheckOTP = '${path}auth/check_otp';
  static String urlChangePassword = '${path}auth/change_password';
  static String urlProfile = '${path}auth/profile';

  //profile
  static const String urlAddAddress = '${path}Profile/add_address';
  static const String urlDeleteAddress = '${path}Profile/delete_address';
  static const String urlUpdateAddress = '${path}Profile/update_address';
  static const String urlDetailProfile = '${path}Profile/detail_profile';
  static const String urlUpdateProfile = '${path}Profile/update_profile';
  static String urlListProduct = '${path}Profile/list_product';
  static String urlListDistributor = '${path}Profile/list_distributor';
  static String urlDetailAddress = '${path}Profile/detail_address';
  static String urlListAddress = '${path}Profile/list_address';
  static String urlDetailSalesPerson = '${path}Profile/detail_sales_person';

  //promo
  static String urlListPromo = '${path}Purchase/list_promo';
  static String urlAddPromo = '${path}Purchase/add_promo';

  //purchase
  static String urlCart = '${path}Purchase/list_cart';
  static String urlDeleteItemCart = '${path}Purchase/delete_item_cart';
  static String urlUpdateItemCart = '${path}Purchase/update_cart';
  static String urlAddItemCart = '${path}Purchase/add_to_cart';
  static String urlListOrder = '${path}Purchase/list_order';
  static String urlDetailOrder = '${path}Purchase/detail_order';

  static String urlCancelOrder = '${path}Purchase/cancel_order';
  static String urlConfirmDelivery = '${path}Purchase/confirm_delivery';

  static String urlDetailCheckout = '${path}Purchase/detail_checkout';
  static String urlActionOrder = '${path}Purchase/action_checkout';
  static String urlShipmentPrice = '${path}Purchase/shipment_group_price';

  //payment
  static String urlListPayment = '${path}Purchase/list_payment';
  static String urlDetailAddPayment = '${path}Purchase/detail_payment';
  static String urlAddPayment = '${path}Purchase/add_payment';
  static String urlListProofPayment = '${path}Purchase/list_proof_payment';

  //address
  static const String urlProvinsi = '${local}list_province';
  static const String urlKabupaten = '${local}list_city';
  static const String urlKecamatan = '${local}list_states';
  static String urlListProvinsi = '${path}get_list_province.php';
  static String urlListKabupaten = '${path}get_list_kabupaten.php';
  static String urlListKecamatan = '${path}get_list_kecamatan.php';
  static String urlListDesa = '${path}get_list_kelurahan.php';
  static String urlEditAddress = '${path}put_update_alamat.php';
  static String urlTokenRajaApi = '${urlRajaAPi}/poe';
  static String urlGetProvinsiRajaApi = 'm/wilayah/provinsi';
  static String urlGetKabupatenRajaApi = 'm/wilayah/kabupaten?';
  static String urlGetKecamatanRajaApi = 'm/wilayah/kecamatan?';
  static String urlGetDesaRajaApi = 'm/wilayah/kelurahan?';

  //shipment
  static String urlListShipment = '${path}get_list_tipe_pengiriman.php';

  //local
  static String urlListProvince = '${local}list_province';
  static String urlListCity = '${local}list_city';
  static String urlListStates = '${local}list_states';
}
