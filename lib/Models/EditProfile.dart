// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

List<EditProfileModel> editProfileModelFromJson(String str) =>
    List<EditProfileModel>.from(
        json.decode(str).map((x) => EditProfileModel.fromJson(x)));

String editProfileModelToJson(List<EditProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditProfileModel {
  EditProfileModel({
    this.id,
    this.username,
    this.contact,
    this.email,
    this.address,
  });

  String id;
  String username;
  String contact;
  String email;
  String address;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        id: json["id"],
        username: json["username"],
        contact: json["contact"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "contact": contact,
        "email": email,
        "address": address,
      };
}
