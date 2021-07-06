
import 'dart:convert';

// {
// "inviteCode": "string",
// "email": "string",
// "password": "string"
// }

///run "flutter pub run build_runner build" to generate register_req.g.dart

RegisterReq registerReqFromJson(String str) => RegisterReq.fromJson(json.decode(str));

String registerReqToJson(RegisterReq data) => json.encode(data.toJson());

class RegisterReq {
  RegisterReq({
    required this.inviteCode,
    required this.email,
    required this.password,
  });

  final String inviteCode;
  final String email;
  final String password;

  factory RegisterReq.fromJson(Map<String, dynamic> json) => RegisterReq(
    inviteCode: json['inviteCode'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'inviteCode': inviteCode,
    'email': email,
    'password': password,
  };
}