// lib/core/providers/app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/gemini_service.dart';
import '../models/user_model.dart';

// Firebase Auth Service Provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// User Profile Provider
final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user != null) {
    return ref.watch(authServiceProvider).getUserProfile(user.uid);
  }
  return null;
});

// Gemini Service Provider
final geminiServiceProvider = Provider<GeminiService>((ref) {
  // Your real Gemini API key
  const apiKey = 'AIzaSyA8p1pTNjSqj1chw4dnaojbQRoj6VAZEKQ'; 
  return GeminiService(apiKey: apiKey);
});

// Chat Provider
final chatHistoryProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  return const Stream.empty();
});

// Pricing Providers
final selectedBillingCycleProvider = StateProvider<String>((ref) => 'monthly');
final selectedPlanProvider = StateProvider<String>((ref) => 'pro');

// Navigation Provider
final selectedNavIndexProvider = StateProvider<int>((ref) => 0);

