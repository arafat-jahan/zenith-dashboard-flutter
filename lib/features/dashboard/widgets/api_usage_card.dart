import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class ApiUsageCard extends StatelessWidget {
  const ApiUsageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('API Usage', style: AppTextStyles.headlineMedium),
          Text('Requests by method', style: AppTextStyles.bodySmall),
          const SizedBox(height: 20),
          _UsageRow(label: 'GET', value: 0.65, color: AppColors.accentBlue, count: '12.4M'),
          _UsageRow(label: 'POST', value: 0.28, color: AppColors.accentGreen, count: '5.2M'),
          _UsageRow(label: 'PUT', value: 0.05, color: AppColors.accentViolet, count: '0.8M'),
          _UsageRow(label: 'DELETE', value: 0.02, color: AppColors.accentRose, count: '0.3M'),
        ],
      ),
    );
  }
}

class _UsageRow extends StatelessWidget {
  final String label, count;
  final double value;
  final Color color;
  const _UsageRow({required this.label, required this.value, required this.color, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.labelLarge),
              Text(count, style: AppTextStyles.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: AppColors.bgElevated,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
