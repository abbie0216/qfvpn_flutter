// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReq _$LoginReqFromJson(Map<String, dynamic> json) {
  return LoginReq(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginReqToJson(LoginReq instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
