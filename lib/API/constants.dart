import 'dart:convert';
import 'package:chat_demo/API/shared_services.dart';
import 'package:chat_demo/classes/firstpage_model.dart';
import 'package:chat_demo/classes/id_model.dart';
import 'package:chat_demo/models/group_id.dart';
import 'package:chat_demo/models/message_model.dart';
import 'package:chat_demo/models/send_msg.dart';
import 'package:http/http.dart'as http;
import '../classes/login_request_model.dart';
import '../classes/login_response_model.dart';
import '../classes/register_request_model.dart';
import '../models/groupmade.dart';
import 'apis.dart';



class APIService {
  static var client = http.Client();

  static Log(
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
     LoginResponseModel ip=loginResponseJson(response.body);

      return response.body;
    } else {
      return false;
    }

  }


  static  register(
      RegisterRequestModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200)
    {
      return true;
    } else {
      return false;
    }
  }

  static Future<Object> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    IpModel model= IpModel(
        id: loginDetails?.id ,);

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var y=loginDetails?.id;
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
  Future<List<FirstpageModel>> getlist() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    IpModel model= IpModel(
      id: loginDetails?.id ,);

    var url = Uri.http(Config.apiURL, Config.getlistAPI);

      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<FirstpageModel> posts = body
            .map(
              (dynamic item) =>FirstpageModel.fromJson(item),
        )
            .toList();

        return  posts;
      } else {
        throw "unable to retrive data";
      }

    }


 Future<List<messageModel>> getmessage(grpModel model) async {
    
    print(model.toJson());
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.getmessageAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<messageModel> posts = body
          .map(
            (dynamic item) =>messageModel.fromJson(item),
      )
          .toList();

      return  posts;

    } else {
      throw "unable to retrive data";
    }

  }

  static  sendmsg(
      sendmsgmodel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.sendmsgAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200)
    {
      return true;
    } else {
      return false;
    }
  }
  static  makegrp(
      addgrpModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };


    var url = Uri.http(
      Config.apiURL,
      Config.grpmade,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200)
    {
      return true;
    } else {
      return false;
    }
  }

  }






