// lib/features/dashboard/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardStats {
  final double totalRevenue;
  final int activeUsers;
  final int apiCalls;
  final double avgLatency;
  final double successRate;
  final bool isLoading;

  DashboardStats({
    required this.totalRevenue,
    required this.activeUsers,
    required this.apiCalls,
    required this.avgLatency,
    required this.successRate,
    this.isLoading = false,
  });

  factory DashboardStats.empty() => DashboardStats(
    totalRevenue: 0,
    activeUsers: 0,
    apiCalls: 0,
    avgLatency: 0,
    successRate: 0,
    isLoading: true,
  );
}

class DashboardNotifier extends StateNotifier<DashboardStats> {
  DashboardNotifier() : super(DashboardStats.empty()) {
    refresh();
  }

  Future<void> refresh() async {
    state = DashboardStats(
      totalRevenue: state.totalRevenue,
      activeUsers: state.activeUsers,
      apiCalls: state.apiCalls,
      avgLatency: state.avgLatency,
      successRate: state.successRate,
      isLoading: true,
    );
    
    // Mock data fetching
    await Future.delayed(const Duration(seconds: 1));
    
    state = DashboardStats(
      totalRevenue: 124500.0,
      activeUsers: 24500,
      apiCalls: 12500000,
      avgLatency: 142.0,
      successRate: 99.9,
      isLoading: false,
    );
  }
}

final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardStats>((ref) {
  return DashboardNotifier();
});
