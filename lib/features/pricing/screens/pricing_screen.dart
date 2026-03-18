// lib/features/pricing/screens/pricing_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../core/services/stripe_mock_service.dart';

class _Plan {
  final String id, name, tagline, cta;
  final double monthlyPrice, annualPrice;
  final List<String> features, limits;
  final Gradient gradient;
  final Color glowColor;
  final bool isPopular;
  const _Plan({required this.id, required this.name, required this.tagline,
    required this.monthlyPrice, required this.annualPrice, required this.features,
    required this.limits, required this.gradient, required this.glowColor,
    this.isPopular = false, required this.cta});
}

class PricingScreen extends ConsumerWidget {
  const PricingScreen({super.key});

  static const List<_Plan> _plans = [
    _Plan(
      id: 'starter', name: 'Starter', tagline: 'For solo builders & experimentation',
      monthlyPrice: 0, annualPrice: 0, cta: 'Get Started Free',
      features: ['100K tokens / month','Zenith Nano & Flash','Community support','REST API access','Basic analytics'],
      limits: ['No fine-tuning','No SLA guarantee','Rate limited 10 req/s'],
      gradient: LinearGradient(colors: [Color(0xFF1E1E2E), Color(0xFF2A2A3E)]),
      glowColor: Color(0x2294A3B8),
    ),
    _Plan(
      id: 'pro', name: 'Pro', tagline: 'For growing startups & teams',
      monthlyPrice: 59, annualPrice: 49, isPopular: true, cta: 'Start Pro Trial',
      features: ['10B tokens / month','All models incl. Ultra','Priority support < 4h',
        'Advanced analytics','Fine-tuning (3 models)','99.9% uptime SLA','Webhooks & streaming','10 team seats'],
      limits: [],
      gradient: AppColors.violetGradient,
      glowColor: AppColors.glowViolet,
    ),
    _Plan(
      id: 'enterprise', name: 'Enterprise', tagline: 'For scaling companies & platforms',
      monthlyPrice: 299, annualPrice: 249, cta: 'Contact Sales',
      features: ['Unlimited tokens','All + custom models','Dedicated support engineer',
        'Custom SLA up to 99.99%','Unlimited fine-tuning','Private cloud deploy',
        'SSO / SAML / SCIM','Audit logs & compliance','Unlimited seats'],
      limits: [],
      gradient: AppColors.blueGradient,
      glowColor: AppColors.glowBlue,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billing = ref.watch(selectedBillingCycleProvider);
    final selected = ref.watch(selectedPlanProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
            child: Column(children: [
              GradientBadge(label: '🚀  Launch pricing — Save 17%', gradient: AppColors.violetGradient),
              const SizedBox(height: 16),
              Text('Simple, transparent pricing', style: AppTextStyles.displayLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text('Start free. Scale as you grow. No surprise bills.', style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              // Billing Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  _ToggleBtn(label: 'Monthly', isSelected: billing == 'monthly', onTap: () => ref.read(selectedBillingCycleProvider.notifier).state = 'monthly'),
                  _ToggleBtn(label: 'Annual', isSelected: billing == 'annual', badge: 'Save 17%', onTap: () => ref.read(selectedBillingCycleProvider.notifier).state = 'annual'),
                ]),
              ),
            ]),
          ),
        ),

        // Plan Cards
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (ctx, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _plans.map((p) => Expanded(
                    child: Padding(padding: const EdgeInsets.only(right: 16),
                        child: _PlanCard(plan: p, billing: billing, isSelected: selected == p.id,
                            onSelect: () => ref.read(selectedPlanProvider.notifier).state = p.id)),
                  )).toList(),
                );
              }
              return Column(children: _plans.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _PlanCard(plan: p, billing: billing, isSelected: selected == p.id,
                    onSelect: () => ref.read(selectedPlanProvider.notifier).state = p.id),
              )).toList());
            }),
          ),
        ),

        // FAQ
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 16),
          sliver: SliverToBoxAdapter(child: _FaqSection()),
        ),

        // Enterprise CTA
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
          sliver: SliverToBoxAdapter(child: _EnterpriseCta()),
        ),
      ]),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label; final bool isSelected; final VoidCallback onTap; final String? badge;
  const _ToggleBtn({required this.label, required this.isSelected, required this.onTap, this.badge});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(gradient: isSelected ? AppColors.violetGradient : null, borderRadius: BorderRadius.circular(9)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: AppTextStyles.labelLarge.copyWith(
            color: isSelected ? Colors.white : AppColors.textMuted,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          )),
          if (badge != null) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : AppColors.accentGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(badge!, style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.accentGreen,
              )),
            ),
          ],
        ]),
      ),
    );
  }
}

