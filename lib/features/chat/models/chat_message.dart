// lib/features/chat/models/chat_message.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String text,
    required bool isUser,
    required DateTime timestamp,
    @Default(false) bool isError,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isTyping,
    @Default('zenith-ultra') String selectedModel,
    @Default('') String streamingText,
    @Default(false) bool hasStreamingError,
    String? lastPrompt,
    @Default(false) bool showPaywall,
    @Default('') String paywallMessage,
  }) = _ChatState;

  factory ChatState.fromJson(Map<String, dynamic> json) => _$ChatStateFromJson(json);
}
