// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  title: json['title'] as String,
  body: json['body'] as String,
  time: json['time'] as String,
  category: json['category'] as String,
  isRead: json['isRead'] as bool? ?? false,
  iconName: json['iconName'] as String?,
  colorHex: json['colorHex'] as String?,
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'time': instance.time,
  'category': instance.category,
  'isRead': instance.isRead,
  'iconName': instance.iconName,
  'colorHex': instance.colorHex,
};
