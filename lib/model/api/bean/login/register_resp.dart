import 'package:meta/meta.dart';
import 'dart:convert';

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
