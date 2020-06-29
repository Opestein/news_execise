// To parse this JSON data, do
//
//     final messageOnlyResponse = messageOnlyResponseFromJson(jsonString);

import 'dart:convert';

//MessageOnlyResponse messageOnlyResponseFromJson(String str) => MessageOnlyResponse.fromJson(json.decode(str));
//
//String messageOnlyResponseToJson(MessageOnlyResponse data) => json.encode(data.toJson());

class MessageOnlyResponse {
  final bool success;
  final int code;
  final String message;

  MessageOnlyResponse({
    this.success,
    this.code,
    this.message,
  });

  factory MessageOnlyResponse.fromJson(Map<String, dynamic> json) =>
      MessageOnlyResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
      };
}
