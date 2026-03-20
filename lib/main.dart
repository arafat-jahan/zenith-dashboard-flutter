import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/provider_logger.dart';
import 'features/splash/splash_screen.dart';
import 'firebase_options.dart';

// Global flag for Mock Mode (fallback if Firebase fails)
final isMockModeProvider = StateProvider<bool>((ref) => false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  bool firebaseFailed = false;
  try {
    final apiKey = DefaultFirebaseOptions.currentPlatform.apiKey;
    if (apiKey.isEmpty || apiKey == "null") {
      firebaseFailed = true;
      debugPrint("Firebase API Key is missing. Using Mock Mode.");
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).timeout(const Duration(seconds: 5));
    }
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
    firebaseFailed = true;
  }

  runApp(ProviderScope(
    observers: [ProviderLogger()],
    overrides: [
      isMockModeProvider.overrideWith((ref) => firebaseFailed),
    ],
    child: const ZenithApp(),
  ));
}

class ZenithApp extends StatelessWidget {
  const ZenithApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      title: 'Zenith AI — Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
