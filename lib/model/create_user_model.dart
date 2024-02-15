// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';

List<CreateUser> createUserFromJson(String str) => List<CreateUser>.from(json.decode(str).map((x) => CreateUser.fromJson(x)));

String createUserToJson(List<CreateUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateUser {
  String? message;

  CreateUser({
    this.message,
  });

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
