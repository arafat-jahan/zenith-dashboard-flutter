import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';
import '../interfaces/i_chat_repository.dart';

class GeminiChatRepository implements IChatRepository {
  final FirebaseFirestore _db;
  final GenerativeModel _model;

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
    defaultValue: 'AIzaSyA8p1pTNjSqj1chw4dnaojbQRoj6VAZEKQ', // Fallback for local dev
  );

  GeminiChatRepository(this._db)
      : _model = GenerativeModel(model: 'gemini-pro', apiKey: _geminiApiKey);

  @override
  Future<String> generateResponse(UserModel user, String prompt) async {
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
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
      throw Exception('Failed to get a response from the model.');
    } catch (e) {
      // Implement proper error logging (e.g., to Crashlytics)
      rethrow;
    }
  }
}
