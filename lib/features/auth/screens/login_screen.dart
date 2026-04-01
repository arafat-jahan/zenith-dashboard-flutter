// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';

import '../providers/auth_provider.dart';
import '../../../app_shell.dart';
import '../widgets/widgets.dart';

enum AuthMode { login, signup }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  bool _googleLoading = false;
  bool _appleLoading = false;
  AuthMode _mode = AuthMode.login;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == AuthMode.login ? AuthMode.signup : AuthMode.login;
    });
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _googleLoading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signInWithGoogle();
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AppShell()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In Error: ${e.toString()}'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _googleLoading = false);
    }
  }

  Future<void> _handleAppleSignIn() async {
    setState(() => _appleLoading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signInWithApple();
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AppShell()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apple Sign-In Error: ${e.toString()}'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _appleLoading = false);
    }
  }

  Future<void> _handleAuth() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final name = _nameCtrl.text.trim();

    if (email.isEmpty || pass.isEmpty || (_mode == AuthMode.signup && name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider);
      
      if (_mode == AuthMode.login) {
        await authRepo.login(email, pass);
      } else {
        await authRepo.register(email, pass, name);
      }
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AppShell()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication Error: ${e.toString()}'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildSocialButton(String label, IconData icon, bool isLoading, VoidCallback onPressed, Color brandColor) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(brandColor),
                    ),
                  )
                else
                  Icon(
                    icon,
                    size: 20,
                    color: brandColor,
                  ),
                const SizedBox(width: 8),
                Text(
                  isLoading ? 'Connecting...' : label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _mode == AuthMode.login;
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Row(
        children: [
          // ── Left: Branding Panel (Modularized)
          if (!isMobile)
            const Expanded(
              child: BrandingPanel(),
            ),

          // ── Right: Auth Form
          Expanded(
            flex: isMobile ? 1 : 0,
            child: SizedBox(
              width: isMobile ? double.infinity : 480,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 24 : 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile) ...[
                        const Center(child: BrandingPanel(isMini: true)),
                        const SizedBox(height: 32),
                      ],
                      Text(
                        isLogin ? AppStrings.loginTitle : AppStrings.signUpTitle, 
                        style: AppTextStyles.displayMedium
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isLogin ? AppStrings.loginSubtitle : AppStrings.signUpSubtitle, 
                        style: AppTextStyles.bodyLarge
                      ),
                      const SizedBox(height: 36),

                      Row(children: [
                        Expanded(
                          child: _buildSocialButton(
                            'Google',
                            LucideIcons.globe,
                            _googleLoading,
                            _handleGoogleSignIn,
                            const Color(0xFF4285F4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSocialButton(
                            'Apple',
                            LucideIcons.apple,
                            _appleLoading,
                            _handleAppleSignIn,
                            const Color(0xFF000000),
                          ),
                        ),
                      ]),

                      const SizedBox(height: 24),
                      Row(children: [
                        const Expanded(child: Divider(color: AppColors.glassBorder)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(AppStrings.orContinueWithEmail, style: AppTextStyles.bodySmall),
                        ),
                        const Expanded(child: Divider(color: AppColors.glassBorder)),
                      ]),
                      const SizedBox(height: 24),

                      if (!isLogin) ...[
                        Text(AppStrings.fullNameLabel, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
                        const SizedBox(height: 8),
                        InputField(
                          controller: _nameCtrl,
                          hint: 'John Doe',
                          icon: LucideIcons.user,
                        ),
                        const SizedBox(height: 18),
                      ],

                      Text(AppStrings.emailLabel, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      InputField(
                        controller: _emailCtrl,
                        hint: 'you@company.com',
                        icon: LucideIcons.mail,
                      ),
                      const SizedBox(height: 18),

                      Text(AppStrings.passwordLabel, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      InputField(
                        controller: _passCtrl,
                        hint: '••••••••',
                        icon: LucideIcons.lock,
                        obscure: _obscure,
                        suffix: IconButton(
                          icon: Icon(
                            _obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                            size: 16, color: AppColors.textMuted,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      if (isLogin) ...[
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(AppStrings.forgotPassword, style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet)),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Auth button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.violetGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -4)],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _loading ? null : _handleAuth,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: _loading
                                      ? const SizedBox(width: 20, height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                      : Text(
                                          isLogin ? AppStrings.signIn : AppStrings.signUpFree, 
                                          style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: InkWell(
                          onTap: _loading ? null : _toggleMode,
                          child: RichText(
                            text: TextSpan(
                              text: isLogin ? AppStrings.dontHaveAccount : AppStrings.alreadyHaveAccount,
                              style: AppTextStyles.bodySmall,
                              children: [
                                TextSpan(
                                  text: isLogin ? AppStrings.signUpFree : AppStrings.signIn,
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
