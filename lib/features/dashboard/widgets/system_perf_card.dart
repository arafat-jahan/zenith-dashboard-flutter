// lib/features/dashboard/widgets/system_perf_card.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class SystemPerfCard extends StatelessWidget {
  const SystemPerfCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: AppColors.glowGreen, glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('System Health', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 2),
        Text('Infrastructure performance', style: AppTextStyles.bodySmall),
        const SizedBox(height: 16),
        _MetricRow(label: 'CPU',        value: 0.34, color: AppColors.accentGreen),
        const SizedBox(height: 12),
        _MetricRow(label: 'Memory',     value: 0.67, color: AppColors.accentBlue),
        const SizedBox(height: 12),
        _MetricRow(label: 'GPU',        value: 0.89, color: AppColors.accentViolet),
        const SizedBox(height: 12),
        _MetricRow(label: 'Storage',    value: 0.45, color: AppColors.accentCyan),
        const SizedBox(height: 20),
        SizedBox(
          height: 80,
          child: BarChart(BarChartData(
            alignment: BarChartAlignment.spaceAround, maxY: 100,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
                getTitlesWidget: (v, m) {
                  const l = ['M','T','W','T','F','S','S'];
                  return Text(l[v.toInt() % l.length], style: AppTextStyles.labelSmall);
                },
              )),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: List.generate(7, (i) {
              final vals = [42.0,58.0,71.0,65.0,80.0,55.0,89.0];
              return BarChartGroupData(x: i, barRods: [BarChartRodData(
                toY: vals[i],
                color: i == 6 ? AppColors.accentViolet : AppColors.accentViolet.withOpacity(0.35),
                width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              )]);
            }),
          )),
        ),
      ]),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label; final double value; final Color color;
  const _MetricRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 72, child: Text(label, style: AppTextStyles.bodySmall)),
      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(value: value, minHeight: 5,
              backgroundColor: AppColors.bgElevated,
              valueColor: AlwaysStoppedAnimation<Color>(color)))),
      const SizedBox(width: 10),
      SizedBox(width: 36, child: Text('${(value*100).toInt()}%',
          style: AppTextStyles.labelSmall.copyWith(color: color), textAlign: TextAlign.right)),
    ]);
  }
}