class _PlanCard extends ConsumerWidget {
  final _Plan plan; final String billing; final bool isSelected; final VoidCallback onSelect;
  const _PlanCard({required this.plan, required this.billing, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = billing == 'annual' ? plan.annualPrice : plan.monthlyPrice;
    final isFree = price == 0;
    final user = ref.watch(authStateProvider).value;

    return GlassCard(
      glowColor: isSelected ? plan.glowColor : Colors.transparent,
      glowRadius: 32,
      borderColor: isSelected ? plan.gradient.colors.first.withOpacity(0.5) : AppColors.glassBorder,
      padding: const EdgeInsets.all(24),
      onTap: onSelect,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (plan.isPopular)
          Padding(padding: const EdgeInsets.only(bottom: 12),
              child: GradientBadge(label: '⚡  Most Popular', gradient: plan.gradient)),
        Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(gradient: plan.gradient, borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: plan.glowColor, blurRadius: 14)]),
            child: const Icon(LucideIcons.zap, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(plan.name, style: AppTextStyles.headlineMedium),
        ]),
        const SizedBox(height: 8),
        Text(plan.tagline, style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(isFree ? 'Free' : '\$${price.toInt()}', style: AppTextStyles.metricHuge.copyWith(fontSize: 38)),
          if (!isFree)
            Padding(padding: const EdgeInsets.only(bottom: 6),
                child: Text('/mo', style: AppTextStyles.bodyMedium)),
        ]),
        if (!isFree && billing == 'annual')
          Text('Billed annually — \$${(price * 12).toInt()}/yr', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: plan.isPopular ? plan.gradient : null,
              border: plan.isPopular ? null : Border.all(color: AppColors.glassBorder),
              borderRadius: BorderRadius.circular(10),
              boxShadow: plan.isPopular ? [BoxShadow(color: plan.glowColor, blurRadius: 24, spreadRadius: -4)] : null,
            ),
            child: Material(color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    if (user != null) {
                      final stripe = StripeMockService(uid: user.uid);
                      final success = await stripe.subscribeToPlan(plan.id);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully subscribed to ${plan.name}!')),
                        );
                        ref.invalidate(userProfileProvider);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please login to subscribe')),
                      );
                    }
                  }, 
                  borderRadius: BorderRadius.circular(10),
                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Text(plan.cta, textAlign: TextAlign.center,
                            style: AppTextStyles.labelLarge.copyWith(
                                color: plan.isPopular ? Colors.white : AppColors.textSecondary,
                                fontWeight: FontWeight.w600))))),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: AppColors.glassBorder, height: 1)),
        Text('What\'s included:', style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ...plan.features.map((f) => _FeatureRow(label: f, included: true)),
        if (plan.limits.isNotEmpty) ...[
          const SizedBox(height: 6),
          ...plan.limits.map((f) => _FeatureRow(label: f, included: false)),
        ],
      ]),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String label; final bool included;
  const _FeatureRow({required this.label, required this.included});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(included ? LucideIcons.check : LucideIcons.x, size: 14,
            color: included ? AppColors.accentGreen : AppColors.textMuted),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: AppTextStyles.bodySmall.copyWith(
            color: included ? AppColors.textSecondary : AppColors.textMuted))),
      ]),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection();
  static const List<Map<String, String>> _faqs = [
    {'q': 'Can I switch plans anytime?', 'a': 'Yes. Upgrades take effect immediately and you\'re billed pro-rata. Downgrades take effect at the next billing cycle.'},
    {'q': 'What happens if I exceed my token limit?', 'a': 'On the Pro plan, we\'ll notify you at 80% and 95% usage. You can enable auto top-up or upgrade. We never cut off service without warning.'},
    {'q': 'Is there a free trial for Pro?', 'a': 'Yes — all Pro features are free for 14 days. No credit card required to start.'},
    {'q': 'Do you offer academic or non-profit pricing?', 'a': 'Yes. Contact us for 50% off Enterprise plans for qualifying institutions.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Frequently asked questions', style: AppTextStyles.headlineLarge),
      const SizedBox(height: 20),
      ..._faqs.map((f) => _FaqItem(question: f['q']!, answer: f['a']!)),
    ]);
  }
}

class _FaqItem extends StatefulWidget {
  final String question, answer;
  const _FaqItem({required this.question, required this.answer});
  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _open = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: EdgeInsets.zero, onTap: () => setState(() => _open = !_open),
        child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(widget.question, style: AppTextStyles.headlineSmall)),
            Icon(_open ? LucideIcons.chevronUp : LucideIcons.chevronDown, size: 16, color: AppColors.textMuted),
          ]),
          if (_open) ...[
            const SizedBox(height: 10),
            Text(widget.answer, style: AppTextStyles.bodyMedium),
          ],
        ])),
      ),
    );
  }
}

class _EnterpriseCta extends StatelessWidget {
  const _EnterpriseCta();
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowColor: AppColors.glowViolet, glowRadius: 40,
      gradient: const LinearGradient(colors: [Color(0xFF1A1030), Color(0xFF0F1A2E)]),
      borderColor: AppColors.accentViolet,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: AppColors.violetGradient, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 30)]),
          child: const Icon(LucideIcons.building2, size: 28, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Text('Need a custom plan?', style: AppTextStyles.headlineLarge, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text('We\'ll build a tailored package for your scale, compliance needs, and team size.',
            style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(gradient: AppColors.violetGradient, borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20)]),
            child: Material(color: Colors.transparent,
                child: InkWell(onTap: () {}, borderRadius: BorderRadius.circular(10),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                        child: Row(children: [
                          const Icon(LucideIcons.calendar, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Text('Book a Demo', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                        ])))),
          ),
          const SizedBox(width: 12),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13), onTap: () {},
            child: Row(children: [
              const Icon(LucideIcons.mail, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text('Contact Sales', style: AppTextStyles.labelLarge),
            ]),
          ),
        ]),
      ]),
    );
  }
}