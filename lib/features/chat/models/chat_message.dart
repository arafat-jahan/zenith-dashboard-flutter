// lib/features/chat/models/chat_message.dart
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final String selectedModel;

  ChatState({
    required this.messages,
    required this.isTyping,
    required this.selectedModel,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    String? selectedModel,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      selectedModel: selectedModel ?? this.selectedModel,
    );
  }
}
