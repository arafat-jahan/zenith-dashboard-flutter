// lib/features/admin/screens/admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/config/app_config.dart';
import '../../../core/models/user_model.dart';
import '../providers/admin_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/glass_card.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _allUsers = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() => _filteredUsers = _allUsers);
    } else {
      _performSearch(query);
    }
  }

  Future<void> _performSearch(String query) async {
    setState(() => _isLoading = true);
    try {
      final admin = ref.read(adminProvider);
      final results = await admin.searchUsers(query);
      setState(() {
        _filteredUsers = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Search failed: ${e.toString()}'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _addCredits(String userId, String userName) async {
    final admin = ref.read(adminProvider);
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Credits'),
        content: Text('Add 50 credits to $userName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Add Credits'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await admin.addCredits(userId, 50);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added 50 credits successfully'),
              backgroundColor: Colors.green[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add credits: ${e.toString()}'),
              backgroundColor: Colors.red[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      }
    }
  }

  Future<void> _togglePlan(String userId, String currentPlan, String userName) async {
    final admin = ref.read(adminProvider);
    final newPlan = currentPlan == 'free' ? 'pro' : 'free';
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Toggle Plan'),
        content: Text('Change $userName\'s plan from $currentPlan to $newPlan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Change Plan'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await admin.toggleUserPlan(userId, currentPlan);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Changed plan to $newPlan successfully'),
              backgroundColor: Colors.green[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to change plan: ${e.toString()}'),
              backgroundColor: Colors.red[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final admin = ref.read(adminProvider);
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: StreamBuilder<List<UserModel>>(
        stream: admin.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentViolet),
            );
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.alertCircle, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading users',
                    style: AppTextStyles.headlineMedium.copyWith(color: Colors.red[400]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          
          final users = snapshot.data ?? [];
          if (_allUsers.isEmpty) {
            _allUsers = users;
            _filteredUsers = users;
          }
          return _buildContent();
        },
      ),
    );
  }

  Widget _buildContent() {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return Row(
      children: [
        // Main Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.violetGradient,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: AppColors.glowViolet, blurRadius: 16)],
                      ),
                      child: const Icon(LucideIcons.shield, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Dashboard',
                            style: AppTextStyles.displayMedium,
                          ),
                          Text(
                            'Manage users, credits, and plans',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Search Bar
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(LucideIcons.search, color: AppColors.textMuted, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search users by email...',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                            border: InputBorder.none,
                          ),
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.accentViolet,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Users',
                        '${_allUsers.length}',
                        LucideIcons.users,
                        AppColors.violetGradient,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Pro Users',
                        '${_allUsers.where((u) => u.plan == 'pro').length}',
                        LucideIcons.crown,
                        AppColors.goldGradient,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Free Users',
                        '${_allUsers.where((u) => u.plan == 'free').length}',
                        LucideIcons.user,
                        AppColors.blueGradient,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Users List
                Expanded(
                  child: GlassCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Users (${_filteredUsers.length})',
                          style: AppTextStyles.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: _filteredUsers.isEmpty
                              ? _buildEmptyState()
                              : _buildUsersList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Gradient gradient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: gradient.colors.first.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.metricLarge.copyWith(
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: gradient.colors,
                ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.searchX, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            'No users found',
            style: AppTextStyles.headlineSmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    return ListView.builder(
      itemCount: _filteredUsers.length,
      itemBuilder: (context, index) {
        final user = _filteredUsers[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(UserModel user) {
    final isPro = user.plan == 'pro';
    final isAdmin = user.role == 'admin';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: isPro ? AppColors.goldGradient : AppColors.violetGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: user.photoUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(user.photoUrl!, fit: BoxFit.cover),
                  )
                : Icon(
                    LucideIcons.user,
                    color: Colors.white,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(width: 8),
                    if (isAdmin)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          'ADMIN',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPro ? Colors.amber.withValues(alpha: 0.2) : Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isPro ? Colors.amber.withValues(alpha: 0.5) : Colors.blue.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        user.plan.toUpperCase(),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isPro ? Colors.amber : Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accentViolet.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.accentViolet.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.coins, size: 12, color: AppColors.accentViolet),
                          const SizedBox(width: 4),
                          Text(
                            '${user.credits}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.accentViolet,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              IconButton(
                onPressed: () => _addCredits(user.id, user.name),
                icon: Icon(LucideIcons.plusCircle, color: Colors.green[400]),
                tooltip: 'Add 50 Credits',
              ),
              IconButton(
                onPressed: () => _togglePlan(user.id, user.plan, user.name),
                icon: Icon(isPro ? LucideIcons.crown : LucideIcons.user, color: Colors.blue[400]),
                tooltip: 'Toggle Plan',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
