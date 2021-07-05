// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterReq _$RegisterReqFromJson(Map<String, dynamic> json) {
  return RegisterReq(
    json['email'] as String,
    json['password'] as String,
    json['inviteCode'] as String,
  );
}

Map<String, dynamic> _$RegisterReqToJson(RegisterReq instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'inviteCode': instance.inviteCode,
    };
