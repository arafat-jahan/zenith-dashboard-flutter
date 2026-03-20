// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get text => throw _privateConstructorUsedError;
  bool get isUser => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({String text, bool isUser, DateTime timestamp, bool isError});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? isError = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            isUser: null == isUser
                ? _value.isUser
                : isUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isError: null == isError
                ? _value.isError
                : isError // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool isUser, DateTime timestamp, bool isError});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? isError = null,
  }) {
    return _then(
      _$ChatMessageImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        isUser: null == isUser
            ? _value.isUser
            : isUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isError: null == isError
            ? _value.isError
            : isError // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isError = false,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String text;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'ChatMessage(text: $text, isUser: $isUser, timestamp: $timestamp, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, text, isUser, timestamp, isError);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String text,
    required final bool isUser,
    required final DateTime timestamp,
    final bool isError,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get text;
  @override
  bool get isUser;
  @override
  DateTime get timestamp;
  @override
  bool get isError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatState _$ChatStateFromJson(Map<String, dynamic> json) {
  return _ChatState.fromJson(json);
}

/// @nodoc
mixin _$ChatState {
  List<ChatMessage> get messages => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  String get selectedModel => throw _privateConstructorUsedError;
  String get streamingText => throw _privateConstructorUsedError;
  bool get hasStreamingError => throw _privateConstructorUsedError;
  String? get lastPrompt => throw _privateConstructorUsedError;

  /// Serializes this ChatState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isTyping,
    String selectedModel,
    String streamingText,
    bool hasStreamingError,
    String? lastPrompt,
  });
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isTyping = null,
    Object? selectedModel = null,
    Object? streamingText = null,
    Object? hasStreamingError = null,
    Object? lastPrompt = freezed,
  }) {
    return _then(
      _value.copyWith(
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<ChatMessage>,
            isTyping: null == isTyping
                ? _value.isTyping
                : isTyping // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedModel: null == selectedModel
                ? _value.selectedModel
                : selectedModel // ignore: cast_nullable_to_non_nullable
                      as String,
            streamingText: null == streamingText
                ? _value.streamingText
                : streamingText // ignore: cast_nullable_to_non_nullable
                      as String,
            hasStreamingError: null == hasStreamingError
                ? _value.hasStreamingError
                : hasStreamingError // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastPrompt: freezed == lastPrompt
                ? _value.lastPrompt
                : lastPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
    _$ChatStateImpl value,
    $Res Function(_$ChatStateImpl) then,
  ) = __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isTyping,
    String selectedModel,
    String streamingText,
    bool hasStreamingError,
    String? lastPrompt,
  });
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
    _$ChatStateImpl _value,
    $Res Function(_$ChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isTyping = null,
    Object? selectedModel = null,
    Object? streamingText = null,
    Object? hasStreamingError = null,
    Object? lastPrompt = freezed,
  }) {
    return _then(
      _$ChatStateImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatMessage>,
        isTyping: null == isTyping
            ? _value.isTyping
            : isTyping // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedModel: null == selectedModel
            ? _value.selectedModel
            : selectedModel // ignore: cast_nullable_to_non_nullable
                  as String,
        streamingText: null == streamingText
            ? _value.streamingText
            : streamingText // ignore: cast_nullable_to_non_nullable
                  as String,
        hasStreamingError: null == hasStreamingError
            ? _value.hasStreamingError
            : hasStreamingError // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastPrompt: freezed == lastPrompt
            ? _value.lastPrompt
            : lastPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl({
    final List<ChatMessage> messages = const [],
    this.isTyping = false,
    this.selectedModel = 'zenith-ultra',
    this.streamingText = '',
    this.hasStreamingError = false,
    this.lastPrompt,
  }) : _messages = messages;

  factory _$ChatStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatStateImplFromJson(json);

  final List<ChatMessage> _messages;
  @override
  @JsonKey()
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isTyping;
  @override
  @JsonKey()
  final String selectedModel;
  @override
  @JsonKey()
  final String streamingText;
  @override
  @JsonKey()
  final bool hasStreamingError;
  @override
  final String? lastPrompt;

  @override
  String toString() {
    return 'ChatState(messages: $messages, isTyping: $isTyping, selectedModel: $selectedModel, streamingText: $streamingText, hasStreamingError: $hasStreamingError, lastPrompt: $lastPrompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.selectedModel, selectedModel) ||
                other.selectedModel == selectedModel) &&
            (identical(other.streamingText, streamingText) ||
                other.streamingText == streamingText) &&
            (identical(other.hasStreamingError, hasStreamingError) ||
                other.hasStreamingError == hasStreamingError) &&
            (identical(other.lastPrompt, lastPrompt) ||
                other.lastPrompt == lastPrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    isTyping,
    selectedModel,
    streamingText,
    hasStreamingError,
    lastPrompt,
  );

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatStateImplToJson(this);
  }
}

abstract class _ChatState implements ChatState {
  const factory _ChatState({
    final List<ChatMessage> messages,
    final bool isTyping,
    final String selectedModel,
    final String streamingText,
    final bool hasStreamingError,
    final String? lastPrompt,
  }) = _$ChatStateImpl;

  factory _ChatState.fromJson(Map<String, dynamic> json) =
      _$ChatStateImpl.fromJson;

  @override
  List<ChatMessage> get messages;
  @override
  bool get isTyping;
  @override
  String get selectedModel;
  @override
  String get streamingText;
  @override
  bool get hasStreamingError;
  @override
  String? get lastPrompt;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
