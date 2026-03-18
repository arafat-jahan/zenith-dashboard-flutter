// lib/features/dashboard/widgets/stat_bento_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class StatBentoCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Gradient iconGradient;
  final Color glowColor;

  const StatBentoCard({
    super.key, required this.title, required this.value,
    required this.change, required this.isPositive, required this.icon,
    required this.iconGradient, required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: glowColor, glowRadius: 24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              gradient: iconGradient, borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: glowColor, blurRadius: 14, spreadRadius: -2)],
            ),
            child: Icon(icon, size: 16, color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (isPositive ? AppColors.accentGreen : AppColors.accentRose).withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                  size: 11, color: isPositive ? AppColors.accentGreen : AppColors.accentRose),
              const SizedBox(width: 4),
              Text(change, style: AppTextStyles.labelSmall.copyWith(
                color: isPositive ? AppColors.accentGreen : AppColors.accentRose,
                fontWeight: FontWeight.w600, fontSize: 10,
              )),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        Text(value, style: AppTextStyles.metricLarge),
        const SizedBox(height: 4),
        Text(title, style: AppTextStyles.bodySmall),
      ]),
    );
  }
}