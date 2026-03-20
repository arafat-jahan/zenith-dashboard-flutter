// lib/features/chat/widgets/missing_key_warning.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class MissingKeyWarning extends StatelessWidget {
  const MissingKeyWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: GlassCard(
          glowColor: AppColors.accentRose,
          glowRadius: 30,
          borderColor: AppColors.accentRose.withValues(alpha: 0.5),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentRose.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.alertTriangle, size: 32, color: AppColors.accentRose),
              ),
              const SizedBox(height: 24),
              Text('API Key Missing', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.accentRose)),
              const SizedBox(height: 12),
              Text(
                'The Gemini API key is not configured.\n\nPlease create a .env file based on .env.example and add your GEMINI_API_KEY, or pass it via --dart-define during build.',
                style: AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
