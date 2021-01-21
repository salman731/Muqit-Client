import 'dart:convert';

List<ChatMessage> chatMessageFromJson(String str) => List<ChatMessage>.from(
    json.decode(str).map((x) => ChatMessage.fromJson(x)));

String chatMessageToJson(List<ChatMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessage {
  ChatMessage({
    this.chatmessage,
    this.timestamp,
  });

  String chatmessage;
  DateTime timestamp;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        chatmessage: json["chatmessage"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "chatmessage": chatmessage,
        "timestamp": timestamp.toIso8601String(),
      };
}
