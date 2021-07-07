// To parse this JSON data, do
//
//     final versionResp = versionRespFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class VersionResp extends Equatable {
  VersionResp({
    required this.versionCode,
    required this.versionName,
    required this.isForce,
    required this.downloadUrl,
    required this.releaseNote,
  });

  int versionCode;
  String versionName;
  bool isForce;
  String downloadUrl;
  String releaseNote;

  VersionResp copyWith({
    required int versionCode,
    required String versionName,
    required bool isForce,
    required String downloadUrl,
    required String releaseNote,
  }) =>
      VersionResp(
        versionCode: versionCode,
        versionName: versionName,
        isForce: isForce,
        downloadUrl: downloadUrl,
        releaseNote: releaseNote,
      );

  factory VersionResp.fromJson(String str) => VersionResp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionResp.fromMap(Map<String, dynamic> json) => VersionResp(
    versionCode: json['versionCode'],
    versionName: json['versionName'],
    isForce: json['isForce'],
    downloadUrl: json['downloadUrl'],
    releaseNote: json['releaseNote'],
  );

  Map<String, dynamic> toMap() => {
    'versionCode': versionCode,
    'versionName': versionName,
    'isForce': isForce,
    'downloadUrl': downloadUrl,
    'releaseNote': releaseNote,
  };

  @override
  List<Object?> get props => [versionCode, versionName, isForce, downloadUrl, releaseNote];
}
