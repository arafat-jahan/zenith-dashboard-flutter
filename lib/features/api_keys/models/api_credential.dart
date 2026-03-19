import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'api_credential.freezed.dart';
part 'api_credential.g.dart';

@freezed
class ApiCredential with _$ApiCredential {
  const factory ApiCredential({
    required String name,
    required String key,
    required String created,
    required String lastUsed,
    required bool isActive,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    String? colorHex,
  }) = _ApiCredential;

  factory ApiCredential.fromJson(Map<String, dynamic> json) => _$ApiCredentialFromJson(json);
}
