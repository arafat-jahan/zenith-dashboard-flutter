// lib/features/settings/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/staggered_entry.dart';
import '../widgets/widgets.dart';

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
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Settings', style: AppTextStyles.displayMedium),
                const SizedBox(height: 4),
                Text('Manage your account and preferences', style: AppTextStyles.bodyLarge),
              ]),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(builder: (ctx, c) {
                final content = c.maxWidth > 800
                    ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Expanded(child: Column(children: [
                    ProfileCard(),
                    SizedBox(height: 24),
                    SecurityCard(),
                  ])),
                  const SizedBox(width: 24),
                  Expanded(child: Column(children: [
                    const NotificationsCard(),
                    const SizedBox(height: 24),
                    const PreferencesCard(),
                    const SizedBox(height: 24),
                    const DangerZoneCard(),
                  ])),
                ])
                    : const Column(children: [
                  ProfileCard(), SizedBox(height: 24),
                  SecurityCard(), SizedBox(height: 24),
                  NotificationsCard(), SizedBox(height: 24),
                  PreferencesCard(), SizedBox(height: 24),
                  DangerZoneCard(),
                ]);

                return StaggeredEntry(delay: 0, child: content);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
