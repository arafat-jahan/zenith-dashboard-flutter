// lib/features/analytics/screens/analytics_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

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
                  _KpiCard(title: 'Total Requests', value: '48.3M', change: '+18%', color: AppColors.accentViolet),
                  _KpiCard(title: 'Avg Latency', value: '94ms', change: '-12%', color: AppColors.accentCyan),
                  _KpiCard(title: 'Error Rate', value: '0.03%', change: '-44%', color: AppColors.accentGreen),
                  _KpiCard(title: 'Cost / 1K tokens', value: '\$0.002', change: '-8%', color: AppColors.accentBlue),
                ];
                if (c.maxWidth > 700) {
                  return Row(children: cards.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList());
                }
                return GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.6, children: cards);
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
                    Expanded(flex: 3, child: _RequestsChart()),
                    SizedBox(width: 16),
                    Expanded(flex: 2, child: _ModelBreakdownCard()),
                  ]);
                }
                return const Column(children: [_RequestsChart(), SizedBox(height: 16), _ModelBreakdownCard()]);
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
                    Expanded(child: _LatencyChart()),
                    SizedBox(width: 16),
                    Expanded(child: _TopEndpointsCard()),
                  ]);
                }
                return const Column(children: [_LatencyChart(), SizedBox(height: 16), _TopEndpointsCard()]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title, value, change;
  final Color color;
  const _KpiCard({required this.title, required this.value, required this.change, required this.color});

  @override
  Widget build(BuildContext context) {
    final isPos = change.startsWith('-') ? title == 'Error Rate' || title == 'Avg Latency' || title == 'Cost / 1K tokens' : true;
    return GlassCard(
      glowColor: color.withOpacity(0.3),
      glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: AppTextStyles.bodySmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: (isPos ? AppColors.accentGreen : AppColors.accentRose).withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(change, style: AppTextStyles.labelSmall.copyWith(
              color: isPos ? AppColors.accentGreen : AppColors.accentRose,
              fontWeight: FontWeight.w700,
            )),
          ),
        ]),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles.metricLarge.copyWith(color: color)),
      ]),
    );
  }
}

class _RequestsChart extends StatelessWidget {
  const _RequestsChart();

  @override
  Widget build(BuildContext context) {
    final spots = [
      const FlSpot(0, 1.2), const FlSpot(1, 1.8), const FlSpot(2, 1.5),
      const FlSpot(3, 2.3), const FlSpot(4, 2.1), const FlSpot(5, 2.9),
      const FlSpot(6, 3.4), const FlSpot(7, 3.1), const FlSpot(8, 3.8),
      const FlSpot(9, 4.2), const FlSpot(10, 3.9), const FlSpot(11, 4.8),
    ];
    return GlassCard(
      glowColor: AppColors.glowBlue,
      glowRadius: 24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('API Requests', style: AppTextStyles.headlineMedium),
            Text('Millions per month', style: AppTextStyles.bodySmall),
          ]),
          GradientBadge(label: '+18% MoM', gradient: AppColors.blueGradient),
        ]),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: LineChart(LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1,
                getDrawingHorizontalLine: (_) => const FlLine(color: AppColors.glassBorder, strokeWidth: 1)),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 2,
                getTitlesWidget: (v, _) {
                  const m = ['J','F','M','A','M','J','J','A','S','O','N','D'];
                  final i = v.toInt();
                  if (i < 0 || i >= m.length) return const SizedBox();
                  return Padding(padding: const EdgeInsets.only(top: 6), child: Text(m[i], style: AppTextStyles.labelSmall));
                },
              )),
            ),
            borderData: FlBorderData(show: false),
            minX: 0, maxX: 11, minY: 0, maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: spots, isCurved: true, curveSmoothness: 0.3,
                color: AppColors.accentBlue, barWidth: 2.5, isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                shadow: const Shadow(color: AppColors.glowBlue, blurRadius: 12),
                belowBarData: BarAreaData(show: true, gradient: LinearGradient(
                  colors: [AppColors.accentBlue.withOpacity(0.25), Colors.transparent],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                )),
              ),
            ],
          )),
        ),
      ]),
    );
  }
}

class _ModelBreakdownCard extends StatelessWidget {
  const _ModelBreakdownCard();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Zenith Ultra', '2.1B tokens', AppColors.accentViolet, 0.44),
      ('Zenith Pro', '1.4B tokens', AppColors.accentBlue, 0.29),
      ('Zenith Flash', '0.8B tokens', AppColors.accentCyan, 0.17),
      ('Zenith Nano', '0.5B tokens', AppColors.accentGreen, 0.10),
    ];
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Model Usage Breakdown', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Token consumption by model', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: item.$3, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: item.$3.withOpacity(0.6), blurRadius: 6)])),
                const SizedBox(width: 8),
                Text(item.$1, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
              ]),
              Text(item.$2, style: AppTextStyles.bodySmall),
            ]),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(value: item.$4, minHeight: 5,
                  backgroundColor: AppColors.bgElevated,
                  valueColor: AlwaysStoppedAnimation<Color>(item.$3)),
            ),
          ]),
        )),
      ]),
    );
  }
}

class _LatencyChart extends StatelessWidget {
  const _LatencyChart();

  @override
  Widget build(BuildContext context) {
    final data = [180.0, 220.0, 195.0, 160.0, 140.0, 175.0, 94.0];
    return GlassCard(
      glowColor: AppColors.glowCyan,
      glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Avg Latency', style: AppTextStyles.headlineMedium),
            Text('Milliseconds per request', style: AppTextStyles.bodySmall),
          ]),
          GradientBadge(label: '94ms avg', gradient: AppColors.blueGradient),
        ]),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: BarChart(BarChartData(
            alignment: BarChartAlignment.spaceAround, maxY: 250,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
                getTitlesWidget: (v, _) {
                  const l = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                  final i = v.toInt();
                  if (i < 0 || i >= l.length) return const SizedBox();
                  return Padding(padding: const EdgeInsets.only(top: 6),
                      child: Text(l[i], style: AppTextStyles.labelSmall));
                },
              )),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: List.generate(data.length, (i) => BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: data[i],
                color: i == 6 ? AppColors.accentCyan : AppColors.accentCyan.withOpacity(0.3),
                width: 20, borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ])),
          )),
        ),
      ]),
    );
  }
}

class _TopEndpointsCard extends StatelessWidget {
  const _TopEndpointsCard();

  @override
  Widget build(BuildContext context) {
    final endpoints = [
      ('/v1/chat/completions', '18.2M', AppColors.accentViolet),
      ('/v1/embeddings', '9.4M', AppColors.accentBlue),
      ('/v1/completions', '7.1M', AppColors.accentCyan),
      ('/v1/fine-tunes', '3.8M', AppColors.accentGreen),
      ('/v1/images/generate', '2.1M', AppColors.accentAmber),
    ];
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Top Endpoints', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('By total requests this month', style: AppTextStyles.bodySmall),
        const SizedBox(height: 16),
        ...endpoints.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(
              color: e.$3, shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: e.$3.withOpacity(0.6), blurRadius: 6)],
            )),
            const SizedBox(width: 10),
            Expanded(child: Text(e.$1, style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary, fontFamily: 'monospace'))),
            Text(e.$2, style: AppTextStyles.labelLarge.copyWith(color: e.$3)),
          ]),
        )),
      ]),
    );
  }
}