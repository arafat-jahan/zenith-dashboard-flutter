import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/i_billing_repository.dart';

class MockBillingRepository implements IBillingRepository {
  final FirebaseFirestore _db;

  MockBillingRepository(this._db);

  @override
  Future<void> requestSubscription(String userId, String planId) async {
    // ########################################################################
    // ⚠️ CRITICAL SECURITY WARNING: DO NOT USE THIS IN PRODUCTION.
    // USER PLAN UPDATES MUST ONLY HAPPEN VIA SERVER-SIDE WEBHOOKS.
    //
    // In a real production environment:
    // 1. The client should call a Cloud Function or Backend API to create a checkout session.
    // 2. The user completes the payment on Stripe's hosted page.
    // 3. Stripe sends a 'checkout.session.completed' webhook to your server.
    // 4. YOUR SERVER (not the client) updates the user's plan in Firestore.
    // ########################################################################
    
    // Simulating a secure backend request
    await Future.delayed(const Duration(seconds: 2));

    // MOCKING SERVER-SIDE VALIDATION
    await _db.collection('users').doc(userId).update({
      'plan': planId,
      'subscriptionDate': FieldValue.serverTimestamp(),
      'lastSubscriptionRequest': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> cancelSubscription(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    await _db.collection('users').doc(userId).update({
      'plan': 'free',
    });
  }
}
