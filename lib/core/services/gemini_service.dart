// lib/core/services/gemini_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeminiService {
  final String apiKey;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  GeminiService({required this.apiKey});

  GenerativeModel get _model => GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

  Future<String?> generateResponse(String prompt, String uid) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      if (response.text != null) {
        // Increment token usage for the user
        await _db.collection('users').doc(uid).update({
          'tokenUsage': FieldValue.increment(1),
        });
        
        // Save to chat history if needed
        await _db.collection('users').doc(uid).collection('chats').add({
          'prompt': prompt,
          'response': response.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        
        return response.text;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
