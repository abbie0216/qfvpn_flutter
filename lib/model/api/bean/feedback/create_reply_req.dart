// To parse this JSON data, do
//
//     final createReplyReq = createReplyReqFromJson(jsonString);

import 'dart:convert';

CreateReplyReq createReplyReqFromJson(String str) => CreateReplyReq.fromJson(json.decode(str));

String createReplyReqToJson(CreateReplyReq data) => json.encode(data.toJson());

class CreateReplyReq {
  CreateReplyReq({
    required this.feedbackId,
    required this.content,
    required this.imageAttachmentIds,
  });

  int feedbackId;
  String content;
  List<int> imageAttachmentIds;

  factory CreateReplyReq.fromJson(Map<String, dynamic> json) => CreateReplyReq(
    feedbackId: json['feedbackId'],
    content: json['content'],
    imageAttachmentIds: List<int>.from(json['imageAttachmentIds'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'feedbackId': feedbackId,
    'content': content,
    'imageAttachmentIds': List<dynamic>.from(imageAttachmentIds.map((x) => x)),
  };
}
