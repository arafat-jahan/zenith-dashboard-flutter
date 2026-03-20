// lib/app_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/nav_provider.dart';
import 'core/providers/nav_config.dart';
import 'core/theme/app_colors.dart';
import 'shared/widgets/app_sidebar.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(selectedNavIndexProvider);
    final allItems = NavConfig.allItems;
    final isWide = MediaQuery.of(context).size.width > 900;

    final currentScreen = allItems[index.clamp(0, allItems.length - 1)].screen;

    if (isWide) {
      return Scaffold(
        backgroundColor: AppColors.bgDeep,
        body: Row(children: [
          const AppSidebarFull(),
          Expanded(
            child: ClipRect(
              child: currentScreen,
            ),
          ),
        ]),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: currentScreen,
      bottomNavigationBar: _MobileNav(
        currentIndex: index.clamp(0, NavConfig.platformItems.length - 1),
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
    // Show all platform items in mobile bottom bar
    final items = NavConfig.platformItems;

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
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: items.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon, size: 20),
          activeIcon: Icon(item.icon, size: 20),
          label: item.label,
        )).toList(),
      ),
    );
  }
}
