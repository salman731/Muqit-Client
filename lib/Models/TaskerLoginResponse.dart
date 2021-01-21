// To parse this JSON data, do
//
//     final taskerLoginModel = taskerLoginModelFromJson(jsonString);

import 'dart:convert';

TaskerLoginModel taskerLoginModelFromJson(String str) =>
    TaskerLoginModel.fromJson(json.decode(str));

String taskerLoginModelToJson(TaskerLoginModel data) =>
    json.encode(data.toJson());

class TaskerLoginModel {
  TaskerLoginModel({
    this.message,
    this.status,
    this.id,
    this.email,
    this.name,
  });

  String message;
  bool status;
  String id;
  String email;
  String name;

  factory TaskerLoginModel.fromJson(Map<String, dynamic> json) =>
      TaskerLoginModel(
        message: json["message"],
        status: json["status"],
        id: json["id"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "id": id,
        "email": email,
        "name": name,
      };
}
