// lib/features/chat/widgets/chat_input_bar.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/config/app_config.dart';
import '../../../shared/widgets/glass_card.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isTyping;

  const ChatInputBar({super.key, required this.controller, required this.onSend, required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
        color: AppColors.bgDeep,
      ),
      child: Row(children: [
        GlassCard(
          padding: const EdgeInsets.all(12),
          child: const Icon(LucideIcons.paperclip, size: 16, color: AppColors.textMuted),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: TextField(
              controller: controller,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
              maxLines: 4, minLines: 1,
              decoration: InputDecoration(
                hintText: 'Message ${AppConfig.appName}…',
                hintStyle: AppTextStyles.bodyMedium,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: isTyping ? null : AppColors.violetGradient,
            color: isTyping ? AppColors.bgSurface : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isTyping ? null : const [BoxShadow(color: AppColors.glowViolet, blurRadius: 18, spreadRadius: -4)],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isTyping ? null : onSend,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Icon(
                  isTyping ? LucideIcons.loader : LucideIcons.arrowUp,
                  size: 18,
                  color: isTyping ? AppColors.textMuted : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
