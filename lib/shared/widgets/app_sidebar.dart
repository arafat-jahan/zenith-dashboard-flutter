// lib/shared/widgets/app_sidebar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/providers/nav_provider.dart';

class AppSidebarFull extends ConsumerWidget {
  const AppSidebarFull({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedNavIndexProvider);

    return Container(
      width: 220,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        border: Border(right: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Column(children: [
        // Logo
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          child: Row(children: [
            Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                gradient: AppColors.violetGradient,
                borderRadius: BorderRadius.circular(9),
                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 18)],
              ),
              child: const Icon(LucideIcons.zap, size: 17, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text('Zenith AI', style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w700)),
          ]),
        ),

        // Platform nav
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('PLATFORM', style: AppTextStyles.labelSmall),
          ),
        ),
        _Item(label: 'Dashboard',     icon: LucideIcons.layout,          index: 0, selected: selected, ref: ref),
        _Item(label: 'AI Playground', icon: LucideIcons.bot,             index: 1, selected: selected, ref: ref),
        _Item(label: 'Analytics',     icon: LucideIcons.barChart,        index: 2, selected: selected, ref: ref),
        _Item(label: 'API Keys',      icon: LucideIcons.key,             index: 3, selected: selected, ref: ref),
        _Item(label: 'Notifications', icon: LucideIcons.bell,            index: 4, selected: selected, ref: ref, badge: '3'),
        _Item(label: 'Pricing',       icon: LucideIcons.creditCard,      index: 5, selected: selected, ref: ref),

        const Spacer(),

        // Account nav
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('ACCOUNT', style: AppTextStyles.labelSmall),
          ),
        ),
        _Item(label: 'Settings', icon: LucideIcons.settings, index: 6, selected: selected, ref: ref),

        // User card
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.bgElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(children: [
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
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('John Dev', style: AppTextStyles.headlineSmall.copyWith(fontSize: 12)),
              Text('Pro Plan', style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet, fontSize: 10)),
            ])),
            const Icon(LucideIcons.chevronsUpDown, size: 14, color: AppColors.textMuted),
          ]),
        ),
      ]),
    );
  }
}

// Alias — পুরানো কোড যাতে না ভাঙে
typedef AppSidebar = AppSidebarFull;

// Nav item widget
class _Item extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index, selected;
  final WidgetRef ref;
  final String? badge;

  const _Item({
    required this.label,
    required this.icon,
    required this.index,
    required this.selected,
    required this.ref,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isSel = selected == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
          child: Row(children: [
            Icon(icon, size: 16,
                color: isSel ? AppColors.accentViolet : AppColors.textMuted),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label, style: AppTextStyles.bodyMedium.copyWith(
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

