// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    login: json['login'] as String,
    id: json['id'] as int,
    nodeId: json['node_id'] as String,
    avatarUrl: json['avatar_url'] as String,
    gravatarId: json['gravatar_id'] as String,
    type: json['type'] as String,
    siteAdmin: json['site_admin'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl,
      'gravatar_id': instance.gravatarId,
      'type': instance.type,
      'site_admin': instance.siteAdmin,
    };
