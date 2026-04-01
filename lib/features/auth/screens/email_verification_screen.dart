// lib/features/auth/screens/email_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';
import '../widgets/widgets.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  bool _loading = false;
  bool _emailSent = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;
    final emailVerificationCheck = ref.watch(emailVerificationCheckProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Row(
        children: [
          // ── Left: Branding Panel (Modularized)
          if (!isMobile)
            const Expanded(
              child: BrandingPanel(),
            ),

          // ── Right: Verification Content
          Expanded(
            flex: isMobile ? 1 : 0,
            child: SizedBox(
              width: isMobile ? double.infinity : 480,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 24 : 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isMobile) ...[
                        const Center(child: BrandingPanel(isMini: true)),
                        const SizedBox(height: 32),
                      ],
                      
                      // Email Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.violetGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: AppColors.glowViolet, blurRadius: 20, spreadRadius: -4),
                          ],
                        ),
                        child: const Icon(
                          LucideIcons.mail,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      Text(
                        'Verify Your Email',
                        style: AppTextStyles.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Text(
                        'We sent a verification link to your email address. Please check your inbox and click the link to verify your account.',
                        style: AppTextStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 36),
                      
                      // Verification Status
                      emailVerificationCheck.when(
                        data: (isVerified) {
                          if (isVerified) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.checkCircle,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Email verified! Redirecting...',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          
                          return const SizedBox.shrink();
                        },
                        loading: () => const CircularProgressIndicator(color: AppColors.accentViolet),
                        error: (error, stack) => Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                LucideIcons.alertCircle,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Error checking verification status',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Resend Email Button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.violetGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -4),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _loading ? null : _resendVerificationEmail,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: _loading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          _emailSent ? 'Resend Email' : 'Resend Verification Email',
                                          style: AppTextStyles.labelLarge.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Refresh Status Button
                      TextButton(
                        onPressed: _loading ? null : () {
                          ref.invalidate(emailVerificationCheckProvider);
                        },
                        child: Text(
                          'Check Verification Status',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.accentViolet,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sign Out Button
                      TextButton(
                        onPressed: _loading ? null : () async {
                          final authRepo = ref.read(authRepositoryProvider);
                          await authRepo.logout();
                        },
                        child: Text(
                          'Sign Out',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
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

  Future<void> _resendVerificationEmail() async {
    setState(() => _loading = true);
    
    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.sendEmailVerification();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Verification email sent!'),
            backgroundColor: Colors.green[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
      
      setState(() => _emailSent = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
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
}
