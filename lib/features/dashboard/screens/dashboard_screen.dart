import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../../../shared/widgets/staggered_entry.dart';
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
    final statsAsync = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers:[
          SliverToBoxAdapter(
            child: DashboardHeader(
              onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: statsAsync.isLoading
                ? const Row(
                  children:[
                    Expanded(child: Padding(padding: EdgeInsets.only(right: 16), child: BaseShimmer(height: 110))),
                    Expanded(child: Padding(padding: EdgeInsets.only(right: 16), child: BaseShimmer(height: 110))),
                    Expanded(child: Padding(padding: EdgeInsets.only(right: 16), child: BaseShimmer(height: 110))),
                    Expanded(child: Padding(padding: EdgeInsets.only(right: 16), child: BaseShimmer(height: 110))),
                  ],
                )
                : const StaggeredEntry(
                  delay: 0,
                  child: StatCardsRow(),
                ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, constraints) {
                final content = constraints.maxWidth > 900
                    ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Expanded(flex: 3, child: RevenueChartCard()),
                    SizedBox(width: 24),
                    Expanded(flex: 2, child: ApiUsageCard()),
                  ],
                )
                    : const Column(children:[
                  RevenueChartCard(),
                  SizedBox(height: 24),
                  ApiUsageCard(),
                ]);

                return StaggeredEntry(delay: 150, child: content);
              }),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, constraints) {
                final content = constraints.maxWidth > 900
                    ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Expanded(child: ActiveModelsCard()),
                    SizedBox(width: 24),
                    Expanded(child: SystemPerfCard()),
                    SizedBox(width: 24),
                    Expanded(child: RecentActivityCard()),
                  ],
                )
                    : const Column(children:[
                  ActiveModelsCard(),
                  SizedBox(height: 24),
                  SystemPerfCard(),
                  SizedBox(height: 24),
                  RecentActivityCard(),
                ]);

                return StaggeredEntry(delay: 300, child: content);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
