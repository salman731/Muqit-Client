// To parse this JSON data, do
//
//     final taskerSignUp = taskerSignUpFromJson(jsonString);

import 'dart:convert';

TaskerSignUp taskerSignUpFromJson(String str) =>
    TaskerSignUp.fromJson(json.decode(str));

String taskerSignUpToJson(TaskerSignUp data) => json.encode(data.toJson());

class TaskerSignUp {
  TaskerSignUp({
    this.message,
    this.status,
    this.id,
  });

  String message;
  bool status;
  int id;

  factory TaskerSignUp.fromJson(Map<String, dynamic> json) => TaskerSignUp(
        message: json["message"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "id": id,
      };
}
