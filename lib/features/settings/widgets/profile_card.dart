// lib/features/settings/widgets/profile_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../core/constants/app_strings.dart';
import 'setting_row.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Profile', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Update your personal information', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        Row(children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              gradient: AppColors.violetGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20)],
            ),
            child: const Center(child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800))),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppStrings.userName, style: AppTextStyles.headlineMedium),
            Text(AppStrings.userEmail, style: AppTextStyles.bodySmall),
            const SizedBox(height: 6),
            GradientBadge(label: AppStrings.userPlan, gradient: AppColors.violetGradient),
          ])),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            onTap: () {},
            child: Text('Edit', style: AppTextStyles.labelLarge),
          ),
        ]),
        const SizedBox(height: 20),
        const Divider(color: AppColors.glassBorder),
        const SizedBox(height: 16),
        const SettingRow(label: 'Full Name', value: AppStrings.userFullName),
        const SettingRow(label: 'Email', value: AppStrings.userEmail),
        const SettingRow(label: 'Company', value: AppStrings.userCompany),
        const SettingRow(label: 'Timezone', value: AppStrings.userTimezone),
      ]),
    );
  }
}
