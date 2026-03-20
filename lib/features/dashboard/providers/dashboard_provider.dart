// lib/features/dashboard/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardStats {
  final double totalRevenue;
  final int activeUsers;
  final int apiCalls;
  final double avgLatency;
  final double successRate;
  final bool isLoading;

  const DashboardStats({
    required this.totalRevenue,
    required this.activeUsers,
    required this.apiCalls,
    required this.avgLatency,
    required this.successRate,
    this.isLoading = false,
  });

  factory DashboardStats.empty() => const DashboardStats(
    totalRevenue: 0,
    activeUsers: 0,
    apiCalls: 0,
    avgLatency: 0,
    successRate: 0,
    isLoading: true,
  );

  DashboardStats copyWith({
    double? totalRevenue,
    int? activeUsers,
    int? apiCalls,
    double? avgLatency,
    double? successRate,
    bool? isLoading,
  }) {
    return DashboardStats(
      totalRevenue: totalRevenue ?? this.totalRevenue,
      activeUsers: activeUsers ?? this.activeUsers,
      apiCalls: apiCalls ?? this.apiCalls,
      avgLatency: avgLatency ?? this.avgLatency,
      successRate: successRate ?? this.successRate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DashboardNotifier extends Notifier<DashboardStats> {
  @override
  DashboardStats build() {
    // Start fetching data immediately
    Future.microtask(() => refresh());
    return DashboardStats.empty();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    
    // Mock data fetching with high-end simulated delay
    await Future.delayed(const Duration(seconds: 1));
    
    state = const DashboardStats(
      totalRevenue: 124500.0,
      activeUsers: 24500,
      apiCalls: 12500000,
      avgLatency: 142.0,
      successRate: 99.9,
      isLoading: false,
    );
  }
}

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardStats>(DashboardNotifier.new);
