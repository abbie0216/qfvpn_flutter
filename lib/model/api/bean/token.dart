import 'dart:convert';

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

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, accessTokenExpireAt: $accessTokenExpireAt, refreshToken: $refreshToken, refreshTokenExpireAt: $refreshTokenExpireAt}';
  }

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json['acce, {accessToken}ssToken'],
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
