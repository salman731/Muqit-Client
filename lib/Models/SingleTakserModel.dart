// To parse this JSON data, do
//
//     final singleTasker = singleTaskerFromJson(jsonString);

import 'dart:convert';

List<SingleTasker> singleTaskerFromJson(String str) => List<SingleTasker>.from(
    json.decode(str).map((x) => SingleTasker.fromJson(x)));
String singleTaskerToJson(List<SingleTasker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleTasker {
  SingleTasker({
    this.id,
    this.name,
    this.profile,
    this.address,
  });

  String id;
  String name;
  String profile;
  String address;

  factory SingleTasker.fromJson(Map<String, dynamic> json) => SingleTasker(
        id: json["id"],
        name: json["name"],
        profile: json["profile"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile": profile,
        "address": address,
      };
}
