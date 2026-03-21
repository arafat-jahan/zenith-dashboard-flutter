import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/dashboard_provider.dart';
import 'stat_bento_card.dart';

class StatCardsRow extends ConsumerWidget {
  const StatCardsRow({super.key});

  String _fmt(double v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toStringAsFixed(0);
  String _fmtInt(int v) =>
      v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : v.toString();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardProvider);
    
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
                padding: const EdgeInsets.only(right: 16), child: c),
          ))
              .toList(),
        );
      }
      
      final width = constraints.maxWidth;
      final childWidth = (width - 16) / 2; // 2 columns
      // INCREASED HEIGHT: Fixed overflow by increasing base height from 140 to 160
      final childHeight = 160.0; 
      final adaptiveRatio = childWidth / childHeight;

      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: adaptiveRatio,
        children: cards,
      );
    });
  }
}
