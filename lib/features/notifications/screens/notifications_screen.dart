// lib/features/notifications/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../providers/notifications_provider.dart';
import '../widgets/notification_card.dart';

final _notifFilterProvider = StateProvider<String>((ref) => 'All');

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_notifFilterProvider);
    final notifsAsync = ref.watch(notificationsProvider);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final hPadding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(hPadding, 28, hPadding, 20),
              child: isMobile 
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Notifications', style: AppTextStyles.displayMedium),
                          _MarkReadAllBtn(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Stay on top of your platform activity', style: AppTextStyles.bodyLarge),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Notifications', style: AppTextStyles.displayMedium),
                        const SizedBox(height: 4),
                        Text('Stay on top of your platform activity', style: AppTextStyles.bodyLarge),
                      ]),
                      _MarkReadAllBtn(),
                    ],
                  ),
            ),
          ),

          // Filters
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              child: Row(children: ['All', 'Billing', 'Updates', 'Incidents', 'Team'].map((f) {
                final isSelected = filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => ref.read(_notifFilterProvider.notifier).state = f,
                    borderRadius: BorderRadius.circular(100),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.accentViolet : AppColors.bgGlass,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: isSelected ? AppColors.accentViolet : AppColors.glassBorder),
                        boxShadow: isSelected ? [BoxShadow(color: AppColors.glowViolet, blurRadius: 12)] : null,
                      ),
                      child: Text(f, style: AppTextStyles.labelLarge.copyWith(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      )),
                    ),
                  ),
                );
              }).toList()),
            ),
          ),

          // Notif list
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPadding, 24, hPadding, 40),
            sliver: notifsAsync.when(
              data: (notifs) {
                final filtered = filter == 'All' ? notifs : notifs.where((n) => n.category == filter).toList();
                if (filtered.isEmpty) {
                  return const SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('No notifications in this category')));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NotificationCard(notif: filtered[i]),
                    ),
                    childCount: filtered.length,
                  ),
                );
              },
              loading: () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: BaseShimmer(height: 80),
                  ),
                  childCount: 5,
                ),
              ),
              error: (err, _) => SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('Error: $err'))),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkReadAllBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.check, size: 14, color: AppColors.accentViolet),
          const SizedBox(width: 6),
          Text('Mark all read', style: AppTextStyles.labelLarge.copyWith(color: AppColors.accentViolet)),
        ],
      ),
    );
  }
}
