// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'extensions/color_theme.dart';
import 'extensions/glow_theme.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A0A0F),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    extensions: const <ThemeExtension<dynamic>>[
      ColorThemeExtension(
        primary: Color(0xFF7C3AED),
        secondary: Color(0xFF3B82F6),
        surface: Color(0xFF111118),
        background: Color(0xFF0A0A0F),
        textPrimary: Color(0xFFF1F5F9),
        textSecondary: Color(0xFF94A3B8),
        textMuted: Color(0xFF64748B), // WCAG AA Compliant
      ),
      GlowThemeExtension(
        primaryGlow: Color(0x557C3AED),
        secondaryGlow: Color(0x553B82F6),
      ),
    ],
  );
}