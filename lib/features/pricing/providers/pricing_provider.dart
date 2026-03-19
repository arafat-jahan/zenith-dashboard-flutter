import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/repositories/implementations/mock_billing_repository.dart';
import '../../../core/repositories/interfaces/i_billing_repository.dart';
import '../../auth/providers/auth_provider.dart';

final billingRepositoryProvider = Provider<IBillingRepository>((ref) {
  return MockBillingRepository(FirebaseFirestore.instance);
});

final selectedBillingCycleProvider = StateProvider<String>((ref) => 'monthly');
final selectedPlanProvider = StateProvider<String>((ref) => 'pro');

class SubscriptionNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  SubscriptionNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> requestSubscription(String planId) async {
    state = const AsyncValue.loading();
    try {
      final user = ref.read(authStateChangesProvider).value;
      if (user == null) throw Exception('User not authenticated');
      
      final repo = ref.read(billingRepositoryProvider);
      await repo.requestSubscription(user.id, planId);
      
      // Invalidate user profile to fetch updated plan
      ref.invalidate(userProfileProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, AsyncValue<void>>((ref) {
  return SubscriptionNotifier(ref);
});
