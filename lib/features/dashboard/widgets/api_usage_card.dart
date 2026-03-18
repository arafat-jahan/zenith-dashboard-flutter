// lib/features/dashboard/widgets/api_usage_card.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class ApiUsageCard extends StatelessWidget {
  const ApiUsageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: AppColors.glowCyan, glowRadius: 24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('API Usage', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 2),
        Text('Token distribution by model', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        Row(children: [
          SizedBox(
            width: 120, height: 120,
            child: PieChart(PieChartData(
              sectionsSpace: 3, centerSpaceRadius: 32,
              sections: [
                PieChartSectionData(color: AppColors.accentViolet, value: 45, radius: 22, title: ''),
                PieChartSectionData(color: AppColors.accentBlue,   value: 30, radius: 22, title: ''),
                PieChartSectionData(color: AppColors.accentCyan,   value: 15, radius: 22, title: ''),
                PieChartSectionData(color: AppColors.accentGreen,  value: 10, radius: 22, title: ''),
              ],
            )),
          ),
          const SizedBox(width: 20),
          Expanded(child: Column(children: [
            _LegendRow(color: AppColors.accentViolet, label: 'Zenith Ultra',  value: '45%'),
            const SizedBox(height: 10),
            _LegendRow(color: AppColors.accentBlue,   label: 'Zenith Pro',    value: '30%'),
            const SizedBox(height: 10),
            _LegendRow(color: AppColors.accentCyan,   label: 'Zenith Flash',  value: '15%'),
            const SizedBox(height: 10),
            _LegendRow(color: AppColors.accentGreen,  label: 'Zenith Nano',   value: '10%'),
          ])),
        ]),
        const SizedBox(height: 16),
        _TokenBar(used: 3.8, total: 10.0),
      ]),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color; final String label; final String value;
  const _LegendRow({required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(
        color: color, shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 6)],
      )),
      const SizedBox(width: 8),
      Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
      Text(value, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
    ]);
  }
}

class _TokenBar extends StatelessWidget {
  final double used; final double total;
  const _TokenBar({required this.used, required this.total});

  @override
  Widget build(BuildContext context) {
    final pct = used / total;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${used}B / ${total}B tokens', style: AppTextStyles.bodySmall),
        Text('${(pct * 100).toStringAsFixed(0)}% used',
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentCyan)),
      ]),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: LinearProgressIndicator(
          value: pct, minHeight: 5,
          backgroundColor: AppColors.bgElevated,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
        ),
      ),
    ]);
  }
}