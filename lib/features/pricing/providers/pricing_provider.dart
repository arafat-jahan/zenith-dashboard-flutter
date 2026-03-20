import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/repositories/implementations/static_pricing_repository.dart';
import '../../../core/repositories/interfaces/i_pricing_repository.dart';
import '../../../core/models/pricing_plan.dart';
import '../../auth/providers/auth_provider.dart';

final pricingRepositoryProvider = Provider<IPricingRepository>((ref) {
  return StaticPricingRepository();
});

final pricingPlansProvider = FutureProvider<List<PricingPlan>>((ref) async {
  final repo = ref.watch(pricingRepositoryProvider);
  return repo.getPricingPlans();
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
      
      // In production, this would call a real billing service/cloud function
      await Future.delayed(const Duration(seconds: 1));
      
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
