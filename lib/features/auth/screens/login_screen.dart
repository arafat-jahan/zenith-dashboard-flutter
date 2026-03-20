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
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _mode == AuthMode.login;

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Row(
        children:[
          // ── Left: Branding Panel (Modularized)
          if (MediaQuery.of(context).size.width > 800)
            const Expanded(
              child: BrandingPanel(),
            ),

          // ── Right: Auth Form
          SizedBox(
            width: MediaQuery.of(context).size.width > 800 ? 480 : double.infinity,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
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

                    const Row(children:[
                      Expanded(child: SocialBtn(label: 'Google', icon: LucideIcons.globe)),
                      SizedBox(width: 12),
                      Expanded(child: SocialBtn(label: 'GitHub', icon: LucideIcons.github)),
                    ]),

                    const SizedBox(height: 24),
                    Row(children:[
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
                          boxShadow: const[BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -4)],
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
                            children:[
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
        ],
      ),
    );
  }
}
