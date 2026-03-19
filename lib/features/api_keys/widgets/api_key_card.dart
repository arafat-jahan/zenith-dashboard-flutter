import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../models/api_credential.dart';

class ApiKeyCard extends StatelessWidget {
  final ApiCredential credential;
  const ApiKeyCard({super.key, required this.credential});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (credential.color ?? AppColors.accentBlue).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(LucideIcons.key, size: 16, color: credential.color),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(credential.name, style: AppTextStyles.headlineSmall.copyWith(fontSize: 14)),
            const SizedBox(height: 2),
            Text('Created on ${credential.created}', style: AppTextStyles.bodySmall),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (credential.isActive ? AppColors.accentGreen : AppColors.textMuted).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(credential.isActive ? 'Active' : 'Inactive', style: AppTextStyles.labelSmall.copyWith(
              color: credential.isActive ? AppColors.accentGreen : AppColors.textMuted,
              fontWeight: FontWeight.w700,
            )),
          ),
        ]),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.bgDeep.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(children: [
            Expanded(child: Text(credential.key, style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary, fontFamily: 'monospace', letterSpacing: 1))),
            const Icon(LucideIcons.copy, size: 14, color: AppColors.textSecondary),
          ]),
        ),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Last used: ${credential.lastUsed}', style: AppTextStyles.bodySmall),
          Row(children: [
            _ActionIcon(icon: LucideIcons.edit3, onTap: () {}),
            const SizedBox(width: 8),
            _ActionIcon(icon: LucideIcons.trash2, color: AppColors.accentRose, onTap: () {}),
          ]),
        ]),
      ]),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;
  const _ActionIcon({required this.icon, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(border: Border.all(color: AppColors.glassBorder), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 14, color: color ?? AppColors.textSecondary),
      ),
    );
  }
}
