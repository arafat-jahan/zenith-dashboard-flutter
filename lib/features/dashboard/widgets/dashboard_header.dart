import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/providers/auth_provider.dart';

class DashboardHeader extends ConsumerWidget {
  final VoidCallback onRefresh;
  const DashboardHeader({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).value;
    final name = user?.name.split(' ').first ?? 'User';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(
                      '${AppStrings.dashboardGreeting}, $name',
                      style: AppTextStyles.displayMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('👋', style: TextStyle(fontSize: 22)),
                    if (user?.plan != 'free')
                      GradientBadge(
                        label: user?.plan.toUpperCase() ?? 'PRO',
                        gradient: AppColors.violetGradient,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.dashboardSubtitle,
                  style: AppTextStyles.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(children: [
            GlassCard(
              padding: const EdgeInsets.all(10),
              onTap: onRefresh,
              child: const Icon(LucideIcons.refreshCcw,
                  size: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 8),
            GlassCard(
              padding: const EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(LucideIcons.bell,
                      size: 16, color: AppColors.textSecondary),
                  Positioned(
                    top: -3, right: -3,
                    child: Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.accentRose,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppColors.accentRose, blurRadius: 6)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
