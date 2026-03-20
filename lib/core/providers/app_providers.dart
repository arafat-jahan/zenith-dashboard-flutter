// lib/core/providers/app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/auth/providers/auth_provider.dart';

// Chat History Provider (Read-only view for history)
// Points directly to Firestore as it's a shared infrastructure concern
final chatHistoryProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
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
