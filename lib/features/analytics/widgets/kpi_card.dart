import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class KpiCard extends StatelessWidget {
  final String title, value, change;
  final Color color;
  const KpiCard({super.key, required this.title, required this.value, required this.change, required this.color});

  @override
  Widget build(BuildContext context) {
    final isPos = change.startsWith('-') ? title == 'Error Rate' || title == 'Avg Latency' || title == 'Cost / 1K tokens' : true;
    return GlassCard(
      glowColor: color.withValues(alpha: 0.3),
      glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: AppTextStyles.bodySmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: (isPos ? AppColors.accentGreen : AppColors.accentRose).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(change, style: AppTextStyles.labelSmall.copyWith(
              color: isPos ? AppColors.accentGreen : AppColors.accentRose,
              fontWeight: FontWeight.w700,
            )),
          ),
        ]),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles.metricLarge.copyWith(color: color)),
      ]),
    );
  }
}
