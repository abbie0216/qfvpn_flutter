import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.accessToken,
    required this.accessTokenExpireAt,
    required this.refreshToken,
    required this.refreshTokenExpireAt,
  });

  final String accessToken;
  final String accessTokenExpireAt;
  final String refreshToken;
  final String refreshTokenExpireAt;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json['accessToken'],
    accessTokenExpireAt: json['accessTokenExpireAt'],
    refreshToken: json['refreshToken'],
    refreshTokenExpireAt: json['refreshTokenExpireAt'],
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'accessTokenExpireAt': accessTokenExpireAt,
    'refreshToken': refreshToken,
    'refreshTokenExpireAt': refreshTokenExpireAt,
  };
}
