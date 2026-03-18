// lib/features/dashboard/widgets/recent_activity_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class _A { final String title, subtitle, time; final IconData icon; final Color color;
const _A({required this.title, required this.subtitle, required this.time, required this.icon, required this.color}); }

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});
  static const List<_A> _items = [
    _A(title:'New enterprise subscription', subtitle:'Acme Corp — Ultra Plan',        time:'2m ago',  icon:LucideIcons.sparkles,     color:AppColors.accentViolet),
    _A(title:'API rate limit alert',         subtitle:'User #48291 — resolved',        time:'14m ago', icon:LucideIcons.alertTriangle, color:AppColors.accentAmber),
    _A(title:'Model fine-tune complete',     subtitle:'custom-v3 — 98.2% accuracy',   time:'1h ago',  icon:LucideIcons.checkCircle2,  color:AppColors.accentGreen),
    _A(title:'New region deployed',          subtitle:'AP-Southeast-2 online',         time:'3h ago',  icon:LucideIcons.globe,         color:AppColors.accentBlue),
    _A(title:'Billing cycle renewed',        subtitle:'243 accounts auto-renewed',     time:'6h ago',  icon:LucideIcons.creditCard,    color:AppColors.accentCyan),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Recent Activity', style: AppTextStyles.headlineMedium),
          Text('View all', style: AppTextStyles.bodySmall.copyWith(color: AppColors.accentViolet)),
        ]),
        const SizedBox(height: 16),
        ...List.generate(_items.length, (i) => Column(children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: _items[i].color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                child: Icon(_items[i].icon, size: 14, color: _items[i].color)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_items[i].title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
              Text(_items[i].subtitle, style: AppTextStyles.bodySmall),
            ])),
            Text(_items[i].time, style: AppTextStyles.bodySmall),
          ]),
          if (i < _items.length - 1)
            const Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: AppColors.glassBorder, height: 1)),
        ])),
      ]),
    );
  }
}