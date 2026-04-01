// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isError: json['isError'] as bool? ?? false,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isUser': instance.isUser,
      'timestamp': instance.timestamp.toIso8601String(),
      'isError': instance.isError,
    };

_$ChatStateImpl _$$ChatStateImplFromJson(Map<String, dynamic> json) =>
    _$ChatStateImpl(
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isTyping: json['isTyping'] as bool? ?? false,
      selectedModel: json['selectedModel'] as String? ?? 'zenith-ultra',
      streamingText: json['streamingText'] as String? ?? '',
      hasStreamingError: json['hasStreamingError'] as bool? ?? false,
      lastPrompt: json['lastPrompt'] as String?,
      showPaywall: json['showPaywall'] as bool? ?? false,
      paywallMessage: json['paywallMessage'] as String? ?? '',
    );

Map<String, dynamic> _$$ChatStateImplToJson(_$ChatStateImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'isTyping': instance.isTyping,
      'selectedModel': instance.selectedModel,
      'streamingText': instance.streamingText,
      'hasStreamingError': instance.hasStreamingError,
      'lastPrompt': instance.lastPrompt,
      'showPaywall': instance.showPaywall,
      'paywallMessage': instance.paywallMessage,
    };
