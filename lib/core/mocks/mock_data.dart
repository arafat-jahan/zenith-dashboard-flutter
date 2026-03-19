import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../../features/dashboard/models/recent_activity.dart';
import '../../features/notifications/models/app_notification.dart';
import '../../features/api_keys/models/api_credential.dart';

class MockData {
  static List<RecentActivity> getRecentActivity() {
    return [
      const RecentActivity(
        title: 'New enterprise subscription',
        subtitle: 'Acme Corp — Ultra Plan',
        time: '2m ago',
        icon: LucideIcons.sparkles,
        color: AppColors.accentViolet,
      ),
      const RecentActivity(
        title: 'API rate limit alert',
        subtitle: 'User #48291 — resolved',
        time: '14m ago',
        icon: LucideIcons.alertTriangle,
        color: AppColors.accentAmber,
      ),
      const RecentActivity(
        title: 'Model fine-tune complete',
        subtitle: 'custom-v3 — 98.2% accuracy',
        time: '1h ago',
        icon: LucideIcons.checkCircle,
        color: AppColors.accentGreen,
      ),
      const RecentActivity(
        title: 'New region deployed',
        subtitle: 'AP-Southeast-2 online',
        time: '3h ago',
        icon: LucideIcons.globe,
        color: AppColors.accentBlue,
      ),
      const RecentActivity(
        title: 'Billing cycle renewed',
        subtitle: '243 accounts auto-renewed',
        time: '6h ago',
        icon: LucideIcons.creditCard,
        color: AppColors.accentCyan,
      ),
    ];
  }

  static List<AppNotification> getNotifications() {
    return [
      const AppNotification(title: 'Usage Alert: 80% of token quota', body: 'You have used 8B of your 10B monthly token limit. Consider upgrading.', time: '5 min ago', category: 'Billing', icon: LucideIcons.alertTriangle, color: AppColors.accentAmber),
      const AppNotification(title: 'New model: Zenith Ultra v3', body: 'Zenith Ultra v3 is now available with 40% faster inference and improved reasoning.', time: '1 hour ago', category: 'Updates', icon: LucideIcons.sparkles, color: AppColors.accentViolet),
      const AppNotification(title: 'API latency spike detected', body: 'US-East region experiencing elevated latency (avg 340ms). Engineers are investigating.', time: '3 hours ago', category: 'Incidents', icon: LucideIcons.alertCircle, color: AppColors.accentRose),
      const AppNotification(title: 'Fine-tune job completed', body: 'Your custom model "product-v2" has finished training. Accuracy: 97.3%.', time: '6 hours ago', category: 'Updates', icon: LucideIcons.checkCircle, color: AppColors.accentGreen, isRead: true),
      const AppNotification(title: 'Invoice generated: March 2025', body: 'Your monthly invoice of \$49.00 has been generated and will be charged on Apr 1.', time: '1 day ago', category: 'Billing', icon: LucideIcons.creditCard, color: AppColors.accentBlue, isRead: true),
      const AppNotification(title: 'New team member added', body: 'Sarah Chen has joined your workspace as Developer.', time: '2 days ago', category: 'Team', icon: LucideIcons.userPlus, color: AppColors.accentCyan, isRead: true),
      const AppNotification(title: 'Scheduled maintenance', body: 'Planned maintenance window on Apr 5, 2:00-4:00 AM UTC. Brief downtime expected.', time: '3 days ago', category: 'Incidents', icon: LucideIcons.wrench, color: AppColors.accentAmber, isRead: true),
      const AppNotification(title: 'Rate limit increased', body: 'Your Pro plan rate limit has been upgraded to 10,000 requests/minute.', time: '5 days ago', category: 'Updates', icon: LucideIcons.zap, color: AppColors.accentGreen, isRead: true),
    ];
  }

  static List<ApiCredential> getApiKeys() {
    return [
      const ApiCredential(name: 'Production API', key: 'zth-prod-••••••••••••••••3f8a', created: 'Jan 15, 2025', lastUsed: '2 hours ago', isActive: true, color: AppColors.accentGreen),
      const ApiCredential(name: 'Development Key', key: 'zth-dev-••••••••••••••••9c2d', created: 'Feb 3, 2025', lastUsed: '1 day ago', isActive: true, color: AppColors.accentBlue),
      const ApiCredential(name: 'CI/CD Pipeline', key: 'zth-ci-••••••••••••••••7b4e', created: 'Mar 1, 2025', lastUsed: '3 days ago', isActive: true, color: AppColors.accentViolet),
      const ApiCredential(name: 'Legacy Key', key: 'zth-old-••••••••••••••••1a5f', created: 'Dec 10, 2024', lastUsed: '45 days ago', isActive: false, color: AppColors.textMuted),
    ];
  }
}
