// lib/features/chat/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

import '../providers/chat_provider.dart';
import '../models/chat_message.dart';
import '../widgets/widgets.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    ref.read(chatProvider.notifier).sendMessage(text);
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    Future.delayed(const Duration(milliseconds: 1600), _scrollToBottom);
  }

  void _sendSuggestion(String suggestion) {
    _controller.text = suggestion;
    _sendMessage();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(chatProvider);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final hPadding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Column(children: [
        // Header
        Container(
          padding: EdgeInsets.fromLTRB(hPadding, 28, hPadding, 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.glassBorder)),
          ),
          child: isMobile 
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AI Playground', style: AppTextStyles.displayMedium),
                      _HeaderActions(chat: chat, onClear: () => ref.read(chatProvider.notifier).clearChat()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Chat with our frontier models', style: AppTextStyles.bodyLarge),
                ],
              )
            : Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('AI Playground', style: AppTextStyles.displayMedium),
                  const SizedBox(height: 4),
                  Text('Chat with our frontier models', style: AppTextStyles.bodyLarge),
                ])),
                _HeaderActions(chat: chat, onClear: () => ref.read(chatProvider.notifier).clearChat()),
              ]),
        ),

        // Messages
        Expanded(
          child: chat.messages.isEmpty && chat.streamingText.isEmpty
              ? EmptyState(selectedModel: chat.selectedModel, onSuggestionTapped: _sendSuggestion)
              : ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(hPadding, 8, hPadding, 8),
                  itemCount: chat.messages.length + (chat.isTyping || chat.streamingText.isNotEmpty ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == chat.messages.length) {
                      if (chat.streamingText.isNotEmpty) {
                        return MessageBubble(
                          message: ChatMessage(
                            text: chat.streamingText,
                            isUser: false,
                            timestamp: DateTime.now(),
                          ),
                          isStreaming: true,
                          isError: chat.hasStreamingError,
                        );
                      }
                      return const TypingIndicator();
                    }
                    return MessageBubble(message: chat.messages[i]);
                  },
                ),
        ),

        // Input Bar
        Padding(
          padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, 20),
          child: ChatInputBar(
            controller: _controller,
            onSend: _sendMessage,
            isTyping: chat.isTyping,
          ),
        ),
      ]),
    );
  }
}

class _HeaderActions extends ConsumerWidget {
  final dynamic chat;
  final VoidCallback onClear;
  const _HeaderActions({required this.chat, required this.onClear});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: chat.selectedModel,
              dropdownColor: AppColors.bgElevated,
              icon: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(LucideIcons.chevronDown, size: 14, color: AppColors.textMuted),
              ),
              items: ['zenith-ultra','zenith-pro','zenith-flash','zenith-nano']
                  .map((m) => DropdownMenuItem(
                value: m,
                child: Text(m, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
              ))
                  .toList(),
              onChanged: (v) { if (v != null) ref.read(chatProvider.notifier).changeModel(v); },
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GlassCard(
          padding: const EdgeInsets.all(10),
          onTap: onClear,
          child: const Icon(LucideIcons.trash2, size: 16, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
