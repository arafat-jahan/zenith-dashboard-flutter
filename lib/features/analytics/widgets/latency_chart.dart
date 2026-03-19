import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class LatencyChart extends StatelessWidget {
  const LatencyChart({super.key});

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
                color: i == 6 ? AppColors.accentCyan : AppColors.accentCyan.withValues(alpha: 0.3),
                width: 20, borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ])),
          )),
        ),
      ]),
    );
  }
}
