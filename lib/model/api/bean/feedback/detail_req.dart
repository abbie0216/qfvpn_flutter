// To parse this JSON data, do
//
//     final detailReq = detailReqFromJson(jsonString);

import 'dart:convert';

DetailReq detailReqFromJson(String str) => DetailReq.fromJson(json.decode(str));

String detailReqToJson(DetailReq data) => json.encode(data.toJson());

class DetailReq {
  DetailReq({
    required this.feedbackId,
  });

  int feedbackId;

  factory DetailReq.fromJson(Map<String, dynamic> json) => DetailReq(
    feedbackId: json['feedbackId'],
  );

  Map<String, dynamic> toJson() => {
    'feedbackId': feedbackId,
  };
}
