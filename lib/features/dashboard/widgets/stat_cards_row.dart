import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/dashboard_provider.dart';
import 'stat_bento_card.dart';

class StatCardsRow extends StatelessWidget {
  final DashboardStats stats;
  const StatCardsRow({super.key, required this.stats});

  String _fmt(double v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toStringAsFixed(0);
  String _fmtInt(int v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toString();

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatBentoCard(
        title: 'Revenue', value: '\$${_fmt(stats.totalRevenue)}',
        change: '+12.5%', isPositive: true,
        icon: LucideIcons.dollarSign,
        iconGradient: AppColors.violetGradient,
        glowColor: AppColors.glowViolet,
      ),
      StatBentoCard(
        title: 'Users', value: _fmtInt(stats.activeUsers),
        change: '+8.2%', isPositive: true,
        icon: LucideIcons.users,
        iconGradient: AppColors.blueGradient,
        glowColor: AppColors.glowBlue,
      ),
      StatBentoCard(
        title: 'API Calls',
        value: '${(stats.apiCalls / 1000000).toStringAsFixed(1)}M',
        change: '+31.7%', isPositive: true,
        icon: LucideIcons.zap,
        iconGradient: AppColors.greenGradient,
        glowColor: AppColors.glowGreen,
      ),
      StatBentoCard(
        title: 'Uptime', value: '${stats.successRate}%',
        change: '-0.1%', isPositive: false,
        icon: LucideIcons.shieldCheck,
        iconGradient: AppColors.roseGradient,
        glowColor: AppColors.glowCyan,
      ),
    ];

    return LayoutBuilder(builder: (ctx, constraints) {
      if (constraints.maxWidth > 700) {
        return Row(
          children: cards
              .map((c) => Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 12), child: c),
          ))
              .toList(),
        );
      }
      
      // Adaptive aspect ratio instead of hardcoded 1.4
      final width = constraints.maxWidth;
      final childWidth = (width - 12) / 2; // 2 columns
      final childHeight = 120.0; // Desired height
      final adaptiveRatio = childWidth / childHeight;

      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: adaptiveRatio,
        children: cards,
      );
    });
  }
}
