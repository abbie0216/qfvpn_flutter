// To parse this JSON data, do
//
//     final detailResp = detailRespFromJson(jsonString);

import 'dart:convert';

DetailResp detailRespFromJson(String str) => DetailResp.fromJson(json.decode(str));

String detailRespToJson(DetailResp data) => json.encode(data.toJson());

class DetailResp {
  DetailResp({
    required this.feedbackId,
    required this.content,
    required this.categoryName,
    required this.status,
    required this.statusText,
    required this.surveyScore,
    required this.createdAt,
    required this.images,
    required this.replies,
    required this.isCanReply,
    required this.isCanSurvey,
  });

  int feedbackId;
  String content;
  String categoryName;
  String status;
  String statusText;
  int surveyScore;
  DateTime createdAt;
  List<dynamic> images;
  List<dynamic> replies;
  bool isCanReply;
  bool isCanSurvey;

  factory DetailResp.fromJson(Map<String, dynamic> json) => DetailResp(
    feedbackId: json['feedbackId'],
    content: json['content'],
    categoryName: json['categoryName'],
    status: json['status'],
    statusText: json['statusText'],
    surveyScore: json['surveyScore'],
    createdAt: DateTime.parse(json['createdAt']),
    images: List<dynamic>.from(json['images'].map((x) => x)),
    replies: List<dynamic>.from(json['replies'].map((x) => x)),
    isCanReply: json['isCanReply'],
    isCanSurvey: json['isCanSurvey'],
  );

  Map<String, dynamic> toJson() => {
    'feedbackId': feedbackId,
    'content': content,
    'categoryName': categoryName,
    'status': status,
    'statusText': statusText,
    'surveyScore': surveyScore,
    'createdAt': createdAt.toIso8601String(),
    'images': List<dynamic>.from(images.map((x) => x)),
    'replies': List<dynamic>.from(replies.map((x) => x)),
    'isCanReply': isCanReply,
    'isCanSurvey': isCanSurvey,
  };
}
