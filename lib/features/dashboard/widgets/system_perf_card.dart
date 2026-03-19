import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class SystemPerfCard extends StatelessWidget {
  const SystemPerfCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Performance', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 16),
          _PerfItem(label: 'CPU Usage', value: '24%', color: AppColors.accentGreen, icon: LucideIcons.cpu),
          const SizedBox(height: 12),
          _PerfItem(label: 'Memory', value: '4.2GB', color: AppColors.accentBlue, icon: LucideIcons.database),
          const SizedBox(height: 12),
          _PerfItem(label: 'Network', value: '1.2GB/s', color: AppColors.accentViolet, icon: LucideIcons.activity),
        ],
      ),
    );
  }
}

class _PerfItem extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _PerfItem({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        Text(value, style: AppTextStyles.labelLarge.copyWith(color: color)),
      ],
    );
  }
}
