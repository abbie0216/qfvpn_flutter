// To parse this JSON data, do
//
//     final categoryListResp = categoryListRespFromJson(jsonString);

import 'dart:convert';

CategoryListResp categoryListRespFromJson(String str) => CategoryListResp.fromJson(json.decode(str));

String categoryListRespToJson(CategoryListResp data) => json.encode(data.toJson());

class CategoryListResp {
  CategoryListResp({
    required this.items,
  });

  List<Item> items;

  factory CategoryListResp.fromJson(Map<String, dynamic> json) => CategoryListResp(
    items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'items': List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.feedbackCategoryId,
    required this.name,
  });

  int feedbackCategoryId;
  String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    feedbackCategoryId: json['feedbackCategoryId'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'feedbackCategoryId': feedbackCategoryId,
    'name': name,
  };
}
