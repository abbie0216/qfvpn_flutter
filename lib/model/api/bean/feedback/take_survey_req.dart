// To parse this JSON data, do
//
//     final takeSurveyReq = takeSurveyReqFromJson(jsonString);

import 'dart:convert';

TakeSurveyReq takeSurveyReqFromJson(String str) => TakeSurveyReq.fromJson(json.decode(str));

String takeSurveyReqToJson(TakeSurveyReq data) => json.encode(data.toJson());

class TakeSurveyReq {
  TakeSurveyReq({
    required this.feedbackId,
    required this.voteNumber,
  });

  int feedbackId;
  int voteNumber;

  factory TakeSurveyReq.fromJson(Map<String, dynamic> json) => TakeSurveyReq(
    feedbackId: json['feedbackId'],
    voteNumber: json['voteNumber'],
  );

  Map<String, dynamic> toJson() => {
    'feedbackId': feedbackId,
    'voteNumber': voteNumber,
  };
}
