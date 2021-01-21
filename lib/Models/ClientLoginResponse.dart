// To parse this JSON data, do
//
//     final clientLoginModel = clientLoginModelFromJson(jsonString);

import 'dart:convert';

ClientLoginModel clientLoginModelFromJson(String str) =>
    ClientLoginModel.fromJson(json.decode(str));

String clientLoginModelToJson(ClientLoginModel data) =>
    json.encode(data.toJson());

class ClientLoginModel {
  ClientLoginModel({
    this.message,
    this.status,
    this.id,
    this.username,
    this.email,
  });

  String message;
  bool status;
  String id;
  String username;
  String email;

  factory ClientLoginModel.fromJson(Map<String, dynamic> json) =>
      ClientLoginModel(
        message: json["message"],
        status: json["status"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "id": id,
        "username": username,
        "email": email,
      };
}
