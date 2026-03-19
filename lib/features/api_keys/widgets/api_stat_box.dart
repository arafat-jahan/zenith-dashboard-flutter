import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class ApiStatBox extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const ApiStatBox({super.key, required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: AppTextStyles.labelSmall),
          Text(value, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
        ]),
      ]),
    );
  }
}
