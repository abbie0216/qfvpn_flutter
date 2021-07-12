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
  List<Attachment> images;
  List<Reply> replies;
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
    images: List<Attachment>.from(json['images'].map((x) => Attachment.fromJson(x))),
    replies: List<Reply>.from(json['replies'].map((x) => Reply.fromJson(x))),
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
    'replies': List<dynamic>.from(replies.map((x) => x.toJson())),
    'isCanReply': isCanReply,
    'isCanSurvey': isCanSurvey,
  };
}

class Attachment {
  Attachment({
    required this.attachmentId,
    required this.url,
  });

  int attachmentId;
  String url;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachmentId: json['attachmentId'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'attachmentId': attachmentId,
    'url': url,
  };
}


class Reply {
  Reply({
    required this.feedbackReplyId,
    required this.content,
    required this.createdAt,
    required this.opName,
    required this.opProfileImage,
    required this.type,
    required this.attachments,
  });

  int feedbackReplyId;
  String content;
  DateTime createdAt;
  String opName;
  String opProfileImage;
  int type;
  List<Attachment> attachments;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    feedbackReplyId: json['feedbackReplyId'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    opName: json['opName'],
    opProfileImage: json['opProfileImage'],
    type: json['type'],
    attachments: List<Attachment>.from(json['attachments'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'feedbackReplyId': feedbackReplyId,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'opName': opName,
    'opProfileImage': opProfileImage,
    'type': type,
    'attachments': List<dynamic>.from(attachments.map((x) => x)),
  };
}
