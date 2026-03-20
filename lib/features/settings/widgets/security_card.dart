// lib/features/settings/widgets/security_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Security', style: AppTextStyles.headlineMedium),
          const Icon(LucideIcons.shieldCheck, size: 18, color: AppColors.accentGreen),
        ]),
        const SizedBox(height: 4),
        Text('Protect your account', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        const _SecurityItem(icon: LucideIcons.lock, title: 'Password', subtitle: 'Last changed 30 days ago', action: 'Change'),
        const Divider(color: AppColors.glassBorder, height: 24),
        const _SecurityItem(icon: LucideIcons.smartphone, title: 'Two-Factor Auth', subtitle: 'Authenticator app enabled', action: 'Manage', isEnabled: true),
        const Divider(color: AppColors.glassBorder, height: 24),
        const _SecurityItem(icon: LucideIcons.monitor, title: 'Active Sessions', subtitle: '3 devices logged in', action: 'View'),
      ]),
    );
  }
}

class _SecurityItem extends StatelessWidget {
  final IconData icon;
  final String title, subtitle, action;
  final bool isEnabled;
  const _SecurityItem({required this.icon, required this.title, required this.subtitle, required this.action, this.isEnabled = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.accentViolet.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 15, color: AppColors.accentViolet),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ])),
      if (isEnabled) GradientBadge(label: 'Active', gradient: AppColors.greenGradient),
      const SizedBox(width: 8),
      GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        onTap: () {},
        child: Text(action, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
      ),
    ]);
  }
}
