// lib/features/notifications/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class _Notif {
  final String title, body, time, category;
  final IconData icon;
  final Color color;
  final bool isRead;
  const _Notif({required this.title, required this.body, required this.time, required this.category, required this.icon, required this.color, this.isRead = false});
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _filter = 'All';

  final List<_Notif> _notifs = const [
    _Notif(title: 'Usage Alert: 80% of token quota', body: 'You have used 8B of your 10B monthly token limit. Consider upgrading.', time: '5 min ago', category: 'Billing', icon: LucideIcons.alertTriangle, color: AppColors.accentAmber),
    _Notif(title: 'New model: Zenith Ultra v3', body: 'Zenith Ultra v3 is now available with 40% faster inference and improved reasoning.', time: '1 hour ago', category: 'Updates', icon: LucideIcons.sparkles, color: AppColors.accentViolet),
    _Notif(title: 'API latency spike detected', body: 'US-East region experiencing elevated latency (avg 340ms). Engineers are investigating.', time: '3 hours ago', category: 'Incidents', icon: LucideIcons.alertCircle, color: AppColors.accentRose),
    _Notif(title: 'Fine-tune job completed', body: 'Your custom model "product-v2" has finished training. Accuracy: 97.3%.', time: '6 hours ago', category: 'Updates', icon: LucideIcons.checkCircle2, color: AppColors.accentGreen, isRead: true),
    _Notif(title: 'Invoice generated: March 2025', body: 'Your monthly invoice of \$49.00 has been generated and will be charged on Apr 1.', time: '1 day ago', category: 'Billing', icon: LucideIcons.creditCard, color: AppColors.accentBlue, isRead: true),
    _Notif(title: 'New team member added', body: 'Sarah Chen has joined your workspace as Developer.', time: '2 days ago', category: 'Team', icon: LucideIcons.userPlus, color: AppColors.accentCyan, isRead: true),
    _Notif(title: 'Scheduled maintenance', body: 'Planned maintenance window on Apr 5, 2:00-4:00 AM UTC. Brief downtime expected.', time: '3 days ago', category: 'Incidents', icon: LucideIcons.wrench, color: AppColors.accentAmber, isRead: true),
    _Notif(title: 'Rate limit increased', body: 'Your Pro plan rate limit has been upgraded to 10,000 requests/minute.', time: '5 days ago', category: 'Updates', icon: LucideIcons.zap, color: AppColors.accentGreen, isRead: true),
  ];

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Billing', 'Updates', 'Incidents', 'Team'];
    final unread = _notifs.where((n) => !n.isRead).length;
    final filtered = _filter == 'All' ? _notifs : _notifs.where((n) => n.category == _filter).toList();

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text('Notifications', style: AppTextStyles.displayMedium),
                      if (unread > 0) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: AppColors.roseGradient,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text('$unread new', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                        ),
                      ],
                    ]),
                    const SizedBox(height: 4),
                    Text('Stay on top of your platform activity', style: AppTextStyles.bodyLarge),
                  ]),
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    onTap: () {},
                    child: Row(children: [
                      const Icon(LucideIcons.checkCheck, size: 14, color: AppColors.accentViolet),
                      const SizedBox(width: 6),
                      Text('Mark all read', style: AppTextStyles.labelLarge.copyWith(color: AppColors.accentViolet)),
                    ]),
                  ),
                ],
              ),
            ),
          ),

          // Filter chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                itemCount: filters.length,
                itemBuilder: (_, i) {
                  final f = filters[i];
                  final isSelected = _filter == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _filter = f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.violetGradient : null,
                          color: isSelected ? null : AppColors.bgSurface,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: isSelected ? Colors.transparent : AppColors.glassBorder),
                        ),
                        child: Text(f, style: AppTextStyles.labelLarge.copyWith(
                          color: isSelected ? Colors.white : AppColors.textMuted,
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Notifications list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NotifCard(notif: filtered[i]),
                ),
                childCount: filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final _Notif notif;
  const _NotifCard({required this.notif});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: notif.isRead ? AppColors.glassBorder : notif.color.withOpacity(0.3),
      glowColor: notif.isRead ? Colors.transparent : notif.color.withOpacity(0.15),
      glowRadius: 16,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: notif.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(notif.icon, size: 16, color: notif.color),
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
                boxShadow: [BoxShadow(color: notif.color.withOpacity(0.6), blurRadius: 6)],
              )),
          ]),
          const SizedBox(height: 4),
          Text(notif.body, style: AppTextStyles.bodySmall.copyWith(height: 1.5),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Row(children: [
            GradientBadge(
              label: notif.category,
              gradient: LinearGradient(colors: [notif.color.withOpacity(0.8), notif.color]),
            ),
            const SizedBox(width: 8),
            Text(notif.time, style: AppTextStyles.bodySmall),
          ]),
        ])),
      ]),
    );
  }
}