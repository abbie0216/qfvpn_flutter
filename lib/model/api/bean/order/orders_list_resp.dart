// To parse this JSON data, do
//
//     final ordersList = ordersListFromJson(jsonString);

import 'dart:convert';

OrdersListResp ordersListFromJson(String str) => OrdersListResp.fromJson(json.decode(str));

String ordersListToJson(OrdersListResp data) => json.encode(data.toJson());

class OrdersListResp {
  OrdersListResp({
    required this.totalCount,
    required this.pageSize,
    required this.pageNo,
    required this.totalPage,
    required this.items,
  });

  int totalCount;
  int pageSize;
  int pageNo;
  int totalPage;
  List<OrderItem> items;

  factory OrdersListResp.fromJson(Map<String, dynamic> json) => OrdersListResp(
    totalCount: json['totalCount'],
    pageSize: json['pageSize'],
    pageNo: json['pageNo'],
    totalPage: json['totalPage'],
    items: List<OrderItem>.from(json['items'].map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'totalCount': totalCount,
    'pageSize': pageSize,
    'pageNo': pageNo,
    'totalPage': totalPage,
    'items': List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class OrderItem {
  OrderItem({
    required this.productName,
    required this.orderNo,
    required this.status,
    required this.statusLabel,
    required this.createdAt,
  });

  String productName;
  String orderNo;
  int status;
  String statusLabel;
  DateTime createdAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productName: json['productName'],
    orderNo: json['orderNo'],
    status: json['status'],
    statusLabel: json['statusLabel'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'productName': productName,
    'orderNo': orderNo,
    'status': status,
    'statusLabel': statusLabel,
    'createdAt': createdAt.toIso8601String(),
  };
}
