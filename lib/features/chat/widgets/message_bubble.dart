import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/chat_message.dart';
import '../providers/chat_provider.dart';
import 'widgets.dart'; // Import to access StreamingText

class MessageBubble extends StatefulWidget {
  final ChatMessage message;
  final bool isStreaming;
  final bool isError;

  const MessageBubble({
    super.key,
    required this.message,
    this.isStreaming = false,
    this.isError = false,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _appearController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnimation = CurvedAnimation(parent: _appearController, curve: Curves.easeOutBack);
    _opacityAnimation = CurvedAnimation(parent: _appearController, curve: Curves.easeIn);

    _appearController.forward();
  }

  @override
  void dispose() {
    _appearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.isUser;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutQuart,
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          alignment: isUser ? Alignment.bottomRight : Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isUser) ...[
                  _AvatarBox(isError: widget.isError),
                  const SizedBox(width: 12),
                ],
                Flexible(
                  child: Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children:[
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          gradient: isUser ? AppColors.violetGradient : null,
                          color: isUser ? null : AppColors.bgSurface,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(isUser ? 20 : 4),
                            bottomRight: Radius.circular(isUser ? 4 : 20),
                          ),
                          border: Border.all(
                            color: widget.isError ? AppColors.accentRose.withValues(alpha: 0.4) : AppColors.glassBorder,
                            width: 1.2,
                          ),
                          boxShadow: isUser
                              ? const[BoxShadow(color: AppColors.glowViolet, blurRadius: 24, spreadRadius: -6)]
                              :[BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: widget.isStreaming
                            ? StreamingText(text: widget.message.text, isError: widget.isError)
                            : Text(
                          widget.message.text,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: widget.isError ? AppColors.accentRose : (isUser ? Colors.white : AppColors.textPrimary),
                            height: 1.6,
                          ),
                        ),
                      ),
                      if (widget.isError) ...[
                        const SizedBox(height: 8),
                        Consumer(
                          builder: (context, ref, child) => TextButton.icon(
                            onPressed: () => ref.read(chatProvider.notifier).retryLast(),
                            icon: const Icon(LucideIcons.refreshCw, size: 12, color: AppColors.accentRose),
                            label: Text('Retry Connection', style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentRose)),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              backgroundColor: AppColors.accentRose.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isUser) ...[
                  const SizedBox(width: 12),
                  const _UserAvatar(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarBox extends StatelessWidget {
  final bool isError;
  const _AvatarBox({required this.isError});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34, height: 34,
      decoration: BoxDecoration(
        gradient: isError ? AppColors.roseGradient : AppColors.violetGradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow:[
          BoxShadow(
              color: isError ? AppColors.accentRose.withValues(alpha: 0.3) : AppColors.glowViolet,
              blurRadius: 14
          )
        ],
      ),
      child: Icon(isError ? LucideIcons.alertCircle : LucideIcons.bot, size: 16, color: Colors.white),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34, height: 34,
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: AppColors.glowBlue, blurRadius: 14)],
      ),
      child: const Center(child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800))),
    );
  }
}
