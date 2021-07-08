// To parse this JSON data, do
//
//     final versionReq = versionReqFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class VersionReq {
  VersionReq({
    required this.platform,
  });

  String platform;

  VersionReq copyWith({
    required String platform,
  }) =>
      VersionReq(
        platform: platform,
      );

  factory VersionReq.fromJson(String str) => VersionReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionReq.fromMap(Map<String, dynamic> json) => VersionReq(
    platform: json['platform'],
  );

  Map<String, dynamic> toMap() => {
    'platform': platform,
  };
}
