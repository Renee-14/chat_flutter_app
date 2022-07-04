import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.password,

    required this.id,
    required this.token,
  });

  late final String username;
  late final String password;

  late final String id;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];

    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;

    data['id'] = id;
    data['token'] = token;
    return data;
  }
}