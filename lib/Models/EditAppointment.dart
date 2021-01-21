// To parse this JSON data, do
//
//     final editAppointmentModel = editAppointmentModelFromJson(jsonString);

import 'dart:convert';

List<EditAppointmentModel> editAppointmentModelFromJson(String str) =>
    List<EditAppointmentModel>.from(
        json.decode(str).map((x) => EditAppointmentModel.fromJson(x)));

String editAppointmentModelToJson(List<EditAppointmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditAppointmentModel {
  EditAppointmentModel({
    this.id,
    this.jobRateOffered,
    this.workaddress,
    this.description,
    this.worktype,
    this.fixdate,
  });

  String id;
  String jobRateOffered;
  String workaddress;
  String description;
  String worktype;
  String fixdate;

  factory EditAppointmentModel.fromJson(Map<String, dynamic> json) =>
      EditAppointmentModel(
        id: json["id"],
        jobRateOffered: json["jobRateOffered"],
        workaddress: json["workaddress"],
        description: json["description"],
        worktype: json["worktype"],
        fixdate: json["fixdate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobRateOffered": jobRateOffered,
        "workaddress": workaddress,
        "description": description,
        "worktype": worktype,
        "fixdate": fixdate,
      };
}
