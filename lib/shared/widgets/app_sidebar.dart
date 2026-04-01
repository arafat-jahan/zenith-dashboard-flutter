// lib/shared/widgets/app_sidebar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/providers/nav_provider.dart';
import '../../core/providers/nav_config.dart';
import '../../core/constants/app_strings.dart';
import '../../features/auth/providers/auth_provider.dart';

class AppSidebarFull extends ConsumerWidget {
  const AppSidebarFull({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedNavIndexProvider);
    final user = ref.watch(userProfileProvider).value;

    return Container(
      width: 240, // Standard width for 8-point grid
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        border: Border(right: BorderSide(color: AppColors.glassBorder)),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(children:[
                // Logo - 8-point grid padding: 32 (4*8) top, 24 (3*8) sides/bottom
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Row(children:[
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        gradient: AppColors.violetGradient,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 18)],
                      ),
                      child: const Icon(LucideIcons.zap, size: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(AppStrings.appName, style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
                  ]),
                ),

                // Platform Section
                _SectionHeader(title: AppStrings.navPlatform),
                ...NavConfig.getPlatformItems(user).asMap().entries.map((entry) => _Item(
                  item: entry.value,
                  index: entry.key,
                  selected: selected,
                  ref: ref,
                  badge: entry.value.label == 'Notifications' ? '3' : null,
                )),

                const Spacer(),

                // Account Section
                _SectionHeader(title: AppStrings.navAccount),
                ...NavConfig.accountItems.asMap().entries.map((entry) {
                  final index = NavConfig.getPlatformItems(user).length + entry.key;
                  return _Item(
                    item: entry.value,
                    index: index,
                    selected: selected,
                    ref: ref,
                  );
                }),

                // User card - 16px padding
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bgElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(children:[
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        gradient: AppColors.blueGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
                      Text(AppStrings.userName, style: AppTextStyles.headlineSmall.copyWith(fontSize: 12)),
                      Text(AppStrings.userPlan, style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet, fontSize: 10)),
                    ])),
                    const Icon(LucideIcons.chevronsUpDown, size: 14, color: AppColors.textMuted),
                  ]),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2, color: AppColors.textMuted)),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final NavItem item;
  final int index, selected;
  final WidgetRef ref;
  final String? badge;

  const _Item({
    required this.item,
    required this.index,
    required this.selected,
    required this.ref,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isSel = selected == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InkWell(
        onTap: () => ref.read(selectedNavIndexProvider.notifier).state = index,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSel ? AppColors.accentViolet.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSel ? Border.all(color: AppColors.accentViolet.withValues(alpha: 0.3)) : null,
          ),
          child: Row(children:[
            Icon(item.icon, size: 18,
                color: isSel ? AppColors.accentViolet : AppColors.textMuted),
            const SizedBox(width: 12),
            Expanded(
              child: Text(item.label, style: AppTextStyles.bodyMedium.copyWith(
                color: isSel ? AppColors.accentViolet : AppColors.textSecondary,
                fontWeight: isSel ? FontWeight.w600 : FontWeight.w400,
              )),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accentRose,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(badge!,
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
              ),
          ]),
        ),
      ),
    );
  }
}
