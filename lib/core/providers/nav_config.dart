import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../../features/analytics/screens/analytics_screen.dart';
import '../../features/api_keys/screens/api_keys_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/pricing/screens/pricing_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../core/models/user_model.dart';

class NavItem {
  final String label;
  final IconData icon;
  final Widget screen;
  final bool isAccount;

  const NavItem({
    required this.label,
    required this.icon,
    required this.screen,
    this.isAccount = false,
  });
}

class NavConfig {
  static List<NavItem> getPlatformItems(UserModel? user) {
    final items = [
      const NavItem(label: 'Dashboard', icon: LucideIcons.layout, screen: DashboardScreen()),
      const NavItem(label: 'AI Playground', icon: LucideIcons.bot, screen: ChatScreen()),
      const NavItem(label: 'Analytics', icon: LucideIcons.barChart, screen: AnalyticsScreen()),
      const NavItem(label: 'API Keys', icon: LucideIcons.key, screen: ApiKeysScreen()),
      const NavItem(label: 'Notifications', icon: LucideIcons.bell, screen: NotificationsScreen()),
      const NavItem(label: 'Pricing', icon: LucideIcons.creditCard, screen: PricingScreen()),
    ];

    // Add admin dashboard only for admin users
    if (user?.role == 'admin') {
      items.insert(1, const NavItem(label: 'Admin', icon: LucideIcons.shield, screen: AdminDashboardScreen()));
    }

    return items;
  }

  static final List<NavItem> accountItems = [
    const NavItem(label: 'Settings', icon: LucideIcons.settings, screen: SettingsScreen(), isAccount: true),
  ];

  static List<NavItem> getAllItems(UserModel? user) => [...getPlatformItems(user), ...accountItems];
}
