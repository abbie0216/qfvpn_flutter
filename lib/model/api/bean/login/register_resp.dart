import 'package:meta/meta.dart';
import 'dart:convert';

RegisterResp registerRespFromJson(String str) => RegisterResp.fromJson(json.decode(str));

String registerRespToJson(RegisterResp data) => json.encode(data.toJson());

class RegisterResp {
  RegisterResp({
    required this.userId,
  });

  final int userId;

  factory RegisterResp.fromJson(Map<String, dynamic> json) => RegisterResp(
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
  };
}
