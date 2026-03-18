// lib/features/dashboard/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/glass_card.dart';
import '../widgets/stat_bento_card.dart';
import '../widgets/revenue_chart_card.dart';
import '../widgets/api_usage_card.dart';
import '../widgets/active_models_card.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/system_perf_card.dart';

import '../providers/dashboard_provider.dart';
import '../../../shared/widgets/gradient_badge.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _DashboardHeader(
              onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            sliver: SliverToBoxAdapter(
              child: stats.isLoading
                  ? const _StatsShimmer()
                  : _StatCardsRow(stats: stats),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, constraints) {
                if (constraints.maxWidth > 900) {
                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: RevenueChartCard()),
                      SizedBox(width: 16),
                      Expanded(flex: 2, child: ApiUsageCard()),
                    ],
                  );
                }
                return const Column(children: [
                  RevenueChartCard(),
                  SizedBox(height: 16),
                  ApiUsageCard(),
                ]);
              }),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, constraints) {
                if (constraints.maxWidth > 900) {
                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ActiveModelsCard()),
                      SizedBox(width: 16),
                      Expanded(child: SystemPerfCard()),
                      SizedBox(width: 16),
                      Expanded(child: RecentActivityCard()),
                    ],
                  );
                }
                return const Column(children: [
                  ActiveModelsCard(),
                  SizedBox(height: 16),
                  SystemPerfCard(),
                  SizedBox(height: 16),
                  RecentActivityCard(),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────
class _DashboardHeader extends ConsumerWidget {
  final VoidCallback onRefresh;
  const _DashboardHeader({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).value;
    final name = user?.name.split(' ').first ?? 'User';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    Text('Good morning, $name',
                        style: AppTextStyles.displayMedium),
                    const SizedBox(width: 8),
                    const Text('👋', style: TextStyle(fontSize: 22)),
                    if (user?.plan != 'free') ...[
                      const SizedBox(width: 12),
                      GradientBadge(
                        label: user?.plan.toUpperCase() ?? 'PRO',
                        gradient: AppColors.violetGradient,
                      ),
                    ],
                  ]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Here\'s what\'s happening with your platform today.',
                  style: AppTextStyles.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(children: [
            GlassCard(
              padding: const EdgeInsets.all(10),
              onTap: onRefresh,
              child: const Icon(LucideIcons.refreshCcw,
                  size: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 8),
            GlassCard(
              padding: const EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(LucideIcons.bell,
                      size: 16, color: AppColors.textSecondary),
                  Positioned(
                    top: -3, right: -3,
                    child: Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.accentRose,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppColors.accentRose, blurRadius: 6)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

// ── Stat Cards ────────────────────────────────────────────────────────────────
class _StatCardsRow extends StatelessWidget {
  final DashboardStats stats;
  const _StatCardsRow({required this.stats});

  String _fmt(double v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toStringAsFixed(0);
  String _fmtInt(int v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toString();

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatBentoCard(
        title: 'Revenue', value: '\$${_fmt(stats.totalRevenue)}',
        change: '+12.5%', isPositive: true,
        icon: LucideIcons.dollarSign,
        iconGradient: AppColors.violetGradient,
        glowColor: AppColors.glowViolet,
      ),
      StatBentoCard(
        title: 'Users', value: _fmtInt(stats.activeUsers),
        change: '+8.2%', isPositive: true,
        icon: LucideIcons.users,
        iconGradient: AppColors.blueGradient,
        glowColor: AppColors.glowBlue,
      ),
      StatBentoCard(
        title: 'API Calls',
        value: '${(stats.apiCalls / 1000000).toStringAsFixed(1)}M',
        change: '+31.7%', isPositive: true,
        icon: LucideIcons.zap,
        iconGradient: AppColors.greenGradient,
        glowColor: AppColors.glowGreen,
      ),
      StatBentoCard(
        title: 'Uptime', value: '${stats.successRate}%',
        change: '-0.1%', isPositive: false,
        icon: LucideIcons.shieldCheck,
        iconGradient: AppColors.roseGradient,
        glowColor: AppColors.glowCyan,
      ),
    ];

    return LayoutBuilder(builder: (ctx, constraints) {
      if (constraints.maxWidth > 700) {
        return Row(
          children: cards
              .map((c) => Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 12), child: c),
          ))
              .toList(),
        );
      }
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: cards,
      );
    });
  }
}

// ── Shimmer ───────────────────────────────────────────────────────────────────
class _StatsShimmer extends StatefulWidget {
  const _StatsShimmer();
  @override
  State<_StatsShimmer> createState() => _StatsShimmerState();
}

class _StatsShimmerState extends State<_StatsShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Row(
        children: List.generate(
          4,
              (i) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Color.lerp(
                      AppColors.bgSurface, AppColors.bgElevated, _anim.value),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.glassBorder),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}