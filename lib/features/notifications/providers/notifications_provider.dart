import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mocks/mock_data.dart';
import '../models/app_notification.dart';

final notificationsProvider = FutureProvider<List<AppNotification>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return MockData.getNotifications();
});
