import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class ActiveModelsCard extends StatelessWidget {
  const ActiveModelsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final models = [
      ('Zenith Ultra', 'Production', AppColors.accentViolet),
      ('Zenith Pro', 'Staging', AppColors.accentBlue),
      ('Zenith Flash', 'Development', AppColors.accentCyan),
    ];
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Models', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 16),
          ...models.map((m) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: m.$3.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(LucideIcons.cpu, size: 14, color: m.$3),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.$1, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
                      Text(m.$2, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.accentGreen.withValues(alpha: 0.4), blurRadius: 6)],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
