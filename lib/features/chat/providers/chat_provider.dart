import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/repositories/implementations/gemini_chat_repository.dart';
import '../../../core/repositories/interfaces/i_chat_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/chat_message.dart';

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  // Force Firebase usage - no more mock mode
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

    // Check credits before allowing chat
    final userModel = await ref.read(userProfileProvider.future);
    if (userModel != null && userModel.credits <= 0) {
      state = state.copyWith(
        showPaywall: true,
        paywallMessage: 'You have run out of credits. Buy more credits to continue chatting!',
      );
      return;
    }

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
        // Check credits again before streaming
        if (userModel.credits <= 0) {
          state = state.copyWith(
            showPaywall: true,
            paywallMessage: 'You have run out of credits. Buy more credits to continue chatting!',
          );
          return;
        }

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

        // Only decrement credits after successful response
        if (state.streamingText.isNotEmpty && !state.streamingText.startsWith('Error:')) {
          await _decrementCredits(userModel.id);
          
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

  Future<void> _decrementCredits(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'credits': FieldValue.increment(-1)});
    } catch (e) {
      // Log error but don't block user experience
      print('Failed to decrement credits: $e');
    }
  }

  void _addErrorMessage(String error) {
    state = state.copyWith(
      isTyping: false,
      streamingText: error,
      hasStreamingError: true,
    );
  }

  void dismissPaywall() {
    state = state.copyWith(
      showPaywall: false,
      paywallMessage: '',
    );
  }

  void changeModel(String model) {
    state = state.copyWith(selectedModel: model);
  }

  void clearChat() {
    state = const ChatState(); // Complete reset
  }

  // Get current user credits for UI display
  Future<int?> getUserCredits() async {
    final userModel = await ref.read(userProfileProvider.future);
    return userModel?.credits;
  }
}

// UPGRADE: Using NotifierProvider
final chatProvider = NotifierProvider<ChatNotifier, ChatState>(ChatNotifier.new);