import 'package:aksestokomobile/main_common.dart';

class ApiConfig {
  // static const String host = 'http://10.15.4.102:9090/';
  // static String host = 'http://roufdev.000webhostapp.com/';
  static const String hostDev = 'https://qp.forca.id/';
  static const String host = 'https://pos.forca.id/';
  static String path = '${isProd ? host : hostDev}api/v1/retailer/';
  static String local = '${isProd ? host : hostDev}api/Local/';
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
  static String urlUpdatePassword = '${path}profile/update_password';
  static String urlProfile = '${path}auth/profile';
  static String urlUpdateToken = '${path}auth/addorupdatetoken_notif';
  static String urlGetToken = '${path}auth/user_notif_token';
  static String urlGetPoint = '${path}auth/point';

  //profile
  static String urlAddAddress = '${path}Profile/add_address';
  static String urlDeleteAddress = '${path}Profile/delete_address';
  static String urlUpdateAddress = '${path}Profile/update_address';
  static String urlDetailProfile = '${path}Profile/detail_profile';
  static String urlUpdateProfile = '${path}Profile/update_profile';
  static String urlGenerateOTP = '${path}Profile/generate_phone_otp';
  static String urlVerivyOTP = '${path}Profile/verify_phone_otp';
  static String urlListProduct = '${path}Profile/list_product';
  static String urlListDistributor = '${path}Profile/list_distributor';
  static String urlDetailAddress = '${path}Profile/detail_address';
  static String urlListAddress = '${path}Profile/list_address';
  static String urlDetailSalesPerson = '${path}Profile/detail_sales_person';
  static String urlUpdateSalesPerson = '${path}Profile/update_sales_person';

  //promo
  static String urlListPromo = '${path}Purchase/list_promo';
  static String urlAddPromo = '${path}Purchase/add_promo';

  //cusstomerService
  static String urlListIssue = '${path}Profile/cs';
  static String urlAddIssue = '${path}Profile/add_keluhan';
  static String urlAddComment = '${path}Profile/add_comment_keluhan';
  static String urlDetailIssue = '${path}Profile/cs_detail';

  static String urlFaq = '${path}Profile/faq';

  //purchase
  static String urlCart = '${path}Purchase/list_cart';
  static String urlDeleteItemCart = '${path}Purchase/delete_item_cart';
  static String urlUpdateItemCart = '${path}Purchase/update_cart';
  static String urlAddItemCart = '${path}Purchase/add_to_cart';
  static String urlListOrder = '${path}Purchase/list_order';
  static String urlDetailOrder = '${path}Purchase/detail_order';
  static String urlDetailPromo = '${path}Purchase/detail_promo';

  static String urlCancelOrder = '${path}Purchase/cancel_order';
  static String urlConfirmUpdatePrice = '${path}Purchase/confirm_update_price';
  static String urlCancelUpdatePrice = '${path}Purchase/cancel_update_price';
  static String urlConfirmDelivery = '${path}Purchase/confirm_delivery';

  static String urlDetailCheckout = '${path}Purchase/detail_checkout';
  static String urlActionOrder = '${path}Purchase/action_checkout';
  static String urlShipmentPrice = '${path}Purchase/shipment_group_price';

  //payment
  static String urlListPayment = '${path}Purchase/list_payment';
  static String urlDetailAddPayment = '${path}Purchase/detail_payment';
  static String urlAddPayment = '${path}Purchase/add_payment';
  static String urlListProofPayment = '${path}Purchase/list_proof_payment';
  static String urlGetUrlKreditPro = '${path}Purchase/apply_credit';

  //address
  static String urlProvinsi = '${local}list_province';
  static String urlKabupaten = '${local}list_city';
  static String urlKecamatan = '${local}list_states';
  static String urlPostalCode = '${local}postal_code';
  static String urlListKodepos = '${local}list_kode_pos';
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
