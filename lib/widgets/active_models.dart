import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_kit/theme/app_theme.dart';

class ActiveModels extends StatelessWidget {
  const ActiveModels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active AI Models',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '8 Active',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ModelItem(
            icon: LucideIcons.cpu,
            name: 'GPT-4 Turbo',
            provider: 'OpenAI',
            requests: '1.2 M',
            latency: '120ms',
            statusColor: AppColors.primary,
          ),
          _ModelItem(
            icon: LucideIcons.messageSquare,
            name: 'Claude 3.5 Sonnet',
            provider: 'Anthropic',
            requests: '850 K',
            latency: '145ms',
            statusColor: AppColors.primary,
          ),
          _ModelItem(
            icon: LucideIcons.image,
            name: 'DALL-E 3',
            provider: 'OpenAI',
            requests: '230 K',
            latency: '2.3s',
            statusColor: AppColors.primary,
          ),
          _ModelItem(
            icon: LucideIcons.code,
            name: 'Code Llama',
            provider: 'Meta',
            requests: '120 K',
            latency: '95ms',
            statusColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _ModelItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String provider;
  final String requests;
  final String latency;
  final Color statusColor;

  const _ModelItem({
    required this.icon,
    required this.name,
    required this.provider,
    required this.requests,
    required this.latency,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  provider,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                requests,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                latency,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
