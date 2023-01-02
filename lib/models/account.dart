// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    required this.id,
    required this.email,
    required this.password,
  });

  int id;
  String email;
  String password;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"] ?? 0,
        email: json["email"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "passwordHashed": password,
      };
}
