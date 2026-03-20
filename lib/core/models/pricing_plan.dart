import 'package:flutter/material.dart';

class PricingPlan {
  final String id, name, tagline, cta;
  final double monthlyPrice, annualPrice;
  final List<String> features, limits;
  final List<Color> gradientColors;
  final Color glowColor;
  final bool isPopular;

  const PricingPlan({
    required this.id,
    required this.name,
    required this.tagline,
    required this.monthlyPrice,
    required this.annualPrice,
    required this.features,
    required this.limits,
    required this.gradientColors,
    required this.glowColor,
    required this.cta,
    this.isPopular = false,
  });

  Gradient get gradient => LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
