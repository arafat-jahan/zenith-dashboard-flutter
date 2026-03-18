// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Row(
        children: [
          // ── Left: Branding Panel
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D0D1A), Color(0xFF1A0A2E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Glow orbs
                    Positioned(
                      top: -100, left: -100,
                      child: Container(
                        width: 400, height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentViolet.withOpacity(0.15),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -80, right: -80,
                      child: Container(
                        width: 300, height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlue.withOpacity(0.12),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(52),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          Row(children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                gradient: AppColors.violetGradient,
                                borderRadius: BorderRadius.circular(11),
                                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20)],
                              ),
                              child: const Icon(LucideIcons.zap, size: 20, color: Colors.white),
                            ),
                            const SizedBox(width: 14),
                            Text('Zenith AI', style: AppTextStyles.headlineLarge.copyWith(fontWeight: FontWeight.w800)),
                          ]),
                          const Spacer(),
                          GradientBadge(label: 'Trusted by 24,000+ developers', gradient: AppColors.violetGradient),
                          const SizedBox(height: 24),
                          Text(
                            'The AI platform\nthat scales with\nyour ambition.',
                            style: AppTextStyles.displayLarge.copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Build, deploy, and monitor AI models\nwith enterprise-grade infrastructure.',
                            style: AppTextStyles.bodyLarge,
                          ),
                          const SizedBox(height: 48),
                          // Testimonial
                          GlassCard(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '"Zenith cut our inference costs by 60% while doubling throughput. Absolute game changer."',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, height: 1.6),
                                ),
                                const SizedBox(height: 14),
                                Row(children: [
                                  Container(
                                    width: 32, height: 32,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.blueGradient,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(child: Text('SK', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text('Sarah Kim', style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
                                    Text('CTO at NovaTech', style: AppTextStyles.bodySmall),
                                  ]),
                                ]),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Right: Login Form
          SizedBox(
            width: MediaQuery.of(context).size.width > 800 ? 480 : double.infinity,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back', style: AppTextStyles.displayMedium),
                    const SizedBox(height: 8),
                    Text('Sign in to your Zenith account', style: AppTextStyles.bodyLarge),
                    const SizedBox(height: 36),

                    // Social buttons
                    Row(children: [
                      Expanded(child: _SocialBtn(label: 'Google', icon: LucideIcons.globe)),
                      const SizedBox(width: 12),
                      Expanded(child: _SocialBtn(label: 'GitHub', icon: LucideIcons.github)),
                    ]),

                    const SizedBox(height: 24),
                    Row(children: [
                      const Expanded(child: Divider(color: AppColors.glassBorder)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or continue with email', style: AppTextStyles.bodySmall),
                      ),
                      const Expanded(child: Divider(color: AppColors.glassBorder)),
                    ]),
                    const SizedBox(height: 24),

                    // Email
                    Text('Email', style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    _InputField(
                      controller: _emailCtrl,
                      hint: 'you@company.com',
                      icon: LucideIcons.mail,
                    ),
                    const SizedBox(height: 18),

                    // Password
                    Text('Password', style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    _InputField(
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
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot password?', style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet)),
                    ),
                    const SizedBox(height: 24),

                    // Login button
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
                            onTap: _loading ? null : _login,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: _loading
                                    ? const SizedBox(width: 20, height: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                    : Text('Sign in', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyles.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Sign up free',
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet, fontWeight: FontWeight.w600),
                            ),
                          ],
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

class _SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SocialBtn({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 12),
      onTap: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.labelLarge),
      ]),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  const _InputField({required this.controller, required this.hint, required this.icon, this.obscure = false, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium,
          prefixIcon: Icon(icon, size: 16, color: AppColors.textMuted),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}