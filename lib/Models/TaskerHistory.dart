// To parse this JSON data, do
//
//     final taskerHistoryModel = taskerHistoryModelFromJson(jsonString);

import 'dart:convert';

List<TaskerHistoryModel> taskerHistoryModelFromJson(String str) =>
    List<TaskerHistoryModel>.from(
        json.decode(str).map((x) => TaskerHistoryModel.fromJson(x)));

String taskerHistoryModelToJson(List<TaskerHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskerHistoryModel {
  TaskerHistoryModel({
    this.workerId,
    this.name,
    this.date,
    this.timearrival,
    this.strtime,
    this.endtime,
    this.hourwork,
    this.perhourrate,
    this.natureofjob,
    this.totalpayment,
    this.employeepayment,
  });

  String workerId;
  String name;
  String date;
  String timearrival;
  String strtime;
  String endtime;
  String hourwork;
  String perhourrate;
  String natureofjob;
  String totalpayment;
  String employeepayment;

  factory TaskerHistoryModel.fromJson(Map<String, dynamic> json) =>
      TaskerHistoryModel(
        workerId: json["worker_id"],
        name: json["name"],
        date: json["date"],
        timearrival: json["timearrival"],
        strtime: json["strtime"],
        endtime: json["endtime"],
        hourwork: json["hourwork"],
        perhourrate: json["perhourrate"],
        natureofjob: json["natureofjob"],
        totalpayment: json["totalpayment"],
        employeepayment: json["employeepayment"],
      );

  Map<String, dynamic> toJson() => {
        "worker_id": workerId,
        "name": name,
        "date": date,
        "timearrival": timearrival,
        "strtime": strtime,
        "endtime": endtime,
        "hourwork": hourwork,
        "perhourrate": perhourrate,
        "natureofjob": natureofjob,
        "totalpayment": totalpayment,
        "employeepayment": employeepayment,
      };
}
