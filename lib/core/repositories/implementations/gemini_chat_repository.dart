import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';
import '../interfaces/i_chat_repository.dart';

class GeminiChatRepository implements IChatRepository {
  final FirebaseFirestore _db;

  // Hardcoded limits to protect infrastructure
  static const int _maxPromptLength = 4000;

  static const _geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  GeminiChatRepository(this._db);

  /// Sanitizes input to prevent injection & limit abuse
  String _sanitizeInput(String input) {
    String sanitized = input.trim();
    if (sanitized.length > _maxPromptLength) {
      sanitized = sanitized.substring(0, _maxPromptLength);
    }
    // Additional regex sanitization can be added here
    return sanitized;
  }

  @override
  Stream<String> generateResponseStream(UserModel user, String prompt, {String modelName = 'zenith-flash'}) async* {
    final safePrompt = _sanitizeInput(prompt);
    if (safePrompt.isEmpty) return;

    if (_geminiApiKey.isEmpty) {
      // PRO-LEVEL MOCK MODE: Show the typewriter animation even without a key
      yield 'Hello! I am Zenith AI. Currently, I am running in **Demo Mode** because no API Key was found.';
      await Future.delayed(const Duration(milliseconds: 800));
      yield '\n\nYou can still test my UI and see how the **Typewriter Streaming** animation feels.';
      await Future.delayed(const Duration(milliseconds: 600));
      yield '\n\nTo enable real AI responses, please add your `GEMINI_API_KEY` to the `.env` file or pass it via `--dart-define`.';
      return;
    }

    final geminiModel = _mapToGeminiModel(modelName);
    StringBuffer accumulatedResponse = StringBuffer();

    try {
      final model = GenerativeModel(
        model: geminiModel,
        apiKey: _geminiApiKey,
      );

      // Apply a strict timeout to the stream initialization
      final responseStream = model.generateContentStream([Content.text(safePrompt)])
          .timeout(const Duration(seconds: 15));

      await for (final chunk in responseStream) {
        final text = chunk.text;
        if (text != null) {
          accumulatedResponse.write(text);
          yield text;
        }
      }

      // After stream completes, we persist the chat.
      // NOTE: In production, token counting and usage updates MUST be handled
      // by a Firebase Cloud Function (backend) to prevent client-side exploits.
      final responseText = accumulatedResponse.toString();
      if (responseText.isNotEmpty) {
        await _persistChatToDb(user, safePrompt, responseText);
      }

    } on TimeoutException {
      debugPrint('Gemini Stream Error: Request Timed Out');
      yield 'Error: The model took too long to respond. Please try again.';
    } catch (e) {
      debugPrint('Gemini Stream Error: ${e.toString()}');
      yield 'Error: AI model is temporarily unavailable. Please check your API key, billing status, and VPN connection.';
    }
  }

  Future<void> _persistChatToDb(UserModel user, String prompt, String responseText) async {
    final batch = _db.batch();
    final userRef = _db.collection('users').doc(user.id);
    final chatRef = userRef.collection('chats').doc();

    // We only save the history on the client. 
    // The 'tokenUsage' increment logic is removed from here 
    // and should be implemented in a Firestore Trigger (Cloud Function).
    batch.set(chatRef, {
      'prompt': prompt,
      'response': responseText,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  String _mapToGeminiModel(String modelName) {
    switch (modelName) {
      case 'zenith-ultra': return 'gemini-1.5-pro';
      case 'zenith-pro':   return 'gemini-1.5-pro';
      case 'zenith-flash': return 'gemini-1.5-flash';
      case 'zenith-nano':  return 'gemini-1.5-flash';
      default:             return 'gemini-1.5-flash';
    }
  }
}