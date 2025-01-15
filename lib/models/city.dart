// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

class CityModel {
  final String? docId;
  final String? name;
  final String? countryId;
  final int? createdAt;

  CityModel({
    this.docId,
    this.name,
    this.countryId,
    this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        docId: json["docID"],
        name: json["name"],
        countryId: json["countryID"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docID": docID,
        "name": name,
        "countryID": countryId,
        "createdAt": createdAt,
      };
}
