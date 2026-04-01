import 'package:flutter_riverpod/flutter_riverpod.dart';

// Global flag for Mock Mode - DISABLED for production
final isMockModeProvider = StateProvider<bool>((ref) => false);
