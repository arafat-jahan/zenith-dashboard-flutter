import 'package:flutter/material.dart';

@immutable
class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted; // WCAG AA Compliant

  const ColorThemeExtension({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
  });

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
  }) {
    return ColorThemeExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
    );
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
    );
  }
}
