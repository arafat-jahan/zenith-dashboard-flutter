// lib/features/settings/widgets/notifications_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

final notifEmailProvider = StateProvider<bool>((ref) => true);
final notifSlackProvider = StateProvider<bool>((ref) => false);
final notifSmsProvider = StateProvider<bool>((ref) => true);

class NotificationsCard extends ConsumerWidget {
  const NotificationsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Notifications', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Choose how you want to be notified', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        _ToggleRow(provider: notifEmailProvider, icon: LucideIcons.mail, title: 'Email Alerts', subtitle: 'Usage limits & billing'),
        const Divider(color: AppColors.glassBorder, height: 20),
        _ToggleRow(provider: notifSlackProvider, icon: LucideIcons.hash, title: 'Slack Integration', subtitle: 'Real-time incident alerts'),
        const Divider(color: AppColors.glassBorder, height: 20),
        _ToggleRow(provider: notifSmsProvider, icon: LucideIcons.messageSquare, title: 'SMS Alerts', subtitle: 'Critical system events only'),
      ]),
    );
  }
}

class _ToggleRow extends ConsumerWidget {
  final StateProvider<bool> provider;
  final IconData icon;
  final String title, subtitle;
  const _ToggleRow({required this.provider, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context, WidgetRef r) {
    final val = r.watch(provider);
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bgElevated, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 15, color: AppColors.textSecondary),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ])),
      Switch(
        value: val,
        onChanged: (v) => r.read(provider.notifier).state = v,
        activeThumbColor: AppColors.accentViolet,
        activeTrackColor: AppColors.accentViolet.withValues(alpha: 0.3),
        inactiveTrackColor: AppColors.bgElevated,
        inactiveThumbColor: AppColors.textMuted,
      ),
    ]);
  }
}
