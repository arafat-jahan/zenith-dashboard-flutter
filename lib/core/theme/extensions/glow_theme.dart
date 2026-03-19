import 'package:flutter/material.dart';

@immutable
class GlowThemeExtension extends ThemeExtension<GlowThemeExtension> {
  final Color primaryGlow;
  final Color secondaryGlow;

  const GlowThemeExtension({
    required this.primaryGlow,
    required this.secondaryGlow,
  });

  @override
  ThemeExtension<GlowThemeExtension> copyWith({
    Color? primaryGlow,
    Color? secondaryGlow,
  }) {
    return GlowThemeExtension(
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondaryGlow: secondaryGlow ?? this.secondaryGlow,
    );
  }

  @override
  ThemeExtension<GlowThemeExtension> lerp(
    ThemeExtension<GlowThemeExtension>? other,
    double t,
  ) {
    if (other is! GlowThemeExtension) {
      return this;
    }
    return GlowThemeExtension(
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      secondaryGlow: Color.lerp(secondaryGlow, other.secondaryGlow, t)!,
    );
  }
}
