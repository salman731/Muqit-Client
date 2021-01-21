// To parse this JSON data, do
//
//     final tAppointmentListM = tAppointmentListMFromJson(jsonString);

import 'dart:convert';

List<TAppointmentListM> tAppointmentListMFromJson(String str) =>
    List<TAppointmentListM>.from(
        json.decode(str).map((x) => TAppointmentListM.fromJson(x)));

String tAppointmentListMToJson(List<TAppointmentListM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TAppointmentListM {
  TAppointmentListM({
    this.id,
    this.username,
    this.contact,
    this.workType,
    this.fixDate,
    this.description,
    this.workAddress,
    this.status,
    this.jobRateOffered,
    this.muqitProfit,
    this.taskerProfit,
    this.initialQuote,
    this.finalQuote,
  });

  String id;
  String username;
  String contact;
  String workType;
  String fixDate;
  String description;
  String workAddress;
  String status;
  String jobRateOffered;
  String muqitProfit;
  String taskerProfit;
  String initialQuote;
  String finalQuote;

  factory TAppointmentListM.fromJson(Map<String, dynamic> json) =>
      TAppointmentListM(
        id: json["id"],
        username: json["username"],
        contact: json["contact"],
        workType: json["work_type"],
        fixDate: json["fix_date"],
        description: json["description"],
        workAddress: json["work_address"],
        status: json["status"],
        jobRateOffered: json["jobRateOffered"],
        muqitProfit: json["muqitProfit"],
        taskerProfit: json["taskerProfit"],
        initialQuote: json["initialQuote"],
        finalQuote: json["finalQuote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "contact": contact,
        "work_type": workType,
        "fix_date": fixDate,
        "description": description,
        "work_address": workAddress,
        "status": status,
        "jobRateOffered": jobRateOffered,
        "muqitProfit": muqitProfit,
        "taskerProfit": taskerProfit,
        "initialQuote": initialQuote,
        "finalQuote": finalQuote,
      };
}
