import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class RequestsChart extends StatelessWidget {
  const RequestsChart({super.key});

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
                  colors: [AppColors.accentBlue.withValues(alpha: 0.25), Colors.transparent],
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
