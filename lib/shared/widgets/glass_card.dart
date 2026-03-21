import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Add this for kIsWeb
import '../../core/theme/app_colors.dart';

class GlassCard extends StatefulWidget {
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
  final bool animateOnHover;

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
    this.animateOnHover = true,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;
  Offset _mousePos = Offset.zero;

  void _onPointerMove(PointerEvent event) {
    setState(() {
      _mousePos = event.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasInteraction = widget.onTap != null || widget.animateOnHover;
    final targetScale = _isHovered && hasInteraction ? 1.02 : 1.0;
    final targetGlow = _isHovered ? widget.glowRadius * 1.5 : widget.glowRadius;

    Widget content = AnimatedScale(
      scale: targetScale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutBack,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow:[
            if (widget.glowColor != null && targetGlow > 0) ...[
              BoxShadow(
                color: widget.glowColor!.withValues(alpha: _isHovered ? 0.25 : 0.15),
                blurRadius: targetGlow,
                spreadRadius: targetGlow * 0.2,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ] else ...[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: CustomPaint(
              painter: _GlassBorderPainter(
                borderRadius: widget.borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:[
                    Colors.white.withValues(alpha: _isHovered ? 0.35 : 0.25),
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
                mousePos: _isHovered ? _mousePos : null,
                glowColor: widget.glowColor,
              ),
              child: Container(
                padding: widget.padding ?? const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: widget.gradient ??
                      LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[
                          AppColors.bgGlass.withValues(alpha: 0.8),
                          AppColors.bgSurface.withValues(alpha: 0.6),
                        ],
                      ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );

    // Fix: Disable MouseRegion hover tracking on mobile using kIsWeb
    if (!kIsWeb) {
      if (widget.onTap != null) {
        return GestureDetector(
          onTap: widget.onTap,
          child: content,
        );
      }
      return content;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      onHover: _onPointerMove,
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: content,
      ),
    );
  }
}

class _GlassBorderPainter extends CustomPainter {
  final double borderRadius;
  final Gradient gradient;
  final Offset? mousePos;
  final Color? glowColor;

  _GlassBorderPainter({
    required this.borderRadius,
    required this.gradient,
    this.mousePos,
    this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    
    // Draw base border
    final paint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rrect, paint);

    // Draw mouse glow follow effect
    if (mousePos != null && glowColor != null) {
      final glowPaint = Paint()
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..shader = RadialGradient(
          center: Alignment(
            (mousePos!.dx / size.width) * 2 - 1,
            (mousePos!.dy / size.height) * 2 - 1,
          ),
          radius: 0.5,
          colors: [
            glowColor!.withValues(alpha: 0.6),
            glowColor!.withValues(alpha: 0.0),
          ],
        ).createShader(rect);
      
      canvas.drawRRect(rrect, glowPaint);
    }
  }

  @override
  bool shouldRepaint(_GlassBorderPainter oldDelegate) => 
    oldDelegate.mousePos != mousePos || oldDelegate.glowColor != glowColor;
}
