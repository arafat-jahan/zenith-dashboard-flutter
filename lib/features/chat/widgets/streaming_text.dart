// lib/features/chat/widgets/streaming_text.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class StreamingText extends StatefulWidget {
  final String text;
  final bool isError;
  const StreamingText({super.key, required this.text, this.isError = false});

  @override
  State<StreamingText> createState() => _StreamingTextState();
}

class _StreamingTextState extends State<StreamingText> with SingleTickerProviderStateMixin {
  late final AnimationController _cursorCtrl;

  @override
  void initState() {
    super.initState();
    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyMedium.copyWith(
          color: widget.isError ? AppColors.accentRose : AppColors.textPrimary,
          height: 1.6,
        ),
        children:[
          TextSpan(text: widget.text),
          if (!widget.isError)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: FadeTransition(
                opacity: _cursorCtrl,
                child: Container(
                  width: 2,
                  height: 16,
                  margin: const EdgeInsets.only(left: 2),
                  color: AppColors.accentViolet,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
