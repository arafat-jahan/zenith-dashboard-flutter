// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 34, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -1.2, height: 1.15,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 28, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -0.8, height: 1.2,
  );

  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 22, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary, letterSpacing: -0.5, height: 1.3,
  );

  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary, letterSpacing: -0.3, height: 1.35,
  );

  static TextStyle get headlineSmall => GoogleFonts.inter(
    fontSize: 17, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary, letterSpacing: -0.1, height: 1.4,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 17, fontWeight: FontWeight.w400,
    color: AppColors.textSecondary, letterSpacing: 0, height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 15, fontWeight: FontWeight.w400,
    color: AppColors.textSecondary, letterSpacing: 0.1, height: 1.55,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w400,
    color: AppColors.textMuted, letterSpacing: 0.2, height: 1.5,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w500,
    color: AppColors.textSecondary, letterSpacing: 0.3,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12, fontWeight: FontWeight.w500,
    color: AppColors.textSecondary, letterSpacing: 0.2,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 10, fontWeight: FontWeight.w500,
    color: AppColors.textMuted, letterSpacing: 0.8,
  );

  static TextStyle get metricHuge => GoogleFonts.inter(
    fontSize: 42, fontWeight: FontWeight.w800,
    color: AppColors.textPrimary, letterSpacing: -2, height: 1,
  );

  static TextStyle get metricLarge => GoogleFonts.inter(
    fontSize: 30, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -1.2, height: 1.1,
  );

  // ✅ FIX: JetBrainsMono সরিয়ে sourceCodePro দিলাম
  static TextStyle get codeMono => GoogleFonts.sourceCodePro(
    fontSize: 13, fontWeight: FontWeight.w400,
    color: AppColors.textPrimary, height: 1.6,
  );
}