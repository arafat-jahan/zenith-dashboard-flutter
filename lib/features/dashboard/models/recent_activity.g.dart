// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecentActivityImpl _$$RecentActivityImplFromJson(Map<String, dynamic> json) =>
    _$RecentActivityImpl(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      time: json['time'] as String,
      iconName: json['iconName'] as String?,
      colorHex: json['colorHex'] as String?,
    );

Map<String, dynamic> _$$RecentActivityImplToJson(
  _$RecentActivityImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'time': instance.time,
  'iconName': instance.iconName,
  'colorHex': instance.colorHex,
};
