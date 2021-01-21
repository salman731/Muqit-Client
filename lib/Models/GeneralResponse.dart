import 'dart:convert';

GeneralResposne generalResposneFromJson(String str) =>
    GeneralResposne.fromJson(json.decode(str));

String generalResposneToJson(GeneralResposne data) =>
    json.encode(data.toJson());

class GeneralResposne {
  GeneralResposne({
    this.message,
    this.status,
  });

  String message;
  bool status;

  factory GeneralResposne.fromJson(Map<String, dynamic> json) =>
      GeneralResposne(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
