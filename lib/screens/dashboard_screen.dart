import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_kit/theme/app_theme.dart';
import 'package:ui_kit/widgets/active_models.dart';
import 'package:ui_kit/widgets/chart_card.dart';
import 'package:ui_kit/widgets/quick_actions.dart';
import 'package:ui_kit/widgets/recent_activity.dart';
import 'package:ui_kit/widgets/sidebar.dart';
import 'package:ui_kit/widgets/stat_card.dart';
import 'package:ui_kit/widgets/system_performance.dart';
import 'package:ui_kit/widgets/token_usage.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBentoGrid(),
                          const SizedBox(height: 24),
                          _buildChartsSection(),
                          const SizedBox(height: 24),
                          _buildBottomSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: const Text(
              'Pro',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                prefixIcon: Icon(LucideIcons.search, size: 16, color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _IconButton(icon: LucideIcons.bell),
          const SizedBox(width: 12),
          _IconButton(icon: LucideIcons.user),
        ],
      ),
    );
  }

  Widget _buildBentoGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: constraints.maxWidth > 1200 ? 4 : (constraints.maxWidth > 800 ? 2 : 1),
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.8,
          children: const [
            StatCard(
              title: 'API Requests',
              value: '2.4 M',
              trend: '+12.5%',
              isPositive: true,
              subtitle: 'Total requests this month',
            ),
            StatCard(
              title: 'Active Models',
              value: '8',
              trend: '+2',
              isPositive: true,
              subtitle: 'Models in production',
            ),
            StatCard(
              title: 'Avg Response',
              value: '142ms',
              trend: '-4.2%',
              isPositive: false,
              subtitle: 'Average latency',
            ),
            StatCard(
              title: 'Success Rate',
              value: '99.9%',
              trend: '+0.1%',
              isPositive: true,
              subtitle: 'Uptime this month',
            ),
          ],
        );
      },
    );
  }

  Widget _buildChartsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 400,
          child: Row(
            children: [
              Expanded(
                child: ChartCard(
                  title: 'API Requests',
                  value: '289K',
                  chartColor: AppColors.primary,
                  spots: const [
                    FlSpot(0, 1),
                    FlSpot(2, 1.5),
                    FlSpot(4, 1.2),
                    FlSpot(6, 2.8),
                    FlSpot(8, 3.2),
                    FlSpot(10, 2.5),
                    FlSpot(11, 2.8),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: ChartCard(
                  title: 'Test Data Transfer',
                  value: '1.2 GB',
                  chartColor: Colors.blue,
                  spots: const [
                    FlSpot(0, 2),
                    FlSpot(2, 2.2),
                    FlSpot(4, 1.8),
                    FlSpot(6, 2.5),
                    FlSpot(8, 2.2),
                    FlSpot(10, 3.5),
                    FlSpot(11, 3.8),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(flex: 3, child: ActiveModels()),
                  const SizedBox(width: 24),
                  const Expanded(flex: 2, child: TokenUsage()),
                  const SizedBox(width: 24),
                  const Expanded(flex: 2, child: SystemPerformance()),
                ],
              ),
            ),
            const SizedBox(height: 24),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(flex: 5, child: RecentActivity()),
                  const SizedBox(width: 24),
                  const Expanded(flex: 2, child: QuickActions()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;

  const _IconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, size: 20, color: AppColors.textSecondary),
    );
  }
}
