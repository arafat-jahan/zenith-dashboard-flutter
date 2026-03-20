import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../core/repositories/implementations/gemini_chat_repository.dart';
import '../../../core/repositories/implementations/mock_chat_repository.dart';
import '../../../core/repositories/interfaces/i_chat_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/chat_message.dart';
import '../../../main.dart'; // To access isMockModeProvider

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  final isMock = ref.watch(isMockModeProvider);
  if (isMock || Firebase.apps.isEmpty) {
    return MockChatRepository();
  }
  return GeminiChatRepository(FirebaseFirestore.instance);
});

// UPGRADE: Using modern Notifier instead of legacy StateNotifier
class ChatNotifier extends Notifier<ChatState> {
  @override
  ChatState build() {
    return const ChatState();
  }

  Future<void> sendMessage(String text) async {
    final sanitizedText = text.trim();
    if (sanitizedText.isEmpty) return;

    final userMessage = ChatMessage(
      text: sanitizedText,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
      streamingText: '',
      hasStreamingError: false,
      lastPrompt: sanitizedText,
    );

    await _startStreaming(sanitizedText);
  }

  Future<void> retryLast() async {
    if (state.lastPrompt == null) return;

    state = state.copyWith(
      isTyping: true,
      streamingText: '',
      hasStreamingError: false,
    );

    await _startStreaming(state.lastPrompt!);
  }

  Future<void> _startStreaming(String prompt) async {
    try {
      final chatRepo = ref.read(chatRepositoryProvider);
      // We use ref.read(...future) to ensure we have the data before proceeding
      final userModel = await ref.read(userProfileProvider.future);

      if (userModel != null) {
        final stream = chatRepo.generateResponseStream(userModel, prompt, modelName: state.selectedModel);

        String accumulated = '';
        await for (final chunk in stream) {
          // If the notifier was disposed during streaming, abort to prevent memory leaks
          // Not strictly required for global providers, but best practice for scoped ones

          if (chunk.startsWith('Error:')) {
            _addErrorMessage(chunk);
            return;
          }
          accumulated += chunk;
          HapticFeedback.lightImpact(); // Apple-grade tactile typing feel
          state = state.copyWith(
            streamingText: accumulated,
            isTyping: false,
          );
        }

        if (state.streamingText.isNotEmpty) {
          final aiMessage = ChatMessage(
            text: state.streamingText,
            isUser: false,
            timestamp: DateTime.now(),
          );
          state = state.copyWith(
            messages: [...state.messages, aiMessage],
            streamingText: '',
          );
        }
      } else {
        _addErrorMessage('User not authenticated. Please log in.');
      }
    } catch (e) {
      _addErrorMessage('Error processing request: ${e.toString()}');
    }
  }

  void _addErrorMessage(String error) {
    state = state.copyWith(
      isTyping: false,
      streamingText: error,
      hasStreamingError: true,
    );
  }

  void changeModel(String model) {
    state = state.copyWith(selectedModel: model);
  }

  void clearChat() {
    state = const ChatState(); // Complete reset
  }
}

// UPGRADE: Using NotifierProvider
final chatProvider = NotifierProvider<ChatNotifier, ChatState>(ChatNotifier.new);