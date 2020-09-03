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

  //local
  static String urlListProvince = '${local}list_province';
  static String urlListCity = '${local}list_city';
  static String urlListStates = '${local}list_states';
}
