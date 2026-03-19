import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class TopEndpointsCard extends StatelessWidget {
  const TopEndpointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final endpoints = [
      ('/v1/chat/completions', '18.2M', AppColors.accentViolet),
      ('/v1/embeddings', '9.4M', AppColors.accentBlue),
      ('/v1/completions', '7.1M', AppColors.accentCyan),
      ('/v1/fine-tunes', '3.8M', AppColors.accentGreen),
      ('/v1/images/generate', '2.1M', AppColors.accentAmber),
    ];
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Top Endpoints', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('By total requests this month', style: AppTextStyles.bodySmall),
        const SizedBox(height: 16),
        ...endpoints.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(
              color: e.$3, shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: e.$3.withValues(alpha: 0.6), blurRadius: 6)],
            )),
            const SizedBox(width: 10),
            Expanded(child: Text(e.$1, style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary, fontFamily: 'monospace'))),
            Text(e.$2, style: AppTextStyles.labelLarge.copyWith(color: e.$3)),
          ]),
        )),
      ]),
    );
  }
}
