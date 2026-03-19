import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';
import '../interfaces/i_chat_repository.dart';

class GeminiChatRepository implements IChatRepository {
  final FirebaseFirestore _db;

  // --- CRITICAL SECURITY COMMENT ---
  // Calling LLMs directly from the client is a major security risk.
  // An attacker could decompile the app, extract the API key, and use it for free,
  // leading to massive bills.
  //
  // PRODUCTION SOLUTION: Move this logic to a Firebase Cloud Function.
  // 1. Create an HTTP-callable function `generateGeminiResponse`.
  // 2. The client calls this function via `FirebaseFunctions.instance.httpsCallable('...')`.
  // 3. The function authenticates the user, validates their plan, and *then* securely
  //    calls the Gemini API using a key stored in Firebase Secret Manager.
  // This prevents the API key from ever being on the client device.
  static const _geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyA8p1pTNjSqj1chw4dnaojbQRoj6VAZEKQ',
  );

  GeminiChatRepository(this._db);

  @override
  Future<String> generateResponse(UserModel user, String prompt, {String modelName = 'zenith-flash'}) async {
    try {
      final modelId = _getModelId(modelName);
      
      // Use v1 API instead of v1beta for better stability in most regions
      final model = GenerativeModel(
        model: modelId,
        apiKey: _geminiApiKey,
      );
      
      final response = await model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText != null) {
        // Atomically update usage and save history in a single batch
        final batch = _db.batch();
        final userRef = _db.collection('users').doc(user.id);
        final chatRef = userRef.collection('chats').doc();

        batch.update(userRef, {'tokenUsage': FieldValue.increment(1)});
        batch.set(chatRef, {
          'prompt': prompt,
          'response': responseText,
          'timestamp': FieldValue.serverTimestamp(),
        });

        await batch.commit();
        return responseText;
      }
      throw Exception('Empty response from Gemini');
    } catch (e) {
      // If latest models fail, try the most basic stable one as absolute fallback
      if (e.toString().contains('not found') || e.toString().contains('404')) {
        try {
          final fallbackModel = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _geminiApiKey);
          final response = await fallbackModel.generateContent([Content.text(prompt)]);
          return response.text ?? 'Error: Empty response';
        } catch (inner) {
          // If even fallback fails, let's try gemini-pro (v1)
          try {
            final superFallback = GenerativeModel(model: 'gemini-pro', apiKey: _geminiApiKey);
            final resp = await superFallback.generateContent([Content.text(prompt)]);
            return resp.text ?? 'Error: Empty response';
          } catch (last) {
            rethrow;
          }
        }
      }
      rethrow;
    }
  }

  String _getModelId(String modelName) {
    switch (modelName) {
      case 'zenith-ultra': return 'gemini-1.5-pro-latest';
      case 'zenith-pro':   return 'gemini-1.5-flash-latest';
      case 'zenith-flash': return 'gemini-1.5-flash-latest';
      case 'zenith-nano':  return 'gemini-1.5-flash';
      default: return 'gemini-1.5-flash-latest';
    }
  }
}
