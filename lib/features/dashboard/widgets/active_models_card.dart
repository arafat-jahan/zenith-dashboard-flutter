// lib/features/dashboard/widgets/active_models_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';

class _M { final String name, latency, requests; final Color color; final double uptime;
const _M({required this.name, required this.latency, required this.requests, required this.color, required this.uptime}); }

class ActiveModelsCard extends StatelessWidget {
  const ActiveModelsCard({super.key});
  static const List<_M> _models = [
    _M(name:'Zenith Ultra', latency:'187ms', requests:'1.2M/d', color:AppColors.accentViolet, uptime:99.9),
    _M(name:'Zenith Pro',   latency:'94ms',  requests:'2.3M/d', color:AppColors.accentBlue,   uptime:99.7),
    _M(name:'Zenith Flash', latency:'23ms',  requests:'8.1M/d', color:AppColors.accentCyan,   uptime:100.0),
    _M(name:'Zenith Nano',  latency:'9ms',   requests:'14M/d',  color:AppColors.accentGreen,  uptime:99.8),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: AppColors.glowBlue, glowRadius: 24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Active Models', style: AppTextStyles.headlineMedium),
          GradientBadge(label: '4 Online', gradient: AppColors.greenGradient),
        ]),
        const SizedBox(height: 4),
        Text('Live inference endpoints', style: AppTextStyles.bodySmall),
        const SizedBox(height: 16),
        ...List.generate(_models.length, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(
              color: _models[i].color, shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: _models[i].color.withOpacity(0.7), blurRadius: 8)],
            )),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_models[i].name, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
              const SizedBox(height: 2),
              ClipRRect(borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(value: _models[i].uptime / 100, minHeight: 3,
                      backgroundColor: AppColors.bgElevated,
                      valueColor: AlwaysStoppedAnimation<Color>(_models[i].color))),
            ])),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(children: [
                Icon(LucideIcons.timer, size: 10, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(_models[i].latency, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
              ]),
              const SizedBox(height: 2),
              Text(_models[i].requests, style: AppTextStyles.bodySmall),
            ]),
          ]),
        )),
      ]),
    );
  }
}