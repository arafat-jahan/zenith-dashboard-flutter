// lib/features/api_keys/screens/api_keys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class _ApiKey {
  final String name, key, created, lastUsed;
  final bool isActive;
  final Color color;
  const _ApiKey({required this.name, required this.key, required this.created, required this.lastUsed, required this.isActive, required this.color});
}

class ApiKeysScreen extends StatelessWidget {
  const ApiKeysScreen({super.key});

  static const List<_ApiKey> _keys = [
    _ApiKey(name: 'Production API', key: 'zth-prod-••••••••••••••••3f8a', created: 'Jan 15, 2025', lastUsed: '2 hours ago', isActive: true, color: AppColors.accentGreen),
    _ApiKey(name: 'Development Key', key: 'zth-dev-••••••••••••••••9c2d', created: 'Feb 3, 2025', lastUsed: '1 day ago', isActive: true, color: AppColors.accentBlue),
    _ApiKey(name: 'CI/CD Pipeline', key: 'zth-ci-••••••••••••••••7b4e', created: 'Mar 1, 2025', lastUsed: '3 days ago', isActive: true, color: AppColors.accentViolet),
    _ApiKey(name: 'Legacy Key', key: 'zth-old-••••••••••••••••1a5f', created: 'Dec 10, 2024', lastUsed: '45 days ago', isActive: false, color: AppColors.textMuted),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('API Keys', style: AppTextStyles.displayMedium),
                    const SizedBox(height: 4),
                    Text('Manage your API credentials', style: AppTextStyles.bodyLarge),
                  ]),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.violetGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20)],
                    ),
                    child: Material(color: Colors.transparent,
                        child: InkWell(onTap: () {}, borderRadius: BorderRadius.circular(10),
                            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                child: Row(children: [
                                  const Icon(LucideIcons.plus, size: 15, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text('New Key', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                                ])))),
                  ),
                ],
              ),
            ),
          ),

          // Usage stats
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                final cards = [
                  _StatBox(title: 'Active Keys', value: '3', icon: LucideIcons.key, color: AppColors.accentGreen),
                  _StatBox(title: 'Total Requests', value: '48.3M', icon: LucideIcons.zap, color: AppColors.accentViolet),
                  _StatBox(title: 'Rate Limit', value: '10K/min', icon: LucideIcons.gauge, color: AppColors.accentBlue),
                  _StatBox(title: 'Quota Used', value: '38%', icon: LucideIcons.pieChart, color: AppColors.accentCyan),
                ];
                if (c.maxWidth > 700) {
                  return Row(children: cards.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList());
                }
                return GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.8, children: cards);
              }),
            ),
          ),

          // Keys list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            sliver: SliverToBoxAdapter(
              child: GlassCard(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Your API Keys', style: AppTextStyles.headlineMedium),
                    GradientBadge(label: '${_keys.where((k) => k.isActive).length} Active', gradient: AppColors.greenGradient),
                  ]),
                  const SizedBox(height: 4),
                  Text('Click the key to copy it', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 16),
                  ..._keys.map((k) => _KeyRow(apiKey: k)),
                ]),
              ),
            ),
          ),

          // Docs card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverToBoxAdapter(
              child: GlassCard(
                glowColor: AppColors.glowViolet,
                glowRadius: 20,
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1030), Color(0xFF0F1A2E)],
                ),
                borderColor: AppColors.accentViolet.withOpacity(0.3),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(gradient: AppColors.violetGradient, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(LucideIcons.bookOpen, size: 20, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('API Documentation', style: AppTextStyles.headlineMedium),
                    Text('Learn how to authenticate and use our REST API', style: AppTextStyles.bodySmall),
                  ])),
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    onTap: () {},
                    child: Row(children: [
                      Text('View Docs', style: AppTextStyles.labelLarge),
                      const SizedBox(width: 6),
                      const Icon(LucideIcons.externalLink, size: 13, color: AppColors.textMuted),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  const _StatBox({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: color.withOpacity(0.25),
      glowRadius: 16,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles.metricLarge.copyWith(fontSize: 22, color: color)),
        const SizedBox(height: 2),
        Text(title, style: AppTextStyles.bodySmall),
      ]),
    );
  }
}

class _KeyRow extends StatefulWidget {
  final _ApiKey apiKey;
  const _KeyRow({required this.apiKey});
  @override
  State<_KeyRow> createState() => _KeyRowState();
}

class _KeyRowState extends State<_KeyRow> {
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.apiKey.key));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final k = widget.apiKey;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.bgElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: k.isActive ? k.color.withOpacity(0.2) : AppColors.glassBorder),
        ),
        child: Row(children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(
            color: k.isActive ? k.color : AppColors.textMuted,
            shape: BoxShape.circle,
            boxShadow: k.isActive ? [BoxShadow(color: k.color.withOpacity(0.6), blurRadius: 6)] : null,
          )),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(k.name, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
              const SizedBox(width: 8),
              if (!k.isActive) GradientBadge(label: 'Revoked', gradient: const LinearGradient(colors: [AppColors.textMuted, AppColors.textDisabled])),
            ]),
            const SizedBox(height: 3),
            Text(k.key, style: AppTextStyles.bodySmall.copyWith(fontFamily: 'monospace')),
            const SizedBox(height: 3),
            Text('Created ${k.created} • Last used ${k.lastUsed}', style: AppTextStyles.bodySmall),
          ])),
          const SizedBox(width: 8),
          GlassCard(
            padding: const EdgeInsets.all(8),
            onTap: _copy,
            child: Icon(
              _copied ? LucideIcons.check : LucideIcons.copy,
              size: 14,
              color: _copied ? AppColors.accentGreen : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 6),
          GlassCard(
            padding: const EdgeInsets.all(8),
            child: const Icon(LucideIcons.trash2, size: 14, color: AppColors.accentRose),
          ),
        ]),
      ),
    );
  }
}