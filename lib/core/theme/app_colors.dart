// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bgDeep       = Color(0xFF0A0A0F);
  static const Color bgSurface    = Color(0xFF111118);
  static const Color bgElevated   = Color(0xFF1A1A26);
  static const Color bgGlass      = Color(0xFF1E1E2E);

  static const Color accentViolet = Color(0xFF7C3AED);
  static const Color accentBlue   = Color(0xFF3B82F6);
  static const Color accentCyan   = Color(0xFF06B6D4);
  static const Color accentGreen  = Color(0xFF10B981);
  static const Color accentAmber  = Color(0xFFF59E0B);
  static const Color accentRose   = Color(0xFFF43F5E);

  static const Color glowViolet   = Color(0x557C3AED);
  static const Color glowBlue     = Color(0x553B82F6);
  static const Color glowCyan     = Color(0x5506B6D4);
  static const Color glowGreen    = Color(0x5510B981);

  static const Color glassBorder  = Color(0x22FFFFFF);
  static const Color glassBorderBright = Color(0x44FFFFFF);

  static const Color textPrimary  = Color(0xFFF1F5F9);
  static const Color textSecondary= Color(0xFF94A3B8);
  static const Color textMuted    = Color(0xFF475569);
  static const Color textDisabled = Color(0xFF334155);

  static const LinearGradient violetGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient roseGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}