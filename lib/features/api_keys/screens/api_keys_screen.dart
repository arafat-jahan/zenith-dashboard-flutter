// lib/features/api_keys/screens/api_keys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/base_shimmer.dart';
import '../providers/api_keys_provider.dart';
import '../widgets/api_key_card.dart';
import '../widgets/api_stat_box.dart';

class ApiKeysScreen extends ConsumerWidget {
  const ApiKeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keysAsync = ref.watch(apiKeysProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('API Keys', style: AppTextStyles.displayMedium),
                    const SizedBox(height: 4),
                    Text('Manage your access credentials', style: AppTextStyles.bodyLarge),
                  ]),
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    onTap: () {},
                    glowColor: AppColors.glowViolet,
                    borderColor: AppColors.accentViolet.withValues(alpha: 0.5),
                    child: Row(children: [
                      const Icon(LucideIcons.plus, size: 16, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Create new key', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ]),
                const SizedBox(height: 24),
                Row(children: [
                  const Expanded(child: ApiStatBox(label: 'Total Keys', value: '12', icon: LucideIcons.key, color: AppColors.accentViolet)),
                  const SizedBox(width: 12),
                  const Expanded(child: ApiStatBox(label: 'Active Now', value: '4', icon: LucideIcons.zap, color: AppColors.accentGreen)),
                  const SizedBox(width: 12),
                  Expanded(child: ApiStatBox(label: 'Requests/min', value: '2.4k', icon: LucideIcons.barChart, color: AppColors.accentBlue.withValues(alpha: 0.8))),
                ]),
              ]),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: keysAsync.when(
              data: (keys) => SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 200,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => ApiKeyCard(credential: keys[i]),
                  childCount: keys.length,
                ),
              ),
              loading: () => SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 200,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => const BaseShimmer(height: 200),
                  childCount: 4,
                ),
              ),
              error: (err, _) => SliverToBoxAdapter(child: Center(child: Text('Error: $err'))),
            ),
          ),
        ],
      ),
    );
  }
}
