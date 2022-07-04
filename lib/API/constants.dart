import 'dart:convert';

import 'package:chat_demo/API/shared_services.dart';
import 'package:chat_demo/classes/user.dart';
import 'package:http/http.dart'as http;

import '../classes/login_request_model.dart';
import '../classes/login_response_model.dart';
import '../classes/user.dart';
import 'apis.dart';


class APIService {
  static var client = http.Client();

  static Future<bool> login(
      LoginRequestModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  }