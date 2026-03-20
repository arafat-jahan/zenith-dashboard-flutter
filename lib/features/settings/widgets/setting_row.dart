// lib/features/settings/widgets/setting_row.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingRow extends StatelessWidget {
  final String label, value;
  const SettingRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTextStyles.bodySmall),
        Text(value, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
      ]),
    );
  }
}
