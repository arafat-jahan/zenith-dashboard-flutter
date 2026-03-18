// lib/features/dashboard/widgets/revenue_chart_card.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class RevenueChartCard extends StatelessWidget {
  const RevenueChartCard({super.key});

  static const List<FlSpot> _spots = [
    FlSpot(0,32), FlSpot(1,41), FlSpot(2,38), FlSpot(3,53),
    FlSpot(4,48), FlSpot(5,67), FlSpot(6,72), FlSpot(7,88),
    FlSpot(8,79), FlSpot(9,95), FlSpot(10,102), FlSpot(11,128),
  ];

  static const List<String> _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: AppColors.glowViolet, glowRadius: 30,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Revenue', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 2),
            Text('Monthly recurring revenue', style: AppTextStyles.bodySmall),
          ]),
          GradientBadge(label: '+23.4% YoY', gradient: AppColors.violetGradient),
        ]),
        const SizedBox(height: 8),
        Text('\$128,450', style: AppTextStyles.metricHuge),
        const SizedBox(height: 20),
        SizedBox(
          height: 160,
          child: LineChart(LineChartData(
            gridData: FlGridData(
              show: true, drawVerticalLine: false, horizontalInterval: 30,
              getDrawingHorizontalLine: (v) => const FlLine(color: AppColors.glassBorder, strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true, interval: 2,
                getTitlesWidget: (v, meta) {
                  final i = v.toInt();
                  if (i < 0 || i >= _months.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_months[i], style: AppTextStyles.labelSmall),
                  );
                },
              )),
            ),
            borderData: FlBorderData(show: false),
            minX: 0, maxX: 11, minY: 0, maxY: 140,
            lineBarsData: [LineChartBarData(
              spots: _spots, isCurved: true, curveSmoothness: 0.35,
              color: AppColors.accentViolet, barWidth: 2.5, isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              shadow: const Shadow(color: AppColors.glowViolet, blurRadius: 12),
              belowBarData: BarAreaData(show: true, gradient: LinearGradient(
                colors: [AppColors.accentViolet.withOpacity(0.28), AppColors.accentViolet.withOpacity(0.0)],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
              )),
            )],
          )),
        ),
      ]),
    );
  }
}