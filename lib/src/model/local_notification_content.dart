//// To parse this JSON data, do
////
////     final messageOnlyResponse = messageOnlyResponseFromJson(jsonString);
//
//import 'dart:convert';
//
////MessageOnlyResponse messageOnlyResponseFromJson(String str) => MessageOnlyResponse.fromJson(json.decode(str));
////
////String messageOnlyResponseToJson(MessageOnlyResponse data) => json.encode(data.toJson());
////id INTEGER PRIMARY KEY, image TEXT, content TEXT, time TEXT
//class LocalNotificationContent {
//  final int id;
//  final String image;
//  final String content;
//  final String time;
//
//  LocalNotificationContent(
//      {this.id,
//      this.image,
//      this.content,
//      this.time, });
//
//  factory LocalNotificationContent.fromSavedJson(Map<String, dynamic> json) =>
//      LocalNotificationContent(
//         id: json["id"] == null ? '' : json["id"],
//        image:
//            json["image"] == null ? '' : json["image"],
//        content: json["content"] == null ? '' : json["content"],
//        time: json["time"] == null ? '' : json["time"],
//        );
//
//  Map<String, dynamic> toLocalSaveJson() => {
//         "id": id == null ? '' : id,
//        "image": image == null ? '' : image,
//        "content": content == null ? '' : content,
//        "time": time == null ? '' : time,
//      };
//
//  factory LocalNotificationContent.fromServerJson(Map<String, dynamic> json) =>
//      LocalNotificationContent(
//        header: json["header"] == null ? '' : json["header"],
//        id: json["_id"] == null ? '' : json["_id"],
//        notificationId:
//            json["notification_id"] == null ? '' : json["notification_id"],
//        content: json["content"] == null ? '' : json["content"],
//        bigPicture: json["bigPicture"] == null ? '' : json["bigPicture"],
//        smallPicture: json["smallPicture"] == null ? '' : json["smallPicture"],
//        priority: json["priority"] == null ? '' : json["priority"],
//        receivedTime: json["receivedTime"] == null ? '' : json["receivedTime"],
//      );
//
//  Map<String, dynamic> toParentJson() => {
//        "header": header == null ? '' : header,
//        "notification_id": notificationId == null ? '' : notificationId,
//        "content": content == null ? '' : content,
//        "priority": priority == null ? '' : priority,
//        "bigPicture": bigPicture == null ? '' : bigPicture,
//        "smallPicture": smallPicture == null ? '' : smallPicture,
//        "user": user == null ? '' : user,
//        "receivedTime": receivedTime == null ? '' : receivedTime
//      };
//
//  Map<String, dynamic> toChildJson() => {
//        "header": header == null ? '' : header,
//        "notification_id": notificationId == null ? '' : notificationId,
//        "content": content == null ? '' : content,
//        "priority": priority == null ? '' : priority,
//        "bigPicture": bigPicture == null ? '' : bigPicture,
//        "smallPicture": smallPicture == null ? '' : smallPicture,
//        "child": user == null ? '' : user,
//        "receivedTime": receivedTime == null ? '' : receivedTime
//      };
//}
