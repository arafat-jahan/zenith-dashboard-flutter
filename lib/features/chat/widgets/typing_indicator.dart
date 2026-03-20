// lib/features/chat/widgets/typing_indicator.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});
  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(gradient: AppColors.violetGradient, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16),
                bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  final delay = i * 0.33;
                  final raw = ((_ctrl.value - delay) % 1.0 + 1.0) % 1.0;
                  final pulse = (raw < 0.5 ? raw * 2 : (1 - raw) * 2).clamp(0.3, 1.0);
                  return Padding(
                    padding: EdgeInsets.only(right: i < 2 ? 5.0 : 0),
                    child: Opacity(
                      opacity: pulse,
                      child: Container(
                        width: 7, height: 7,
                        decoration: const BoxDecoration(color: AppColors.accentViolet, shape: BoxShape.circle),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
