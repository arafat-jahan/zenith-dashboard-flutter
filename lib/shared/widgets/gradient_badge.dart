// lib/shared/widgets/gradient_badge.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class GradientBadge extends StatelessWidget {
  final String label;
  final Gradient gradient;
  final double? fontSize;

  const GradientBadge({super.key, required this.label, required this.gradient, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(100)),
      child: Text(label, style: AppTextStyles.labelSmall.copyWith(
        color: Colors.white, fontSize: fontSize ?? 10, fontWeight: FontWeight.w600,
      )),
    );
  }
}

class StatusDot extends StatelessWidget {
  final Color color;
  const StatusDot({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8, height: 8,
      decoration: BoxDecoration(
        color: color, shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 6, spreadRadius: 1)],
      ),
    );
  }
}
