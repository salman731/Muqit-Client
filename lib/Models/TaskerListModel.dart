// To parse this JSON data, do
//
//     final tasker = taskerFromJson(jsonString);

import 'dart:convert';

List<Tasker> taskerFromJson(String str) =>
    List<Tasker>.from(json.decode(str).map((x) => Tasker.fromJson(x)));

String taskerToJson(List<Tasker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasker {
  Tasker({
    this.id,
    this.name,
    this.work,
    this.email,
    this.address,
    this.ratings,
  });

  String id;
  String name;
  String work;
  String email;
  String address;
  String ratings;

  factory Tasker.fromJson(Map<String, dynamic> json) => Tasker(
        id: json["id"],
        name: json["name"],
        work: json["work"],
        email: json["email"],
        address: json["address"],
        ratings: json["ratings"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "work": work,
        "email": email,
        "address": address,
        "ratings": ratings,
      };
}
