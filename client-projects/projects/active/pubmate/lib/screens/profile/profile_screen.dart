import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizes.dart';
import '../../providers/auth_provider.dart';
import '../../services/logger_service.dart';

/// Profile Screen
///
/// Displays user profile information including avatar, name, email, and other details.
/// Allows navigation to edit profile, change password, and other profile-related actions.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    LoggerService.info('ProfileScreen: Initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile
              // Navigator.of(context).pushNamed('/edit-profile');
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.spacing24),

                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.spacing24),

                // Name
                Text(
                  'User Name',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacing8),

                // Email
                Text(
                  'user@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacing32),

                // Profile information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Phone', '+1 234 567 8900'),
                        Divider(height: AppSizes.spacing24),
                        _buildInfoRow('Location', 'New York, USA'),
                        Divider(height: AppSizes.spacing24),
                        _buildInfoRow('Member Since', 'January 2025'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spacing24),

                // Actions
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle change password
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notification_important),
                  title: const Text('Notification Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle notification settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            );
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthProvider>().logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
