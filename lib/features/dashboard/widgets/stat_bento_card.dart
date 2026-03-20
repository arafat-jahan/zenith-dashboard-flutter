import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class StatBentoCard extends StatelessWidget {
  final String title, value, change;
  final bool isPositive;
  final IconData icon;
  final Gradient iconGradient;
  final Color glowColor;

  const StatBentoCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.iconGradient,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: glowColor.withValues(alpha: 0.15),
      glowRadius: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: iconGradient,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: glowColor.withValues(alpha: 0.4), blurRadius: 10)
                  ],
                ),
                child: Icon(icon, size: 16, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.accentGreen : AppColors.accentRose).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  change,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isPositive ? AppColors.accentGreen : AppColors.accentRose,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodySmall),
              const SizedBox(height: 2),
              _AnimatedValueText(value: value),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedValueText extends StatelessWidget {
  final String value;
  const _AnimatedValueText({required this.value});

  @override
  Widget build(BuildContext context) {
    // Parse value: e.g., '$2.4M', '94ms', '18.2%'
    final numericPart = RegExp(r'[0-9.]+').firstMatch(value)?.group(0) ?? '0';
    final prefix = value.split(numericPart).first;
    final suffix = value.split(numericPart).last;
    final targetValue = double.tryParse(numericPart) ?? 0.0;
    final isInteger = !numericPart.contains('.');

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutExpo,
      builder: (context, val, child) {
        String display;
        if (isInteger) {
          display = val.toInt().toString();
        } else {
          display = val.toStringAsFixed(1);
        }
        return Text(
          '$prefix$display$suffix',
          style: AppTextStyles.headlineMedium.copyWith(letterSpacing: -0.5),
        );
      },
    );
  }
}
