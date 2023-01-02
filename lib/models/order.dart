// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.numberOfProducts,
    required this.address,
    required this.status,
    required this.createAt,
    required this.createBy,
    required this.shippingFee,
  });

  int id;
  int numberOfProducts;
  String address;
  int status;
  DateTime createAt;
  int createBy;
  double shippingFee;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["ID"] ?? -1,
        numberOfProducts: json["NumberOfProducts"] ?? -1,
        address: json["Address"] ?? '',
        status: json["Status"] ?? -1,
        createAt: DateTime.parse(json["CreateAt"]),
        createBy: json["CreateBy"] ?? -1,
        shippingFee: json["ShippingFee"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NumberOfProducts": numberOfProducts,
        "Address": address,
        "Status": status,
        "CreateAt": createAt.toIso8601String(),
        "CreateBy": createBy,
        "ShippingFee": shippingFee,
      };
}
