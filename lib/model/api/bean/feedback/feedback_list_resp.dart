// To parse this JSON data, do
//
//     final feedbackListResp = feedbackListRespFromJson(jsonString);

import 'dart:convert';

FeedbackListResp feedbackListRespFromJson(String str) => FeedbackListResp.fromJson(json.decode(str));

String feedbackListRespToJson(FeedbackListResp data) => json.encode(data.toJson());

class FeedbackListResp {
  FeedbackListResp({
    this.totalCount,
    required this.items,
  });

  int? totalCount;
  List<FeedbackItem> items;

  factory FeedbackListResp.fromJson(Map<String, dynamic> json) => FeedbackListResp(
    totalCount: json['totalCount'],
    items: List<FeedbackItem>.from(json['items'].map((x) => FeedbackItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'totalCount': totalCount,
    'items': List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class FeedbackItem {
  FeedbackItem({
    required this.feedbackId,
    required this.content,
    required this.createdAt,
    required this.status,
    required this.lastReplyContent,
    required this.lastReplyType,
    required this.feedbackCategoryId,
    required this.feedbackCategoryName,
});

  int feedbackId;
  String content;
  DateTime createdAt;
  int status;
  String lastReplyContent;
  int lastReplyType;
  int feedbackCategoryId;
  String feedbackCategoryName;

  factory FeedbackItem.fromJson(Map<String, dynamic> json) => FeedbackItem(
    feedbackId: json['feedbackId'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    status: json['status'],
    lastReplyContent: json['lastReplyContent'],
    lastReplyType: json['lastReplyType'],
    feedbackCategoryId: json['feedbackCategoryId'],
    feedbackCategoryName: json['feedbackCategoryName'],
  );

  Map<String, dynamic> toJson() => {
    'feedbackId': feedbackId,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
    'lastReplyContent': lastReplyContent,
    'lastReplyType': lastReplyType,
    'feedbackCategoryId': feedbackCategoryId,
    'feedbackCategoryName': feedbackCategoryName,
  };
}
