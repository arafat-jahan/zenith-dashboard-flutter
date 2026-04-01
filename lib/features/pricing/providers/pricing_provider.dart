import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
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

  Future<void> requestSubscription(String planId, BuildContext context) async {
    state = const AsyncValue.loading();
    try {
      final user = ref.read(authStateChangesProvider).value;
      if (user == null) throw Exception('User not authenticated');
      
      // Open exact Stripe URL
      const stripeUrl = 'https://buy.stripe.com/test_00w28q78R6qJ9xt7rn4Rq00';
      
      final launched = await launchUrl(
        Uri.parse(stripeUrl),
        mode: LaunchMode.externalApplication,
      );
      
      if (!launched) {
        throw Exception('Could not launch Stripe checkout');
      }
      
      // Navigate to payment verification screen
      if (context.mounted) {
        Navigator.of(context).pushNamed('/payment-verification');
      }
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, AsyncValue<void>>((ref) {
  return SubscriptionNotifier(ref);
});
