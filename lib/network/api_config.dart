class ApiConfig {
//  static String host = 'https://qp.forca.id/';
//  static String host = 'http://10.15.4.102:9090/';
  /*static String path = '${host}api/v1/distributor/';
  static String local = '${host}api/Local/';*/
  static String host = 'http://roufdev.000webhostapp.com/';
//  static String host = 'http://10.15.4.102:9090/';
  static String path = '${host}';
  static String local = '${host}api/Local/';

  //auth
  static String urlLogin = '${path}login.php';
  static String urlResetPass = '${path}auth/forgot_password';
  static String urlProfile = '${path}auth/profile';
  static String urlProfileUpdate = '${path}auth/update_profile';

  //product
  static String urlListProduct = '${path}get_list_product.php';

  //distributor
  static String urlListDistributor = '${path}get_list_distributor.php';

  //cart
  static String urlCart = '${path}get_list_cart.php';

  //address
  static String urlDetailAddress = '${path}get_detail_alamat.php';
  static String urlListAddress = '${path}get_list_alamat.php';
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
