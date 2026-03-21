import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_kit/core/models/user_model.dart';
import 'package:ui_kit/core/repositories/implementations/firebase_auth_repository.dart';
import 'package:ui_kit/core/repositories/implementations/mock_auth_repository.dart';
import 'package:ui_kit/core/repositories/interfaces/i_auth_repository.dart';
import 'package:ui_kit/core/providers/app_state_provider.dart'; // Fixed import to avoid circular dependency

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // Use the global mock mode flag provided by main.dart
  final isMock = ref.watch(isMockModeProvider);
  
  if (isMock || Firebase.apps.isEmpty) {
    return MockAuthRepository();
  }
  
  try {
    return FirebaseAuthRepository(FirebaseAuth.instance);
  } catch (e) {
    debugPrint("Failed to initialize FirebaseAuth: $e");
    return MockAuthRepository();
  }
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final isMock = ref.watch(isMockModeProvider);
  if (isMock) {
    // In mock mode, we immediately emit null to trigger navigation to LoginScreen
    return Stream.value(null);
  }
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authRepo = ref.read(authRepositoryProvider);
  
  // For mock mode, we want a default user profile to let the buyer explore the UI
  final isMock = ref.watch(isMockModeProvider);
  if (isMock) {
    return authRepo.getUserProfile("demo-uid");
  }

  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) return null;
  
  return authRepo.getUserProfile(user.uid);
});
