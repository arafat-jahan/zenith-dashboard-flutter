import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_kit/theme/app_theme.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.primary, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ActivityItem(
            icon: LucideIcons.checkCircle,
            title: 'Model Deployed',
            description: 'GPT-4o deployed to production',
            time: '2m ago',
            iconColor: AppColors.primary,
          ),
          _ActivityItem(
            icon: LucideIcons.alertTriangle,
            title: 'API Rate Limit',
            description: 'Rate limit increased for Team Alpha',
            time: '15m ago',
            iconColor: AppColors.warning,
          ),
          _ActivityItem(
            icon: LucideIcons.refreshCcw,
            title: 'Data Sync Complete',
            description: 'Vector database synchronized with S3',
            time: '1h ago',
            iconColor: AppColors.primary,
          ),
          _ActivityItem(
            icon: LucideIcons.shieldCheck,
            title: 'Security Update',
            description: 'API authentication tokens rotated',
            time: '3h ago',
            iconColor: AppColors.primary,
          ),
          _ActivityItem(
            icon: LucideIcons.activity,
            title: 'High Latency Alert',
            description: 'Claude 3.5 Sonnet endpoint experiencing delays',
            time: '5h ago',
            iconColor: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final Color iconColor;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
