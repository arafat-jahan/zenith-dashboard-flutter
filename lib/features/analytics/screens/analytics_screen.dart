import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../shared/widgets/staggered_entry.dart';
import '../../dashboard/providers/dashboard_provider.dart'; // Corrected path
import '../widgets/widgets.dart';

class AnalyticsScreen extends ConsumerWidget { // Convert to ConsumerWidget
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add ref
    final statsAsync = ref.watch(dashboardProvider); // Watch provider
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final hPadding = isMobile ? 16.0 : 24.0;
    
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          // Header - 24px sides, 32px top
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(hPadding, 32, hPadding, 24),
              child: isMobile 
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Analytics', style: AppTextStyles.displayMedium),
                          const GradientBadge(label: 'Last 30 days', gradient: AppColors.blueGradient),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Deep dive into your platform metrics', style: AppTextStyles.bodyLarge),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Analytics', style: AppTextStyles.displayMedium),
                        const SizedBox(height: 4),
                        Text('Deep dive into your platform metrics', style: AppTextStyles.bodyLarge),
                      ]),
                      const GradientBadge(label: 'Last 30 days', gradient: AppColors.blueGradient),
                    ],
                  ),
            ),
          ),

          // Top KPI row - 24px horizontal, 16px gap
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, 16),
            sliver: SliverToBoxAdapter(
              child: StaggeredEntry(
                delay: 0,
                child: LayoutBuilder(builder: (ctx, c) {
                  final cards = [
                    const KpiCard(title: 'Total Requests', value: '48.3M', change: '+18%', color: AppColors.accentViolet),
                    const KpiCard(title: 'Avg Latency', value: '94ms', change: '-12%', color: AppColors.accentCyan),
                    const KpiCard(title: 'Error Rate', value: '0.03%', change: '-44%', color: AppColors.accentGreen),
                    const KpiCard(title: 'Cost / 1K tokens', value: '\$0.002', change: '-8%', color: AppColors.accentBlue),
                  ];
                  if (c.maxWidth > 700) {
                    return Row(children: cards.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: w))).toList());
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.4, // Increased from 1.6 to provide more vertical space
                    children: cards,
                  );
                }),
              ),
            ),
          ),

          // Charts row - 24px sides, 24px vertical gap
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPadding, 8, hPadding, 24),
            sliver: SliverToBoxAdapter(
              child: StaggeredEntry(
                delay: 150,
                child: LayoutBuilder(builder: (ctx, c) {
                  if (c.maxWidth > 900) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: RequestsChart(isLoading: statsAsync.isLoading)),
                        const SizedBox(width: 24),
                        const Expanded(flex: 2, child: ModelBreakdownCard()),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RequestsChart(isLoading: statsAsync.isLoading),
                      const SizedBox(height: 24),
                      const ModelBreakdownCard(),
                    ],
                  );
                }),
              ),
            ),
          ),

          // Bottom row
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, 40),
            sliver: SliverToBoxAdapter(
              child: StaggeredEntry(
                delay: 300,
                child: LayoutBuilder(builder: (ctx, c) {
                  if (c.maxWidth > 900) {
                    return const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(child: LatencyChart()),
                      SizedBox(width: 24),
                      Expanded(child: TopEndpointsCard()),
                    ]);
                  }
                  return const Column(children: [LatencyChart(), SizedBox(height: 24), TopEndpointsCard()]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

