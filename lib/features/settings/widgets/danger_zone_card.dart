// lib/features/settings/widgets/danger_zone_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class DangerZoneCard extends StatelessWidget {
  const DangerZoneCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: AppColors.accentRose.withValues(alpha: 0.3),
      glowColor: AppColors.accentRose.withValues(alpha: 0.1),
      glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(LucideIcons.alertTriangle, size: 16, color: AppColors.accentRose),
          const SizedBox(width: 8),
          Text('Danger Zone', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.accentRose)),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Delete Account', style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
            Text('Permanently delete all data', style: AppTextStyles.bodySmall),
          ])),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentRose.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(color: Colors.transparent,
                child: InkWell(onTap: () {}, borderRadius: BorderRadius.circular(8),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Text('Delete', style: AppTextStyles.labelLarge.copyWith(color: AppColors.accentRose))))),
          ),
        ]),
      ]),
    );
  }
}
