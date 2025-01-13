// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final String? image;
  final String? userID;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.userID,
    this.image,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        image: json["image"],
        createdAt: json["createdAt"],
        userID: json["userID"],
      );

  Map<String, dynamic> toJson(String taskID) => {
        "docID": taskID,
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "image": image,
        "createdAt": createdAt,
        "userID": userID,
      };
}
