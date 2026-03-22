// lib/app_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'core/providers/nav_provider.dart';
import 'core/providers/nav_config.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
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
          Expanded(child: ClipRect(child: currentScreen)),
        ]),
      );
    }

    // Mobile: প্রথম ৪টা + "More" বাটন
    final bottomIndex = index < 4 ? index : 4;

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: currentScreen,
      bottomNavigationBar: _MobileNav(
        currentIndex: bottomIndex,
        onTap: (i) {
          if (i == 4) {
            // More বাটন চাপলে bottom sheet খুলবে
            _showMoreSheet(context, ref, index);
          } else {
            ref.read(selectedNavIndexProvider.notifier).state = i;
          }
        },
      ),
    );
  }

  void _showMoreSheet(BuildContext context, WidgetRef ref, int currentIndex) {
    // More-এর ভেতরে যা থাকবে: Notifications(4), Pricing(5), Settings(6)
    final moreItems = [
      (index: 4, icon: LucideIcons.bell, label: 'Notifications'),
      (index: 5, icon: LucideIcons.creditCard, label: 'Pricing'),
      (index: 6, icon: LucideIcons.settings, label: 'Settings'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.textMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...moreItems.map((item) => ListTile(
              leading: Icon(
                item.icon,
                color: currentIndex == item.index
                    ? AppColors.accentViolet
                    : AppColors.textMuted,
                size: 20,
              ),
              title: Text(
                item.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: currentIndex == item.index
                      ? AppColors.accentViolet
                      : AppColors.textPrimary,
                  fontWeight: currentIndex == item.index
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ref.read(selectedNavIndexProvider.notifier).state = item.index;
              },
            )),
          ],
        ),
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
    // প্রথম ৪টা item + More
    final mainItems = NavConfig.platformItems.take(4).toList();

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
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          ...mainItems.map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon, size: 20),
            activeIcon: Icon(item.icon, size: 20),
            label: item.label,
          )),
          // More বাটন
          const BottomNavigationBarItem(
            icon: Icon(LucideIcons.moreHorizontal, size: 20),
            activeIcon: Icon(LucideIcons.moreHorizontal, size: 20),
            label: 'More',
          ),
        ],
      ),
    );
  }
}