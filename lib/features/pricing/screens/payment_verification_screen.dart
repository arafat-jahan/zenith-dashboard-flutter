// lib/features/pricing/screens/payment_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/glass_card.dart';

class PaymentVerificationScreen extends ConsumerStatefulWidget {
  const PaymentVerificationScreen({super.key});

  @override
  ConsumerState<PaymentVerificationScreen> createState() => _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends ConsumerState<PaymentVerificationScreen> {
  bool _isVerifying = false;
  bool _verificationSuccess = false;

  Future<void> _confirmPayment() async {
    setState(() => _isVerifying = true);
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');
      
      // Update user document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'plan': 'pro',
        'credits': 500,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Invalidate user profile to refresh UI
      ref.invalidate(userProfileProvider);
      
      setState(() {
        _isVerifying = false;
        _verificationSuccess = true;
      });
      
      // Navigate to success screen after delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/success',
            (route) => false,
          );
        }
      });
    } catch (e) {
      setState(() => _isVerifying = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating subscription: ${e.toString()}'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GlassCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Verification Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.violetGradient,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.glowViolet,
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: _verificationSuccess
                      ? const Icon(
                          LucideIcons.check,
                          color: Colors.white,
                          size: 40,
                        )
                      : const Icon(
                          LucideIcons.clock,
                          color: Colors.white,
                          size: 40,
                        ),
                ),
                const SizedBox(height: 24),
                
                // Verification Message
                Text(
                  _verificationSuccess ? 'Payment Verified!' : 'Verifying Payment',
                  style: AppTextStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  _verificationSuccess 
                    ? 'Your Pro subscription has been activated!'
                    : 'Complete your payment in the browser, then click the button below to verify.',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                // Verification Status
                if (_isVerifying) ...[
                  const CircularProgressIndicator(color: AppColors.accentViolet),
                  const SizedBox(height: 16),
                  Text(
                    'Updating your subscription...',
                    style: AppTextStyles.bodyMedium,
                  ),
                ] else if (_verificationSuccess) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.crown, color: AppColors.accentGreen, size: 20),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pro Plan Activated',
                              style: AppTextStyles.headlineSmall.copyWith(
                                color: AppColors.accentGreen,
                              ),
                            ),
                            Text(
                              '500 credits added to your account',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Confirm Payment Button
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.violetGradient,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.glowViolet,
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _confirmPayment,
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                'I Have Paid',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Cancel Button
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.glassBorder),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Cancel', style: AppTextStyles.labelLarge),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
