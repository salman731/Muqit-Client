// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    this.chatMessageId,
    this.toUserId,
    this.fromUserId,
    this.chatMessage,
    this.timestamp,
  });

  String chatMessageId;
  String toUserId;
  String fromUserId;
  String chatMessage;
  DateTime timestamp;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        chatMessageId: json["chat_message_id"],
        toUserId: json["to_user_id"],
        fromUserId: json["from_user_id"],
        chatMessage: json["chat_message"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "chat_message_id": chatMessageId,
        "to_user_id": toUserId,
        "from_user_id": fromUserId,
        "chat_message": chatMessage,
        "timestamp": timestamp.toIso8601String(),
      };
}
