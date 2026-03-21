import 'package:flutter_riverpod/flutter_riverpod.dart';

// Global flag for Mock Mode (fallback if Firebase fails)
final isMockModeProvider = StateProvider<bool>((ref) => true);
