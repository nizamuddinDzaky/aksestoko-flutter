import 'dart:convert';

import 'package:aksestokomobile/resource/my_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPref {
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefs;
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Map getMap(String key, {defValue}) {
    return jsonDecode(
        _prefsInstance.getString(key) ?? defValue?.toString() ?? '{}');
  }

  static Future<bool> setMap(String key, Map value) async {
    var prefs = await _instance;
    return prefs?.setString(key, jsonEncode(value ?? {})) ??
        Future.value(false);
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  static bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }

  static int getInt(String key, [int defValue]) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }

  static double getDouble(String key, [double defValue]) {
    return _prefsInstance.getDouble(key) ?? defValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    var prefs = await _instance;
    return prefs?.setDouble(key, value) ?? Future.value(false);
  }

  //action
  static logout() {
    //setRemember(false, null);
    [
      'profile',
    ].forEach((key) {
      _prefs?.remove(key);
    });
    clearNotif();
    setIdDristributor(null);
    setCustomerGroupId(null);
    setPriceGroupId(null);
    setDisributorName(null);
    setDisributorCode(null);
    setATToken(null);
  }

  //get value
  static String getATToken() => getString(MyString.KEY_AT_TOKEN);

  static int getIdBk() => getInt(MyString.KEY_ID_BK);

  static int getIdDistributor() => getInt(MyString.KEY_ID_DISTRIBUTOR);

  static setATToken(String value) {
    setString(MyString.KEY_AT_TOKEN, value);
  }

  static bool getRemember() => getBool(MyString.KEY_IS_REMEMBER);

  static setRemember(bool remember, login) {
    setBool(MyString.KEY_IS_REMEMBER, remember);
    setString(MyString.KEY_USERNAME, remember ? (login?.username ?? '') : '');
    setString(MyString.KEY_PASSWORD, remember ? (login?.password ?? '') : '');
  }

  static String getUsername() => getString(MyString.KEY_USERNAME);

  static String getDistributorName() =>
      getString(MyString.KEY_DISTRIBUTOR_NAME);

  static String getDistributorCode() =>
      getString(MyString.KEY_DISTRIBUTOR_CODE);

  static setUsername(String value) {
    setString(MyString.KEY_USERNAME, value);
  }

  static String getPassword() => getString(MyString.KEY_PASSWORD);

  static setPassword(String value) {
    setString(MyString.KEY_PASSWORD, value);
  }

  static setDisributorName(String value) {
    setString(MyString.KEY_DISTRIBUTOR_NAME, value);
  }

  static setDisributorCode(String value) {
    setString(MyString.KEY_DISTRIBUTOR_CODE, value);
  }

  static setRole(int roleId) {
    setInt(MyString.KEY_ROLE_USER, roleId);
  }

  static setIdBk(int idBk) {
    setInt(MyString.KEY_ID_BK, idBk);
  }

  static setIdDristributor(int idDistributor) {
    setInt(MyString.KEY_ID_DISTRIBUTOR, idDistributor);
  }

  static bool isIdDistributorExist() {
    if (getIdDistributor() == null) {
      return false;
    } else {
      return true;
    }
  }

  static int getRole() => getInt(MyString.KEY_ROLE_USER);

  static int getCustomerGroupId() => getInt(MyString.KEY_ID_CUSTOMER_GROUP);

  static setCustomerGroupId(int customerGroupId) {
    setInt(MyString.KEY_ID_CUSTOMER_GROUP, customerGroupId);
  }

  static int getPriceGroupId() => getInt(MyString.KEY_ID_PRICE_GROUP);

  static setPriceGroupId(int priceGroupId) {
    setInt(MyString.KEY_ID_PRICE_GROUP, priceGroupId);
  }

  static Future<bool> setKeyNotif(String keyNotif) async {
    var prefs = await _instance;
    var listString = await getKeyNotif();
    if (!listString.contains(keyNotif)) listString.add(keyNotif);
    return prefs?.setStringList('notif', listString) ?? Future.value(false);
  }

  static clearNotif() async {
    try {
      _prefsInstance.remove('notif${getIdDistributor() ?? ''}');
      var listString = await getKeyNotif();
      listString?.forEach((key) {
        _prefsInstance.remove(key);
      });
    } catch (_) {}
    _prefsInstance.remove('notif');
  }

  static Future<List<String>> getKeyNotif() async {
    return _prefsInstance.getStringList('notif') ?? [];
  }

  static void setOtpVerPhone(double milis) {
    setDouble('otpVerPhone', milis);
  }

  static Future<double> getOtpVerPhone() async {
    return _prefsInstance.getDouble('otpVerPhone') ?? 0;
  }

  static void setDistributorCount(int count) {
    setInt('setDistributorCount', count);
  }

  static int getDistributorCount() {
    return _prefsInstance.getInt('setDistributorCount') ?? 0;
  }
}
