// lib/shared/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final Color? glowColor;
  final double glowRadius;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.borderColor,
    this.glowColor,
    this.glowRadius = 0,
    this.gradient,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card;

    // ✅ FIX: Web এ BackdropFilter কাজ করে না — plain card দাও
    if (kIsWeb) {
      card = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient ??
              LinearGradient(
                colors: [
                  AppColors.bgGlass.withValues(alpha: 0.92),
                  AppColors.bgSurface.withValues(alpha: 0.88),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.glassBorder,
            width: 1,
          ),
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      );
    } else {
      // Mobile/Desktop এ blur চলবে
      card = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      AppColors.bgGlass.withValues(alpha: 0.7),
                      AppColors.bgSurface.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? AppColors.glassBorder,
                width: 1,
              ),
            ),
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      );
    }

    // ✅ FIX: Glow শুধু যেখানে explicitly দেওয়া হবে
    if (glowColor != null &&
        glowColor != Colors.transparent &&
        glowRadius > 0) {
      card = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: glowColor!.withValues(alpha: 0.2), // opacity কমালাম
              blurRadius: glowRadius * 0.7,        // radius কমালাম
              spreadRadius: -6,
            ),
          ],
        ),
        child: card,
      );
    }

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
