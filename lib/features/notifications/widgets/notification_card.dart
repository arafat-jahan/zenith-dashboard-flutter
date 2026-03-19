import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../models/app_notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notif;
  const NotificationCard({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: notif.isRead ? AppColors.glassBorder : (notif.color ?? AppColors.accentViolet).withValues(alpha: 0.3),
      glowColor: notif.isRead ? Colors.transparent : (notif.color ?? AppColors.accentViolet).withValues(alpha: 0.15),
      glowRadius: 16,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (notif.color ?? AppColors.accentViolet).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(notif.icon ?? Icons.notifications, size: 16, color: notif.color),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(notif.title, style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 13,
              color: notif.isRead ? AppColors.textSecondary : AppColors.textPrimary,
            ))),
            if (!notif.isRead)
              Container(width: 7, height: 7, decoration: BoxDecoration(
                color: notif.color, shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: (notif.color ?? AppColors.accentViolet).withValues(alpha: 0.6), blurRadius: 6)],
              )),
          ]),
          const SizedBox(height: 4),
          Text(notif.body, style: AppTextStyles.bodySmall.copyWith(height: 1.5),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Row(children: [
            GradientBadge(
              label: notif.category,
              gradient: LinearGradient(colors: [(notif.color ?? AppColors.accentViolet).withValues(alpha: 0.8), notif.color ?? AppColors.accentViolet]),
            ),
            const SizedBox(width: 8),
            Text(notif.time, style: AppTextStyles.bodySmall),
          ]),
        ])),
      ]),
    );
  }
}
