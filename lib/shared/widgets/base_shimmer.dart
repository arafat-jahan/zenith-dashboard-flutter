import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/extensions/color_theme.dart';

class BaseShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const BaseShimmer({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorThemeExtension>()!;
    
    return Shimmer.fromColors(
      baseColor: colors.surface,
      highlightColor: colors.surface.withValues(alpha: 0.5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
