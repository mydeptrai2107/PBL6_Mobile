// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
    required this.status,
    this.avatar,
    required this.phoneNumber,
    required this.address,
    required this.sex,
    this.citizenId,
  });

  int userId;
  String email;
  String firstName;
  String lastName;
  dynamic role;
  int status;
  dynamic avatar;
  String phoneNumber;
  String address;
  bool sex;
  dynamic citizenId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["UserID"] ?? 0,
        email: json["Email"] ?? '',
        firstName: json["FirstName"] ?? '',
        lastName: json["LastName"] ?? '',
        role: json["Role"],
        status: json["Status"] ?? 0,
        avatar: json["Avatar"],
        phoneNumber: json["PhoneNumber"] ?? '',
        address: json["Address"] ?? '',
        sex: json["Sex"] ?? false,
        citizenId: json["CitizenID"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "Email": email,
        "FirstName": firstName,
        "LastName": lastName,
        "Role": role,
        "Status": status,
        "Avatar": avatar,
        "PhoneNumber": phoneNumber,
        "Address": address,
        "Sex": sex,
        "CitizenID": citizenId,
      };
}
