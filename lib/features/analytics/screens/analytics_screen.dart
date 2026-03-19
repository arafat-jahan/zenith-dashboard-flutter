// lib/features/analytics/screens/analytics_screen.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../widgets/widgets.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Analytics', style: AppTextStyles.displayMedium),
                    const SizedBox(height: 4),
                    Text('Deep dive into your platform metrics', style: AppTextStyles.bodyLarge),
                  ]),
                  GradientBadge(label: 'Last 30 days', gradient: AppColors.blueGradient),
                ],
              ),
            ),
          ),

          // Top KPI row
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                final cards = [
                  KpiCard(title: 'Total Requests', value: '48.3M', change: '+18%', color: AppColors.accentViolet),
                  KpiCard(title: 'Avg Latency', value: '94ms', change: '-12%', color: AppColors.accentCyan),
                  KpiCard(title: 'Error Rate', value: '0.03%', change: '-44%', color: AppColors.accentGreen),
                  KpiCard(title: 'Cost / 1K tokens', value: '\$0.002', change: '-8%', color: AppColors.accentBlue),
                ];
                if (c.maxWidth > 700) {
                  return Row(children: cards.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList());
                }
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: cards,
                );
              }),
            ),
          ),

          // Charts row
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                if (c.maxWidth > 900) {
                  return const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 3, child: RequestsChart()),
                    SizedBox(width: 16),
                    Expanded(flex: 2, child: ModelBreakdownCard()),
                  ]);
                }
                return const Column(children: [RequestsChart(), SizedBox(height: 16), ModelBreakdownCard()]);
              }),
            ),
          ),

          // Bottom row
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                if (c.maxWidth > 900) {
                  return const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: LatencyChart()),
                    SizedBox(width: 16),
                    Expanded(child: TopEndpointsCard()),
                  ]);
                }
                return const Column(children: [LatencyChart(), SizedBox(height: 16), TopEndpointsCard()]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
