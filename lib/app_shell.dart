// lib/app_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/nav_provider.dart';
import 'core/theme/app_colors.dart';
import 'shared/widgets/app_sidebar.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/chat/screens/chat_screen.dart';
import 'features/pricing/screens/pricing_screen.dart';
import 'features/analytics/screens/analytics_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/api_keys/screens/api_keys_screen.dart';
import 'features/notifications/screens/notifications_screen.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const List<Widget> _screens = [
    DashboardScreen(),
    ChatScreen(),
    AnalyticsScreen(),
    ApiKeysScreen(),
    NotificationsScreen(),
    PricingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(selectedNavIndexProvider);
    final isWide = MediaQuery.of(context).size.width > 720;

    if (isWide) {
      return Scaffold(
        backgroundColor: AppColors.bgDeep,
        body: Row(children: [
          const AppSidebarFull(),
          Expanded(
            child: ClipRect(
              child: _screens[index.clamp(0, _screens.length - 1)],
            ),
          ),
        ]),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: _screens[index.clamp(0, _screens.length - 1)],
      bottomNavigationBar: _MobileNav(
        currentIndex: index.clamp(0, 4),
        onTap: (i) => ref.read(selectedNavIndexProvider.notifier).state = i,
      ),
    );
  }
}

class _MobileNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _MobileNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accentViolet,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_outlined), label: 'AI Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: 'Analytics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.key_outlined), label: 'API Keys'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: 'Alerts'),
        ],
      ),
    );
  }
}