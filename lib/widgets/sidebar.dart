import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_kit/theme/app_theme.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          right: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(LucideIcons.zap, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'NeuralFlow',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _SidebarItem(icon: LucideIcons.layout, label: 'Overview', isActive: true),
          const _SidebarItem(icon: LucideIcons.cpu, label: 'AI Models'),
          const _SidebarItem(icon: LucideIcons.barChart, label: 'Analytics'),
          const _SidebarItem(icon: LucideIcons.database, label: 'Data Sources'),
          const _SidebarItem(icon: LucideIcons.layers, label: 'Integrations'),
          const Spacer(),
          const _SidebarItem(icon: LucideIcons.users, label: 'Team'),
          const _SidebarItem(icon: LucideIcons.creditCard, label: 'Billing'),
          const _SidebarItem(icon: LucideIcons.settings, label: 'Settings'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {},
        dense: true,
        leading: Icon(
          icon,
          size: 18,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
