import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  int? id;
  LoginResponseModel({
    //required this.message,
    required this.id,
  });
  //late final String message;


  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    //message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =new Map<String, dynamic>();
    //_data['message'] = message;
    data['id'] = this.id;
    return data;
  }
}

