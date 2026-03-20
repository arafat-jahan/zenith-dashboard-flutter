// lib/features/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../auth/providers/auth_provider.dart';
import '../auth/screens/login_screen.dart';
import '../../app_shell.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scaleAnim = CurvedAnimation(
      parent: _scaleCtrl,
      curve: Curves.elasticOut,
    );

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _scaleCtrl.forward();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    try {
      // Minimum wait time for the animation
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      // Watch the auth state. If it's still loading, we might want to wait a bit longer,
      // but for a splash screen, we can just read the current state.
      final authState = ref.read(authStateChangesProvider);
      
      authState.when(
        data: (user) {
          if (user != null) {
            _goTo(const AppShell());
          } else {
            _goTo(const LoginScreen());
          }
        },
        loading: () => _goTo(const LoginScreen()), // Default to login if taking too long
        error: (err, stack) {
          debugPrint('Auth Error in Splash: $err');
          _goTo(const LoginScreen());
        },
      );
    } catch (e) {
      debugPrint('Splash Navigation Error: $e');
      if (mounted) _goTo(const LoginScreen());
    }
  }

  void _goTo(Widget screen) {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulsing glow
            ScaleTransition(
              scale: _pulseAnim,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentViolet.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.glowViolet.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            // Animated Logo
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColors.violetGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.glowViolet,
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: const Icon(
                  LucideIcons.zap,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
