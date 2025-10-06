import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/config/app_config.dart';
import '../../../auth/data/repositories/auth_repository.dart';

/// Profile page with user information
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, authRepository),
          ),
        ],
      ),
      body: authAsync.when(
        data: (user) => user == null
            ? _buildNotLoggedInState(context)
            : _buildProfileContent(context, user),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorState(context, error.toString()),
      ),
    );
  }

  Widget _buildNotLoggedInState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Not logged in',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Please log in to view your profile',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConfig.defaultPadding),
      child: Column(
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConfig.defaultPadding * 2),
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: user.avatar != null
                        ? CachedNetworkImageProvider(user.avatar!)
                        : null,
                    child: user.avatar == null
                        ? Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  )
                      .animate()
                      .scale(duration: AppConfig.mediumAnimation, curve: Curves.elasticOut),
                  
                  const SizedBox(height: 16),
                  
                  // Name
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate(delay: 200.ms)
                      .fadeIn()
                      .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 8),
                  
                  // Email
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  )
                      .animate(delay: 400.ms)
                      .fadeIn()
                      .slideY(begin: 0.2, end: 0),
                  
                  if (user.phone != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      user.phone!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    )
                        .animate(delay: 600.ms)
                        .fadeIn()
                        .slideY(begin: 0.2, end: 0),
                  ],
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Profile Actions
          _buildActionCard(
            context,
            'Edit Profile',
            'Update your personal information',
            Icons.edit,
            () {
              // TODO: Navigate to edit profile
            },
          )
              .animate(delay: 800.ms)
              .fadeIn()
              .slideX(begin: -0.2, end: 0),
          
          const SizedBox(height: 12),
          
          _buildActionCard(
            context,
            'Settings',
            'Manage your app preferences',
            Icons.settings,
            () {
              // TODO: Navigate to settings
            },
          )
              .animate(delay: 1000.ms)
              .fadeIn()
              .slideX(begin: -0.2, end: 0),
          
          const SizedBox(height: 12),
          
          _buildActionCard(
            context,
            'Help & Support',
            'Get help and contact support',
            Icons.help_outline,
            () {
              // TODO: Navigate to help
            },
          )
              .animate(delay: 1200.ms)
              .fadeIn()
              .slideX(begin: -0.2, end: 0),
          
          const SizedBox(height: 12),
          
          _buildActionCard(
            context,
            'About',
            'App version and information',
            Icons.info_outline,
            () {
              _showAboutDialog(context);
            },
          )
              .animate(delay: 1400.ms)
              .fadeIn()
              .slideX(begin: -0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading profile',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, authRepository) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await authRepository.logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Base Mobile',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.mobile_friendly, size: 48),
      children: [
        const Text('A beautiful Flutter mobile app with modern UI and API integration.'),
      ],
    );
  }
}
