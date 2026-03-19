// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiCredentialImpl _$$ApiCredentialImplFromJson(Map<String, dynamic> json) =>
    _$ApiCredentialImpl(
      name: json['name'] as String,
      key: json['key'] as String,
      created: json['created'] as String,
      lastUsed: json['lastUsed'] as String,
      isActive: json['isActive'] as bool,
      colorHex: json['colorHex'] as String?,
    );

Map<String, dynamic> _$$ApiCredentialImplToJson(_$ApiCredentialImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'key': instance.key,
      'created': instance.created,
      'lastUsed': instance.lastUsed,
      'isActive': instance.isActive,
      'colorHex': instance.colorHex,
    };
