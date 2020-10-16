class Convert {
  static T ifExist<T>(json, key) {
    if (json[key] != null) {
      return json[key];
    }
    return null;
  }

  static T ifExistObject<T>(json, key, Function fromJson) {
    if (json[key] != null) {
      return fromJson(json[key]);
    }
    return null;
  }

  static List<T> ifExistList<T>(list, Function fromJson) {
    if (list != null) {
      var tempList = new List<T>();
      list.forEach((v) {
        tempList.add(fromJson(v));
      });
      return tempList;
    }
    return null;
  }
}
