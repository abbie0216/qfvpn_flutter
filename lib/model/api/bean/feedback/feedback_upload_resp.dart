// To parse this JSON data, do
//
//     final feedbackUploadResp = feedbackUploadRespFromJson(jsonString);

import 'dart:convert';

FeedbackUploadResp feedbackUploadRespFromJson(String str) => FeedbackUploadResp.fromJson(json.decode(str));

String feedbackUploadRespToJson(FeedbackUploadResp data) => json.encode(data.toJson());

class FeedbackUploadResp {
  FeedbackUploadResp({
    required this.attachmentId,
  });

  int attachmentId;

  factory FeedbackUploadResp.fromJson(Map<String, dynamic> json) => FeedbackUploadResp(
    attachmentId: json['attachmentId'],
  );

  Map<String, dynamic> toJson() => {
    'attachmentId': attachmentId,
  };
}