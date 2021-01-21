// To parse this JSON data, do
//
//     final appointmentListModel = appointmentListModelFromJson(jsonString);

import 'dart:convert';

List<AppointmentListModel> appointmentListModelFromJson(String str) =>
    List<AppointmentListModel>.from(
        json.decode(str).map((x) => AppointmentListModel.fromJson(x)));

String appointmentListModelToJson(List<AppointmentListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentListModel {
  AppointmentListModel({
    this.tid,
    this.id,
    this.name,
    this.work,
    this.description,
    this.fixdate,
    this.workaddress,
    this.status,
    this.initialQuote,
    this.finalQuote,
  });

  String tid;
  String id;
  String name;
  String work;
  String description;
  String fixdate;
  String workaddress;
  String status;
  String initialQuote;
  String finalQuote;

  factory AppointmentListModel.fromJson(Map<String, dynamic> json) =>
      AppointmentListModel(
        tid: json["tid"],
        id: json["id"],
        name: json["name"],
        work: json["work"],
        description: json["description"],
        fixdate: json["fixdate"],
        workaddress: json["workaddress"],
        status: json["status"],
        initialQuote: json["initialQuote"],
        finalQuote: json["finalQuote"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "id": id,
        "name": name,
        "work": work,
        "description": description,
        "fixdate": fixdate,
        "workaddress": workaddress,
        "status": status,
        "initialQuote": initialQuote,
        "finalQuote": finalQuote,
      };
}
