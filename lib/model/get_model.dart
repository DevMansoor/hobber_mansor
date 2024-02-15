// To parse this JSON data, do
//
//     final getModel = getModelFromJson(jsonString);

import 'dart:convert';

List<GetModel> getModelFromJson(String str) =>
    List<GetModel>.from(json.decode(str).map((x) => GetModel.fromJson(x)));

String getModelToJson(List<GetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetModel {
  int? id;
  String? title;
  String? description;
  String? imgLink;
  String? email;

  GetModel({
    this.id,
    this.title,
    this.description,
    this.imgLink,
    this.email,
  });

  factory GetModel.fromJson(Map<String, dynamic> json) => GetModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imgLink: json["img_link"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "img_link": imgLink,
        "email": email,
      };
}
