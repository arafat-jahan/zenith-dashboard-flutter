import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class ModelBreakdownCard extends StatelessWidget {
  const ModelBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Zenith Ultra', '2.1B tokens', AppColors.accentViolet, 0.44),
      ('Zenith Pro', '1.4B tokens', AppColors.accentBlue, 0.29),
      ('Zenith Flash', '0.8B tokens', AppColors.accentCyan, 0.17),
      ('Zenith Nano', '0.5B tokens', AppColors.accentGreen, 0.10),
    ];
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Model Usage Breakdown', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Token consumption by model', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: item.$3, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: item.$3.withValues(alpha: 0.6), blurRadius: 6)])),
                const SizedBox(width: 8),
                Text(item.$1, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
              ]),
              Text(item.$2, style: AppTextStyles.bodySmall),
            ]),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(value: item.$4, minHeight: 5,
                  backgroundColor: AppColors.bgElevated,
                  valueColor: AlwaysStoppedAnimation<Color>(item.$3)),
            ),
          ]),
        )),
      ]),
    );
  }
}
