import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/auth/auth_provider.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                ((user?['fullName'] as String?) ?? 'U')[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user?['fullName'] as String? ?? 'N/A',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Center(
            child: Text(
              user?['email'] as String? ?? 'N/A',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Chip(
              label: Text(user?['role'] as String? ?? 'N/A'),
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          _ProfileTile(
            icon: Icons.person,
            title: 'Full Name',
            subtitle: user?['fullName'] as String? ?? 'N/A',
          ),
          _ProfileTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: user?['email'] as String? ?? 'N/A',
          ),
          _ProfileTile(
            icon: Icons.badge,
            title: 'Role',
            subtitle: user?['role'] as String? ?? 'N/A',
          ),
          const Divider(),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.danger),
            title: const Text('Logout', style: TextStyle(color: AppColors.danger)),
            onTap: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
