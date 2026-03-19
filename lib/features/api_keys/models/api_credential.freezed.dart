// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiCredential _$ApiCredentialFromJson(Map<String, dynamic> json) {
  return _ApiCredential.fromJson(json);
}

/// @nodoc
mixin _$ApiCredential {
  String get name => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  String get lastUsed => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  String? get colorHex => throw _privateConstructorUsedError;

  /// Serializes this ApiCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiCredentialCopyWith<ApiCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiCredentialCopyWith<$Res> {
  factory $ApiCredentialCopyWith(
    ApiCredential value,
    $Res Function(ApiCredential) then,
  ) = _$ApiCredentialCopyWithImpl<$Res, ApiCredential>;
  @useResult
  $Res call({
    String name,
    String key,
    String created,
    String lastUsed,
    bool isActive,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    String? colorHex,
  });
}

/// @nodoc
class _$ApiCredentialCopyWithImpl<$Res, $Val extends ApiCredential>
    implements $ApiCredentialCopyWith<$Res> {
  _$ApiCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? created = null,
    Object? lastUsed = null,
    Object? isActive = null,
    Object? color = freezed,
    Object? colorHex = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            created: null == created
                ? _value.created
                : created // ignore: cast_nullable_to_non_nullable
                      as String,
            lastUsed: null == lastUsed
                ? _value.lastUsed
                : lastUsed // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as Color?,
            colorHex: freezed == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiCredentialImplCopyWith<$Res>
    implements $ApiCredentialCopyWith<$Res> {
  factory _$$ApiCredentialImplCopyWith(
    _$ApiCredentialImpl value,
    $Res Function(_$ApiCredentialImpl) then,
  ) = __$$ApiCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String key,
    String created,
    String lastUsed,
    bool isActive,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    String? colorHex,
  });
}

/// @nodoc
class __$$ApiCredentialImplCopyWithImpl<$Res>
    extends _$ApiCredentialCopyWithImpl<$Res, _$ApiCredentialImpl>
    implements _$$ApiCredentialImplCopyWith<$Res> {
  __$$ApiCredentialImplCopyWithImpl(
    _$ApiCredentialImpl _value,
    $Res Function(_$ApiCredentialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? created = null,
    Object? lastUsed = null,
    Object? isActive = null,
    Object? color = freezed,
    Object? colorHex = freezed,
  }) {
    return _then(
      _$ApiCredentialImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        created: null == created
            ? _value.created
            : created // ignore: cast_nullable_to_non_nullable
                  as String,
        lastUsed: null == lastUsed
            ? _value.lastUsed
            : lastUsed // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as Color?,
        colorHex: freezed == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiCredentialImpl implements _ApiCredential {
  const _$ApiCredentialImpl({
    required this.name,
    required this.key,
    required this.created,
    required this.lastUsed,
    required this.isActive,
    @JsonKey(includeFromJson: false, includeToJson: false) this.color,
    this.colorHex,
  });

  factory _$ApiCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiCredentialImplFromJson(json);

  @override
  final String name;
  @override
  final String key;
  @override
  final String created;
  @override
  final String lastUsed;
  @override
  final bool isActive;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  @override
  final String? colorHex;

  @override
  String toString() {
    return 'ApiCredential(name: $name, key: $key, created: $created, lastUsed: $lastUsed, isActive: $isActive, color: $color, colorHex: $colorHex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiCredentialImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    key,
    created,
    lastUsed,
    isActive,
    color,
    colorHex,
  );

  /// Create a copy of ApiCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiCredentialImplCopyWith<_$ApiCredentialImpl> get copyWith =>
      __$$ApiCredentialImplCopyWithImpl<_$ApiCredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiCredentialImplToJson(this);
  }
}

abstract class _ApiCredential implements ApiCredential {
  const factory _ApiCredential({
    required final String name,
    required final String key,
    required final String created,
    required final String lastUsed,
    required final bool isActive,
    @JsonKey(includeFromJson: false, includeToJson: false) final Color? color,
    final String? colorHex,
  }) = _$ApiCredentialImpl;

  factory _ApiCredential.fromJson(Map<String, dynamic> json) =
      _$ApiCredentialImpl.fromJson;

  @override
  String get name;
  @override
  String get key;
  @override
  String get created;
  @override
  String get lastUsed;
  @override
  bool get isActive;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  String? get colorHex;

  /// Create a copy of ApiCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiCredentialImplCopyWith<_$ApiCredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
