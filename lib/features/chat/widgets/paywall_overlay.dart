// lib/features/chat/widgets/paywall_overlay.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/config/app_config.dart';
import '../providers/chat_provider.dart';
import '../../../shared/widgets/glass_card.dart';

class PaywallOverlay extends ConsumerWidget {
  const PaywallOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    if (!chatState.showPaywall) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GlassCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.violetGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -4),
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.coins,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Credits Exhausted',
                  style: AppTextStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Message
                Text(
                  chatState.paywallMessage,
                  style: AppTextStyles.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Pricing Options
                Row(
                  children: [
                    Expanded(
                      child: _buildPricingCard(
                        'Starter',
                        '50 Credits',
                        '\$9.99',
                        AppColors.blueGradient,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildPricingCard(
                        'Pro',
                        '200 Credits',
                        '\$29.99',
                        AppColors.violetGradient,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildPricingCard(
                        'Enterprise',
                        '1000 Credits',
                        '\$99.99',
                        AppColors.goldGradient,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => chatNotifier.dismissPaywall(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.glassBorder),
                          ),
                        ),
                        child: Text(
                          'Maybe Later',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.violetGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -4),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // TODO: Implement Stripe payment
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Payment integration coming soon!'),
                                  backgroundColor: AppColors.accentViolet,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Text(
                                  'Buy Credits',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Support Text
                Text(
                  'Need help? Contact ${AppConfig.supportEmail}',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(String title, String credits, String price, Gradient gradient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: gradient.colors.first.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.headlineSmall.copyWith(
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: gradient.colors,
                ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            credits,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.accentViolet,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
