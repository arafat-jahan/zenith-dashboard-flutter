import 'package:flutter/foundation.dart';
import '../interfaces/i_billing_repository.dart';

class MockBillingRepository implements IBillingRepository {
  MockBillingRepository();

  @override
  Future<void> requestSubscription(String userId, String planId) async {
    // ########################################################################
    // ⚠️ CRITICAL SECURITY WARNING: PROD FLOW MUST BE SERVER-SIDE ONLY.
    // ########################################################################
    
    // Simulating a secure backend request to Stripe/Billing provider
    await Future.delayed(const Duration(seconds: 2));

    // IN PRODUCTION: 
    // 1. Client calls: `FirebaseFunctions.instance.httpsCallable('createCheckoutSession')`
    // 2. Stripe sends a webhook to your backend upon successful payment.
    // 3. YOUR BACKEND updates Firestore.
    
    // For this Mock, we simulate a successful backend update notification.
    // We do NOT update Firestore directly from the client to prevent security exploits.
    debugPrint('WEBHOOK SIMULATION: Backend would now update Firestore for user $userId to plan $planId');
  }

  @override
  Future<void> cancelSubscription(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('WEBHOOK SIMULATION: Backend would now downgrade user $userId to free plan');
  }
}
