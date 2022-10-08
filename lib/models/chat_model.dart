import 'dart:convert';

ChatModel ChatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String ChatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    required this.type,
   // required this.username,
   // required this.sentAt,
    required this.message,
    //required this.id,
  });

  String? type;
  //String username;
  //String sentAt;
  String message;



  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    type: json["type"],
    //username: json["username"],
    //sentAt: json["sentAt"],
    message: json["message"],
   // id:json["id"]
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    //"username": username,
    //"sentAt": sentAt,
    "message": message,
  };
}