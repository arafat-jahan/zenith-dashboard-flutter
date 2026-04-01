// lib/features/admin/providers/admin_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/user_model.dart';

class AdminProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getAllUsers() {
    return _db
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<List<UserModel>> searchUsers(String query) async {
    if (query.isEmpty) return [];
    
    final snapshot = await _db
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('email', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .orderBy('email')
        .limit(20)
        .get();
    
    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addCredits(String userId, int creditsToAdd) async {
    await _db.collection('users').doc(userId).update({
      'credits': FieldValue.increment(creditsToAdd),
    });
  }

  Future<void> toggleUserPlan(String userId, String currentPlan) async {
    final newPlan = currentPlan == 'free' ? 'pro' : 'free';
    await _db.collection('users').doc(userId).update({
      'plan': newPlan,
    });
  }

  Future<UserModel?> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}

final adminProvider = Provider<AdminProvider>((ref) => AdminProvider());
