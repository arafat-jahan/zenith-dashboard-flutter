// lib/features/chat/widgets/empty_state.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../core/constants/app_strings.dart';

class EmptyState extends StatelessWidget {
  final String selectedModel;
  final ValueChanged<String> onSuggestionTapped;
  const EmptyState({super.key, required this.selectedModel, required this.onSuggestionTapped});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.violetGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 40, spreadRadius: -4)],
              ),
              child: const Icon(LucideIcons.bot, size: 36, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(AppStrings.chatEmptyStateTitle, style: AppTextStyles.headlineLarge),
            const SizedBox(height: 8),
            Text(
              'Ask $selectedModel anything — analyze, generate, reason.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
              children: AppStrings.chatSuggestions.map((s) => GlassCard(
                onTap: () => onSuggestionTapped(s),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                borderRadius: 100,
                child: Text(
                  s, 
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
