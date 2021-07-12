// To parse this JSON data, do
//
//     final feedbackUploadResp = feedbackUploadRespFromJson(jsonString);

import 'dart:convert';

UploadAttachmentResp uploadAttachmentRespFromJson(String str) => UploadAttachmentResp.fromJson(json.decode(str));

String uploadAttachmentRespToJson(UploadAttachmentResp data) => json.encode(data.toJson());

class UploadAttachmentResp {
  UploadAttachmentResp({
    required this.attachmentId,
  });

  int attachmentId;

  factory UploadAttachmentResp.fromJson(Map<String, dynamic> json) => UploadAttachmentResp(
    attachmentId: json['attachmentId'],
  );

  Map<String, dynamic> toJson() => {
    'attachmentId': attachmentId,
  };
}