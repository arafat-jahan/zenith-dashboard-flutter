// lib/core/services/stripe_mock_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class StripeMockService {
  final String uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  StripeMockService({required this.uid});

  Future<bool> subscribeToPlan(String planName) async {
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Update user plan in Firestore
      await _db.collection('users').doc(uid).update({
        'plan': planName,
        'subscriptionDate': FieldValue.serverTimestamp(),
      });
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelSubscription() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _db.collection('users').doc(uid).update({
        'plan': 'free',
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
