// To parse this JSON data, do
//
//     final orderDetailReq = orderDetailReqFromJson(jsonString);

import 'dart:convert';

OrderDetailReq orderDetailReqFromJson(String str) => OrderDetailReq.fromJson(json.decode(str));

String orderDetailReqToJson(OrderDetailReq data) => json.encode(data.toJson());

class OrderDetailReq {
  OrderDetailReq({
    required this.orderNo,
  });

  String orderNo;

  factory OrderDetailReq.fromJson(Map<String, dynamic> json) => OrderDetailReq(
    orderNo: json['orderNo'],
  );

  Map<String, dynamic> toJson() => {
    'orderNo': orderNo,
  };
}
