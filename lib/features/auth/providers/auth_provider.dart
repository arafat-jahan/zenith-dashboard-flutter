import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_kit/core/models/user_model.dart';
import 'package:ui_kit/core/repositories/implementations/firebase_auth_repository.dart';
import 'package:ui_kit/core/repositories/interfaces/i_auth_repository.dart';

// Email verification state provider
final emailVerificationProvider = StateProvider<bool>((ref) => false);

// Email verification check provider
final emailVerificationCheckProvider = FutureProvider<bool>((ref) async {
  final authRepo = ref.watch(authRepositoryProvider);
  return await authRepo.isEmailVerified();
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // Force Firebase usage - no more mock mode
  return FirebaseAuthRepository(FirebaseAuth.instance);
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  // Force Firebase usage - no more mock mode
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authRepo = ref.read(authRepositoryProvider);
  
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) return null;
  
  return authRepo.getUserProfile(user.uid);
});
