import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_badge.dart';


final _notifEmailProvider = StateProvider<bool>((ref) => true);
final _notifSlackProvider = StateProvider<bool>((ref) => false);
final _notifSmsProvider = StateProvider<bool>((ref) => true);
final _2faProvider = StateProvider<bool>((ref) => true);
final _darkModeProvider = StateProvider<bool>((ref) => true);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Settings', style: AppTextStyles.displayMedium),
                const SizedBox(height: 4),
                Text('Manage your account and preferences', style: AppTextStyles.bodyLarge),
              ]),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                if (c.maxWidth > 800) {
                  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: Column(children: [
                      const _ProfileCard(),
                      const SizedBox(height: 16),
                      const _SecurityCard(),
                    ])),
                    const SizedBox(width: 16),
                    Expanded(child: Column(children: [
                      _NotificationsCard(ref: ref),
                      const SizedBox(height: 16),
                      const _PreferencesCard(),
                      const SizedBox(height: 16),
                      const _DangerZoneCard(),
                    ])),
                  ]);
                }
                return Column(children: [
                  const _ProfileCard(), const SizedBox(height: 16),
                  const _SecurityCard(), const SizedBox(height: 16),
                  _NotificationsCard(ref: ref), const SizedBox(height: 16),
                  const _PreferencesCard(), const SizedBox(height: 16),
                  const _DangerZoneCard(),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Profile', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Update your personal information', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        Row(children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              gradient: AppColors.violetGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 20)],
            ),
            child: const Center(child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800))),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('John Dev', style: AppTextStyles.headlineMedium),
            Text('john@company.com', style: AppTextStyles.bodySmall),
            const SizedBox(height: 6),
            GradientBadge(label: 'Pro Plan', gradient: AppColors.violetGradient),
          ])),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            onTap: () {},
            child: Text('Edit', style: AppTextStyles.labelLarge),
          ),
        ]),
        const SizedBox(height: 20),
        const Divider(color: AppColors.glassBorder),
        const SizedBox(height: 16),
        _SettingRow(label: 'Full Name', value: 'John Developer'),
        _SettingRow(label: 'Email', value: 'john@company.com'),
        _SettingRow(label: 'Company', value: 'Acme Corp'),
        _SettingRow(label: 'Timezone', value: 'UTC+6 (Dhaka)'),
      ]),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Security', style: AppTextStyles.headlineMedium),
          const Icon(LucideIcons.shieldCheck, size: 18, color: AppColors.accentGreen),
        ]),
        const SizedBox(height: 4),
        Text('Protect your account', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        _SecurityItem(icon: LucideIcons.lock, title: 'Password', subtitle: 'Last changed 30 days ago', action: 'Change'),
        const Divider(color: AppColors.glassBorder, height: 24),
        _SecurityItem(icon: LucideIcons.smartphone, title: 'Two-Factor Auth', subtitle: 'Authenticator app enabled', action: 'Manage', isEnabled: true),
        const Divider(color: AppColors.glassBorder, height: 24),
        _SecurityItem(icon: LucideIcons.monitor, title: 'Active Sessions', subtitle: '3 devices logged in', action: 'View'),
      ]),
    );
  }
}

class _SecurityItem extends StatelessWidget {
  final IconData icon;
  final String title, subtitle, action;
  final bool isEnabled;
  const _SecurityItem({required this.icon, required this.title, required this.subtitle, required this.action, this.isEnabled = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.accentViolet.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 15, color: AppColors.accentViolet),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ])),
      if (isEnabled) GradientBadge(label: 'Active', gradient: AppColors.greenGradient),
      const SizedBox(width: 8),
      GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        onTap: () {},
        child: Text(action, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
      ),
    ]);
  }
}

class _NotificationsCard extends StatelessWidget {
  final WidgetRef ref;
  const _NotificationsCard({required this.ref});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Notifications', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Choose how you want to be notified', style: AppTextStyles.bodySmall),
        const SizedBox(height: 20),
        _ToggleRow(ref: ref, provider: _notifEmailProvider, icon: LucideIcons.mail, title: 'Email Alerts', subtitle: 'Usage limits & billing'),
        const Divider(color: AppColors.glassBorder, height: 20),
        _ToggleRow(ref: ref, provider: _notifSlackProvider, icon: LucideIcons.slack, title: 'Slack Integration', subtitle: 'Real-time incident alerts'),
        const Divider(color: AppColors.glassBorder, height: 20),
        _ToggleRow(ref: ref, provider: _notifSmsProvider, icon: LucideIcons.messageSquare, title: 'SMS Alerts', subtitle: 'Critical system events only'),
      ]),
    );
  }
}

class _ToggleRow extends ConsumerWidget {
  final WidgetRef ref;
  final StateProvider<bool> provider;
  final IconData icon;
  final String title, subtitle;
  const _ToggleRow({required this.ref, required this.provider, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context, WidgetRef r) {
    final val = r.watch(provider);
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bgElevated, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 15, color: AppColors.textSecondary),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ])),
      Switch(
        value: val,
        onChanged: (v) => r.read(provider.notifier).state = v,
        activeColor: AppColors.accentViolet,
        activeTrackColor: AppColors.accentViolet.withOpacity(0.3),
        inactiveTrackColor: AppColors.bgElevated,
        inactiveThumbColor: AppColors.textMuted,
      ),
    ]);
  }
}

class _PreferencesCard extends StatelessWidget {
  const _PreferencesCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Preferences', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 16),
        _SettingRow(label: 'Language', value: 'English (US)'),
        _SettingRow(label: 'Date Format', value: 'MM/DD/YYYY'),
        _SettingRow(label: 'Currency', value: 'USD (\$)'),
        _SettingRow(label: 'Theme', value: 'Dark (Deep Charcoal)'),
      ]),
    );
  }
}

class _DangerZoneCard extends StatelessWidget {
  const _DangerZoneCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: AppColors.accentRose.withOpacity(0.3),
      glowColor: AppColors.accentRose.withOpacity(0.1),
      glowRadius: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(LucideIcons.alertTriangle, size: 16, color: AppColors.accentRose),
          const SizedBox(width: 8),
          Text('Danger Zone', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.accentRose)),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Delete Account', style: AppTextStyles.headlineSmall.copyWith(fontSize: 13)),
            Text('Permanently delete all data', style: AppTextStyles.bodySmall),
          ])),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentRose.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(color: Colors.transparent,
                child: InkWell(onTap: () {}, borderRadius: BorderRadius.circular(8),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Text('Delete', style: AppTextStyles.labelLarge.copyWith(color: AppColors.accentRose))))),
          ),
        ]),
      ]),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label, value;
  const _SettingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTextStyles.bodySmall),
        Text(value, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
      ]),
    );
  }
}