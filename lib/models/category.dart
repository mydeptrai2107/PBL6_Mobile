// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.imgUrl,
    required this.status,
  });

  int id;
  String categoryName;
  String imgUrl;
  int status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["ID"] ?? -1,
        categoryName: json["CategoryName"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
        status: json["Status"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CategoryName": categoryName,
        "imgUrl": imgUrl,
        "Status": status,
      };
}
