// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  final String? docId;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  UserModel({
    this.docId,
    this.name,
    this.phone,
    this.address,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json["docID"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
    email: json["email"],
      );

  Map<String, dynamic> toJson(String userID) => {
        "docID": userID,
        "name": name,
        "phone": phone,
        "address": address,
        "email": email,
      };
}
