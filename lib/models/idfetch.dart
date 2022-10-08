import 'dart:convert';

ipfetchModel ipfetchModelFromJson(String str) =>
    ipfetchModel.fromJson(json.decode(str));

String ipfetchModelToJson(ipfetchModel data) =>
    json.encode(data.toJson());

class ipfetchModel {
  int Id;

  ipfetchModel({
    required this.Id,

  });

  factory ipfetchModel.fromJson(Map<String, dynamic> json) =>
      ipfetchModel(
        Id: json["id"],

      );

  Map<String, dynamic> toJson() => {
    "id": Id,

  };
}
