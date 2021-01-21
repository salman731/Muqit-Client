// To parse this JSON data, do
//
//     final taskerChat = taskerChatFromJson(jsonString);

import 'dart:convert';

List<TaskerChat> taskerChatFromJson(String str) =>
    List<TaskerChat>.from(json.decode(str).map((x) => TaskerChat.fromJson(x)));

String taskerChatToJson(List<TaskerChat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskerChat {
  TaskerChat({
    this.id,
    this.username,
    this.email,
  });

  String id;
  String username;
  String email;

  factory TaskerChat.fromJson(Map<String, dynamic> json) => TaskerChat(
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
      };
}
