// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResp _$LoginRespFromJson(Map<String, dynamic> json) {
  return LoginResp(
    json['accessToken'] as String,
    json['accessTokenExpireAt'] as String,
    json['refreshToken'] as String,
    json['refreshTokenExpireAt'] as String,
  );
}

Map<String, dynamic> _$LoginRespToJson(LoginResp instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessTokenExpireAt': instance.accessTokenExpireAt,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireAt': instance.refreshTokenExpireAt,
    };
