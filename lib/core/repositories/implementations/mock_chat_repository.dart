// lib/core/repositories/implementations/mock_chat_repository.dart
import 'dart:async';
import '../../models/user_model.dart';
import '../interfaces/i_chat_repository.dart';
import '../../../core/config/app_config.dart';

class MockChatRepository implements IChatRepository {
  @override
  Stream<String> generateResponseStream(UserModel user, String prompt, {String modelName = 'zenith-flash'}) async* {
    yield 'Hello! I am ${AppConfig.appName}. I am currently running in **Demo Mode** because Firebase or Gemini API Key is not fully configured.';
    await Future.delayed(const Duration(milliseconds: 600));
    yield '\n\nIn this mode, I can show you how my **Typewriter Streaming** animation works. It is designed to feel smooth and responsive, just like premium AI apps.';
    await Future.delayed(const Duration(milliseconds: 800));
    yield '\n\nYour prompt was: "$prompt"';
    await Future.delayed(const Duration(milliseconds: 500));
    yield '\n\nTo enable real AI responses, please configure your `.env` file with a valid `GEMINI_API_KEY` and ensure Firebase is initialized.';
  }
}
