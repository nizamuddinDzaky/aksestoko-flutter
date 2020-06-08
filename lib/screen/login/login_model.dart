class Login {
  String username;
  String password;

  Login({this.username, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    username = json['username'] as String;
    password = json['password'] as String;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'username': username,
    'password': password,
  };
}