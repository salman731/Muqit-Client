// To parse this JSON data, do
//
//     final taskerEdit = taskerEditFromJson(jsonString);

import 'dart:convert';

List<TaskerEdit> taskerEditFromJson(String str) =>
    List<TaskerEdit>.from(json.decode(str).map((x) => TaskerEdit.fromJson(x)));

String taskerEditToJson(List<TaskerEdit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskerEdit {
  TaskerEdit({
    this.id,
    this.name,
    this.contact,
    this.email,
  });

  String id;
  String name;
  String contact;
  String email;

  factory TaskerEdit.fromJson(Map<String, dynamic> json) => TaskerEdit(
        id: json["id"],
        name: json["name"],
        contact: json["contact"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact": contact,
        "email": email,
      };
}
