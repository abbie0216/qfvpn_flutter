// To parse this JSON data, do
//
//     final paging = pagingFromJson(jsonString);

import 'dart:convert';

Paging pagingFromJson(String str) => Paging.fromJson(json.decode(str));

String pagingToJson(Paging data) => json.encode(data.toJson());

class Paging {
  Paging({
    required this.pageNo,
    required this.pageSize,
  });

  int pageNo;
  int pageSize;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    pageNo: json['pageNo'],
    pageSize: json['pageSize'],
  );

  Map<String, dynamic> toJson() => {
    'pageNo': pageNo,
    'pageSize': pageSize,
  };
}
