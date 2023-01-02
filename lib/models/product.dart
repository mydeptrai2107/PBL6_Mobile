// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.description,
    required this.count,
    required this.pricePerOne,
    required this.status,
    required this.numberOfImgs,
    required this.createAt,
    required this.createBy,
    required this.soldQuantity,
    this.htmlDescription,
    this.markdownDescription,
  });

  int id;
  int categoryId;
  String productName;
  String description;
  int count;
  double pricePerOne;
  int status;
  int numberOfImgs;
  DateTime createAt;
  int createBy;
  int soldQuantity;
  dynamic htmlDescription;
  dynamic markdownDescription;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["ID"] ?? 0,
        categoryId: json["CategoryID"],
        productName: json["ProductName"] ?? "",
        description: json["Description"] ?? "",
        count: json["Count"] ?? 0,
        pricePerOne: json["PricePerOne"] ?? 0,
        status: json["Status"] ?? 0,
        numberOfImgs: json["NumberOfImgs"] ?? 0,
        createAt: DateTime.parse(json["CreateAt"]),
        createBy: json["CreateBy"],
        soldQuantity: json["SoldQuantity"] ?? 0,
        htmlDescription: json["HtmlDescription"] ?? "",
        markdownDescription: json["MarkdownDescription"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CategoryID": categoryId,
        "ProductName": productName,
        "Description": description,
        "Count": count,
        "PricePerOne": pricePerOne,
        "Status": status,
        "NumberOfImgs": numberOfImgs,
        "CreateAt": createAt.toIso8601String(),
        "CreateBy": createBy,
        "SoldQuantity": soldQuantity,
        "HtmlDescription": htmlDescription,
        "MarkdownDescription": markdownDescription,
      };
}
