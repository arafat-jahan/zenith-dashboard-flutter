import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mocks/mock_data.dart';
import '../models/recent_activity.dart';

final recentActivityProvider = FutureProvider<List<RecentActivity>>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 1));
  return MockData.getRecentActivity();
});
