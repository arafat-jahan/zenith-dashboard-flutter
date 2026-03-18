// lib/features/chat/providers/chat_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../../../core/providers/app_providers.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;

  ChatNotifier(this.ref) : super(ChatState(
    messages: [],
    isTyping: false,
    selectedModel: 'zenith-ultra',
  ));

  void sendMessage(String text) async {
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
    );

    try {
      final geminiService = ref.read(geminiServiceProvider);
      final user = ref.read(authStateProvider).value;
      
      if (user != null) {
        final response = await geminiService.generateResponse(text, user.uid);
        if (response != null) {
          final aiMessage = ChatMessage(
            text: response,
            isUser: false,
            timestamp: DateTime.now(),
          );
          state = state.copyWith(
            messages: [...state.messages, aiMessage],
            isTyping: false,
          );
        } else {
          _addErrorMessage('Failed to generate response');
        }
      } else {
        _addErrorMessage('User not authenticated');
      }
    } catch (e) {
      _addErrorMessage('Error: ${e.toString()}');
    }
  }

  void _addErrorMessage(String error) {
    final errorMessage = ChatMessage(
      text: error,
      isUser: false,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, errorMessage],
      isTyping: false,
    );
  }

  void changeModel(String model) {
    state = state.copyWith(selectedModel: model);
  }

  void clearChat() {
    state = state.copyWith(messages: []);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});
