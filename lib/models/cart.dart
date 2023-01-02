// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productQuantityLeft,
    required this.productCount,
    required this.pricePerOne,
    required this.description,
  });

  int id;
  int userId;
  int productId;
  String productName;
  int productQuantityLeft;
  int productCount;
  double pricePerOne;
  String description;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["ID"] ?? 0,
        userId: json["UserID"] ?? 0,
        productId: json["ProductID"] ?? 0,
        productName: json["ProductName"] ?? '',
        productQuantityLeft: json["ProductQuantityLeft"] ?? 0,
        productCount: json["ProductCount"] ?? 0,
        pricePerOne: json["PricePerOne"] ?? 0,
        description: json["Description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "UserID": userId,
        "ProductID": productId,
        "ProductName": productName,
        "ProductQuantityLeft": productQuantityLeft,
        "ProductCount": productCount,
        "PricePerOne": pricePerOne,
        "Description": description,
      };
}
