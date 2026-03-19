import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'recent_activity.freezed.dart';
part 'recent_activity.g.dart';

@freezed
class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String title,
    required String subtitle,
    required String time,
    @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    String? iconName,
    String? colorHex,
  }) = _RecentActivity;

  factory RecentActivity.fromJson(Map<String, dynamic> json) => _$RecentActivityFromJson(json);
}
