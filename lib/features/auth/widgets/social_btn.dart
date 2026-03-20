// lib/features/auth/widgets/social_btn.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  const SocialBtn({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 12),
      onTap: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.labelLarge),
      ]),
    );
  }
}
