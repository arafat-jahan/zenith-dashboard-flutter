// lib/features/settings/widgets/preferences_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import 'setting_row.dart';

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Preferences', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 16),
        const SettingRow(label: 'Language', value: 'English (US)'),
        const SettingRow(label: 'Date Format', value: 'MM/DD/YYYY'),
        const SettingRow(label: 'Currency', value: 'USD (\$)'),
        const SettingRow(label: 'Theme', value: 'Dark (Deep Charcoal)'),
      ]),
    );
  }
}
