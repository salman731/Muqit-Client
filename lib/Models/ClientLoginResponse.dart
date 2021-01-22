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
    this.email,
    this.username,
    this.profile,
  });

  String message;
  bool status;
  String id;
  String email;
  String username;
  String profile;

  factory ClientLoginModel.fromJson(Map<String, dynamic> json) =>
      ClientLoginModel(
        message: json["message"],
        status: json["status"],
        id: json["id"],
        email: json["email"],
        username: json["username"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "id": id,
        "email": email,
        "username": username,
        "profile": profile,
      };
}
