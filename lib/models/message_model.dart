import 'dart:convert';

List<messageModel> userFromJson(String str) => List<messageModel>.from(json.decode(str).map((x) => messageModel.fromJson(x)));
String userToJson(List<messageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class messageModel {
  messageModel({
    required this.id,
    required this.messageGroupId,
    required this.message,
    required this.way,
    required this.createdAt,
    required this.updateAt,
    required this.isActive,
    required this.isDelete,
    required this.type,});
  int? id;
  int? messageGroupId;
  String? message;
  int? way;
  String? createdAt;
  String? updateAt;
  int? isActive;
  int? isDelete;
  String? type;
  factory messageModel.fromJson(Map<String,dynamic> json) => messageModel(
      id: json['id'],
      messageGroupId: json['messageGroupId'],
      message: json['message'],
      way:json['way'],
      createdAt:json['createdAt'],
      updateAt: json['updateAt'],

      isActive: json['isActive'],
      isDelete: json['isDelete'],
      type: json['type']);
  //late final String message;

  Map<String, dynamic> toJson() => {
    'id': id,
    'messageGroupId':messageGroupId,
    'message':message,
    'way':way,
    'updateAt':updateAt,
    'createdAt':createdAt,
    'isActive':isActive,
    'isDelete':isDelete,
    'type':type,

  };
}

