import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../providers/recent_activity_provider.dart';

class RecentActivityCard extends ConsumerWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(recentActivityProvider);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: AppTextStyles.headlineMedium),
              Text('View all', style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet)),
            ],
          ),
          const SizedBox(height: 16),
          activityAsync.when(
            data: (items) => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: AppColors.glassBorder, height: 1),
              ),
              itemBuilder: (context, i) {
                final item = items[i];
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (item.color ?? Colors.grey).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(item.icon ?? Icons.help_outline, size: 14, color: item.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
                          Text(item.subtitle, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                    Text(item.time, style: AppTextStyles.bodySmall),
                  ],
                );
              },
            ),
            loading: () => Column(
              children: List.generate(5, (i) => const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: BaseShimmer(height: 40),
              )),
            ),
            error: (err, _) => Center(child: Text('Error: $err', style: AppTextStyles.bodySmall)),
          ),
        ],
      ),
    );
  }
}
