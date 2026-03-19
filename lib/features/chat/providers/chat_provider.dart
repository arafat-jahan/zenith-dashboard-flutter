import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/repositories/implementations/gemini_chat_repository.dart';
import '../../../core/repositories/interfaces/i_chat_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/chat_message.dart';

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  return GeminiChatRepository(FirebaseFirestore.instance);
});

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;

  ChatNotifier(this.ref) : super(ChatState(
    messages: [],
    isTyping: false,
    selectedModel: 'zenith-ultra',
  ));

  Future<void> sendMessage(String text) async {
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
      final chatRepo = ref.read(chatRepositoryProvider);
      final user = ref.read(authStateChangesProvider).value;
      
      if (user != null) {
        final response = await chatRepo.generateResponse(user, text);
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
