// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'app_shell.dart';
import 'features/auth/screens/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Generate this by running 'flutterfire configure'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase using the generated options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
    // If firebase_options.dart is not yet generated, fallback to default
    try {
      await Firebase.initializeApp();
    } catch (innerError) {
      debugPrint("Fallback Firebase initialization also failed: $innerError");
    }
  }
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.bgDeep,
    ),
  );
  runApp(const ProviderScope(child: ZenithApp()));
}

class ZenithApp extends StatelessWidget {
  const ZenithApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenith AI — Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      // Login screen দিয়ে শুরু হবে
      home: const LoginScreen(),
    );
  }
}
