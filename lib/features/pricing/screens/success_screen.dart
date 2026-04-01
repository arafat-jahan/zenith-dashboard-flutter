// lib/features/pricing/screens/success_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/glass_card.dart';

class SuccessScreen extends ConsumerStatefulWidget {
  final String? sessionId;
  const SuccessScreen({super.key, this.sessionId});

  @override
  ConsumerState<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {
  bool _isUpdating = false;
  bool _updateSuccess = false;

  @override
  void initState() {
    super.initState();
    _updateUserSubscription();
  }

  Future<void> _updateUserSubscription() async {
    setState(() => _isUpdating = true);
    
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
        _isUpdating = false;
        _updateSuccess = true;
      });
    } catch (e) {
      setState(() {
        _isUpdating = false;
      });
      
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
                // Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.greenGradient,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreen.withValues(alpha: 0.3),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Success Message
                Text(
                  'Payment Successful!',
                  style: AppTextStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Welcome to Pro! Your subscription has been activated.',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                // Update Status
                if (_isUpdating) ...[
                  const CircularProgressIndicator(color: AppColors.accentViolet),
                  const SizedBox(height: 16),
                  Text(
                    'Updating your account...',
                    style: AppTextStyles.bodyMedium,
                  ),
                ] else if (_updateSuccess) ...[
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
                  const SizedBox(height: 24),
                ],
                
                // Action Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_updateSuccess) ...[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/',
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentViolet,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Go to Dashboard', style: AppTextStyles.labelLarge),
                      ),
                    ] else ...[
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
                        child: Text('Go Back', style: AppTextStyles.labelLarge),
                      ),
                      const SizedBox(width: 12),
                      if (!_isUpdating)
                        ElevatedButton(
                          onPressed: _updateUserSubscription,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentViolet,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Retry Update', style: AppTextStyles.labelLarge),
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
