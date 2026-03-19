// lib/features/dashboard/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../widgets/active_models_card.dart';
import '../widgets/api_usage_card.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/revenue_chart_card.dart';
import '../widgets/stat_cards_row.dart';
import '../widgets/system_perf_card.dart';
import '../providers/dashboard_provider.dart';

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
            child: DashboardHeader(
              onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            sliver: SliverToBoxAdapter(
              child: stats.isLoading
                  ? const Row(
                      children: [
                        Expanded(child: Padding(padding: EdgeInsets.only(right: 12), child: BaseShimmer(height: 110))),
                        Expanded(child: Padding(padding: EdgeInsets.only(right: 12), child: BaseShimmer(height: 110))),
                        Expanded(child: Padding(padding: EdgeInsets.only(right: 12), child: BaseShimmer(height: 110))),
                        Expanded(child: Padding(padding: EdgeInsets.only(right: 12), child: BaseShimmer(height: 110))),
                      ],
                    )
                  : StatCardsRow(stats: stats),
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
