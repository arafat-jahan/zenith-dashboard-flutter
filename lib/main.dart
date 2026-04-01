import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/provider_logger.dart';
import 'features/splash/splash_screen.dart';
import 'features/pricing/screens/success_screen.dart';
import 'features/pricing/screens/payment_verification_screen.dart';
import 'features/pricing/screens/success_manual_update_screen.dart';
import 'core/config/app_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase - Force initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
    observers: [ProviderLogger()],
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
      title: '${AppConfig.appName} — Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
      routes: {
        '/success': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return SuccessScreen(sessionId: args is String ? args : null);
        },
        '/payment-verification': (context) => const PaymentVerificationScreen(),
        '/success-manual': (context) => const SuccessManualUpdateScreen(),
      },
    );
  }
}
