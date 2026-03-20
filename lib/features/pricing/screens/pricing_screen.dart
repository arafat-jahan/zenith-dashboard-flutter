// lib/features/pricing/screens/pricing_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/models/pricing_plan.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../providers/pricing_provider.dart';

class PricingScreen extends ConsumerWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billing = ref.watch(selectedBillingCycleProvider);
    final plansAsync = ref.watch(pricingPlansProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: plansAsync.when(
        data: (plans) => CustomScrollView(slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
              child: Column(children: [
                GradientBadge(label: '🚀  Launch pricing — Save 17%', gradient: AppColors.violetGradient),
                const SizedBox(height: 16),
                Text('Simple, transparent pricing', style: AppTextStyles.displayLarge, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Start free. Scale as you grow. No surprise bills.', style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                // Billing Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface, borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    _ToggleBtn(label: 'Monthly', isSelected: billing == 'monthly', onTap: () => ref.read(selectedBillingCycleProvider.notifier).state = 'monthly'),
                    _ToggleBtn(label: 'Annual', isSelected: billing == 'annual', badge: 'Save 17%', onTap: () => ref.read(selectedBillingCycleProvider.notifier).state = 'annual'),
                  ]),
                ),
              ]),
            ),
          ),

          // Pricing Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 640, // Increased from 580 to accommodate all features
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _PricingCard(plan: plans[i], cycle: billing),
                childCount: plans.length,
              ),
            ),
          ),
        ]),
        loading: () => const _PricingLoading(),
        error: (err, st) => _PricingError(error: err.toString(), onRetry: () => ref.invalidate(pricingPlansProvider)),
      ),
    );
  }
}

class _PricingCard extends ConsumerWidget {
  final PricingPlan plan;
  final String cycle;
  const _PricingCard({required this.plan, required this.cycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = cycle == 'monthly' ? plan.monthlyPrice : plan.annualPrice;
    final subState = ref.watch(subscriptionProvider);
    final isLoading = subState.isLoading;

    return GlassCard(
      glowColor: plan.glowColor.withValues(alpha: 0.15),
      glowRadius: 50,
      borderColor: plan.isPopular ? plan.glowColor.withValues(alpha: 0.4) : null,
      padding: const EdgeInsets.all(32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (plan.isPopular) ...[
          GradientBadge(label: 'MOST POPULAR', gradient: plan.gradient),
          const SizedBox(height: 16),
        ],
        Text(plan.name, style: AppTextStyles.headlineLarge),
        const SizedBox(height: 8),
        Text(plan.tagline, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 32),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$$price', style: AppTextStyles.displayLarge.copyWith(fontSize: 48)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Text(price == 0 ? '' : '/mo', style: AppTextStyles.bodyLarge),
          ),
        ]),
        const SizedBox(height: 32),
        // CTA Button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: plan.gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: plan.glowColor.withValues(alpha: 0.3), blurRadius: 20)],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : () => ref.read(subscriptionProvider.notifier).requestSubscription(plan.id),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(plan.cta, style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        const Divider(color: AppColors.glassBorder),
        const SizedBox(height: 32),
        ...plan.features.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            Icon(LucideIcons.checkCircle2, size: 18, color: plan.glowColor),
            const SizedBox(width: 12),
            Text(f, style: AppTextStyles.bodyMedium),
          ]),
        )),
      ]),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;
  const _ToggleBtn({required this.label, required this.isSelected, this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.bgElevated : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: AppColors.glassBorder) : null,
        ),
        child: Row(children: [
          Text(label, style: AppTextStyles.labelLarge.copyWith(color: isSelected ? Colors.white : AppColors.textMuted)),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppColors.accentGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(badge!, style: const TextStyle(color: AppColors.accentGreen, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ]),
      ),
    );
  }
}

class _PricingLoading extends StatelessWidget {
  const _PricingLoading();
  @override
  Widget build(BuildContext context) {
    return const Center(child: BaseShimmer(height: 600, width: 400));
  }
}

class _PricingError extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _PricingError({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(LucideIcons.alertTriangle, color: AppColors.accentRose, size: 48),
        const SizedBox(height: 16),
        Text('Failed to load pricing', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 8),
        Text(error, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
}
