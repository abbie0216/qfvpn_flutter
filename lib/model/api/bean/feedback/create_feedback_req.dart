// To parse this JSON data, do
//
//     final addFeedbackReq = addFeedbackReqFromJson(jsonString);

import 'dart:convert';

CreateFeedbackReq createFeedbackReqFromJson(String str) => CreateFeedbackReq.fromJson(json.decode(str));

String createFeedbackReqToJson(CreateFeedbackReq data) => json.encode(data.toJson());

class CreateFeedbackReq {
  CreateFeedbackReq({
    required this.content,
    required this.categoryId,
    required this.imageAttachmentIds,
  });

  String content;
  int categoryId;
  List<int> imageAttachmentIds;

  factory CreateFeedbackReq.fromJson(Map<String, dynamic> json) => CreateFeedbackReq(
    content: json['content'],
    categoryId: json['categoryId'],
    imageAttachmentIds: List<int>.from(json['imageAttachmentIds'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'content': content,
    'categoryId': categoryId,
    'imageAttachmentIds': List<dynamic>.from(imageAttachmentIds.map((x) => x)),
  };
}
