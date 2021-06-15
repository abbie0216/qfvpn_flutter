// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResp<T> _$BaseRespFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseResp<T>(
    json['errCode'] as String,
    json['errMsg'] as String,
    fromJsonT(json['data']),
  );
}

Map<String, dynamic> _$BaseRespToJson<T>(
  BaseResp<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'errCode': instance.errCode,
      'errMsg': instance.errMsg,
      'data': toJsonT(instance.data),
    };
