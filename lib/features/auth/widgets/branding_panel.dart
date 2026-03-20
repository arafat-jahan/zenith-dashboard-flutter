// lib/features/auth/widgets/branding_panel.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class BrandingPanel extends StatefulWidget {
  const BrandingPanel({super.key});

  @override
  State<BrandingPanel> createState() => _BrandingPanelState();
}

class _BrandingPanelState extends State<BrandingPanel> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _orb1Scale;
  late final Animation<double> _orb2Scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _orb1Scale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );

    _orb2Scale = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D0D1A), Color(0xFF1A0A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Glow orb 1
          Positioned(
            top: -100, left: -100,
            child: ScaleTransition(
              scale: _orb1Scale,
              child: Container(
                width: 400, height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentViolet.withValues(alpha: 0.15),
                ),
              ),
            ),
          ),
          // Glow orb 2
          Positioned(
            bottom: -80, right: -80,
            child: ScaleTransition(
              scale: _orb2Scale,
              child: Container(
                width: 300, height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentBlue.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(52),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  Text(AppStrings.appName, style: AppTextStyles.headlineLarge.copyWith(fontWeight: FontWeight.w800)),
                ]),
                const Spacer(),
                GradientBadge(label: AppStrings.trustedBy, gradient: AppColors.violetGradient),
                const SizedBox(height: 24),
                Text(
                  AppStrings.appTagline.replaceAll('scales', 'scales\n'),
                  style: AppTextStyles.displayLarge.copyWith(height: 1.2),
                ),
                const SizedBox(height: 20),
                Text(
                  AppStrings.appDescription.replaceAll('infrastructure.', 'infrastructure.\n'),
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(height: 48),
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.testimonialText,
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
                          Text(AppStrings.testimonialAuthor, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
                          Text(AppStrings.testimonialAuthorRole, style: AppTextStyles.bodySmall),
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
    );
  }
}
