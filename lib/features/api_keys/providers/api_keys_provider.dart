import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mocks/mock_data.dart';
import '../models/api_credential.dart';

final apiKeysProvider = FutureProvider<List<ApiCredential>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return MockData.getApiKeys();
});
