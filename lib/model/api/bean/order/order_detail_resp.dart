// To parse this JSON data, do
//
//     final orderDetailResp = orderDetailRespFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderDetailResp orderDetailRespFromJson(String str) => OrderDetailResp.fromJson(json.decode(str));

String orderDetailRespToJson(OrderDetailResp data) => json.encode(data.toJson());

class OrderDetailResp {
  OrderDetailResp({
    required this.orderNo,
    required this.productId,
    required this.productName,
    required this.userCouponId,
    required this.couponName,
    required this.amount,
    required this.discountAmount,
    required this.couponAmount,
    required this.actualAmount,
    required this.paymentName,
    required this.paymentCode,
    required this.payAt,
    required this.createdAt,
    required this.status,
    required this.statusLabel,
    required this.availablePayments,
    required this.expireAt,
    required this.actualPaidAmount
  });

  String orderNo;
  int productId;
  String productName;
  int userCouponId;
  String couponName;
  String amount;
  int discountAmount;
  int couponAmount;
  String actualAmount;
  String paymentName;
  String paymentCode;
  DateTime payAt;
  DateTime createdAt;
  int status;
  String statusLabel;
  List<AvailablePayment> availablePayments;
  DateTime expireAt;
  String actualPaidAmount;

  factory OrderDetailResp.fromJson(Map<String, dynamic> json) => OrderDetailResp(
    orderNo: json['orderNo'],
    productId: json['productId'],
    productName: json['productName'],
    userCouponId: json['userCouponId'],
    couponName: json['couponName'],
    amount: json['amount'],
    discountAmount: json['discountAmount'],
    couponAmount: json['couponAmount'],
    actualAmount: json['actualAmount'],
    paymentName: json['paymentName'],
    paymentCode: json['paymentCode'],
    payAt: DateTime.parse(json['payAt']),
    createdAt: DateTime.parse(json['createdAt']),
    status: json['status'],
    statusLabel: json['statusLabel'],
    availablePayments: List<AvailablePayment>.from(json['availablePayments'].map((x) => AvailablePayment.fromJson(x))),
    expireAt: DateTime.parse(json['expireAt']),
    actualPaidAmount: json['actualPaidAmount'],
  );

  Map<String, dynamic> toJson() => {
    'orderNo': orderNo,
    'productId': productId,
    'productName': productName,
    'userCouponId': userCouponId,
    'couponName': couponName,
    'amount': amount,
    'discountAmount': discountAmount,
    'couponAmount': couponAmount,
    'actualAmount': actualAmount,
    'paymentName': paymentName,
    'paymentCode': paymentCode,
    'payAt': payAt.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'status': status,
    'statusLabel': statusLabel,
    'availablePayments': List<dynamic>.from(availablePayments.map((x) => x.toJson())),
    'expireAt': expireAt.toIso8601String(),
    'actualPaidAmount': actualPaidAmount,
  };
}

class AvailablePayment {
  AvailablePayment({
    required this.name,
    required this.code,
    required this.description,
    required this.iconUrl,
  });

  String name;
  String code;
  String description;
  String iconUrl;

  factory AvailablePayment.fromJson(Map<String, dynamic> json) => AvailablePayment(
    name: json['name'],
    code: json['code'],
    description: json['description'],
    iconUrl: json['iconUrl'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'description': description,
    'iconUrl': iconUrl,
  };
}
