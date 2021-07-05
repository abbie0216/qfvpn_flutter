// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['accessToken'] as String,
    json['accessTokenExpireAt'] as String,
    json['refreshToken'] as String,
    json['refreshTokenExpireAt'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessTokenExpireAt': instance.accessTokenExpireAt,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireAt': instance.refreshTokenExpireAt,
    };
