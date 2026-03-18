// lib/features/chat/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/glass_card.dart';

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

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: Column(children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(24, 28, 20, 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.glassBorder)),
          ),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('AI Playground', style: AppTextStyles.displayMedium),
              const SizedBox(height: 4),
              Text('Chat with our frontier models', style: AppTextStyles.bodyLarge),
            ])),
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
              onTap: () => ref.read(chatProvider.notifier).clearChat(),
              child: const Icon(LucideIcons.trash2, size: 16, color: AppColors.textMuted),
            ),
          ]),
        ),

        // Messages
        Expanded(
          child: chat.messages.isEmpty
              ? _EmptyState(selectedModel: chat.selectedModel)
              : ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            itemCount: chat.messages.length + (chat.isTyping ? 1 : 0),
            itemBuilder: (_, i) {
              if (chat.isTyping && i == chat.messages.length) return const _TypingIndicator();
              return _MessageBubble(message: chat.messages[i]);
            },
          ),
        ),

        // Input Bar
        _InputBar(controller: _controller, onSend: _sendMessage, isTyping: chat.isTyping),
      ]),
    );
  }
}

// ─── Empty State ─────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String selectedModel;
  const _EmptyState({required this.selectedModel});

  static const List<String> _suggestions = [
    'Analyze my API usage patterns',
    'Help me optimize model latency',
    'Summarize this quarter\'s metrics',
    'Write a Python script for batch inference',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.violetGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 40, spreadRadius: -4)],
              ),
              child: const Icon(LucideIcons.bot, size: 36, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text('Start a conversation', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 8),
            Text(
              'Ask $selectedModel anything — analyze, generate, reason.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
              children: _suggestions.map((s) => GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                borderRadius: 100,
                child: Text(s, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Message Bubble ──────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.violetGradient,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 12)],
              ),
              child: const Icon(LucideIcons.bot, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser ? AppColors.violetGradient : null,
                color: isUser ? null : AppColors.bgSurface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: isUser ? null : Border.all(color: AppColors.glassBorder),
                boxShadow: isUser
                    ? const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20, spreadRadius: -4)]
                    : null,
              ),
              child: Text(
                message.content,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isUser ? Colors.white : AppColors.textPrimary,
                  height: 1.6,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(gradient: AppColors.blueGradient, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Typing Indicator ────────────────────────────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with SingleTickerProviderStateMixin {
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
            child: const Icon(LucideIcons.bot, size: 14, color: Colors.white),
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

// ─── Input Bar ───────────────────────────────────────────────────────────────
class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isTyping;

  const _InputBar({required this.controller, required this.onSend, required this.isTyping});

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
                hintText: 'Message Zenith AI…',
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