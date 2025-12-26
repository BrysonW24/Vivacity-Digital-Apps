import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// What's New Screen
///
/// Displays changelog and new features/updates for the current app version.
/// Shows release notes, improvements, and bug fixes.
class WhatsNewScreen extends StatelessWidget {
  const WhatsNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerService.info('WhatsNewScreen: Opened');

    return Scaffold(
      appBar: AppBar(
        title: const Text('What\'s New'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Version header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.spacing24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Text(
                    'Released on December 1, 2025',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSizes.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New features
                  _buildSection(
                    context,
                    title: '✨ New Features',
                    icon: Icons.star,
                    items: [
                      'Beautiful new user interface with Material Design 3',
                      'Dark mode support for comfortable usage',
                      'Push notifications for important updates',
                      'Offline mode support',
                      'Search functionality across app content',
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),

                  // Improvements
                  _buildSection(
                    context,
                    title: '⚡ Improvements',
                    icon: Icons.trending_up,
                    items: [
                      'Faster app startup time',
                      'Improved performance and reduced memory usage',
                      'Better error messages and user guidance',
                      'Enhanced security with two-factor authentication',
                      'Smoother animations and transitions',
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),

                  // Bug fixes
                  _buildSection(
                    context,
                    title: '🐛 Bug Fixes',
                    icon: Icons.bug_report,
                    items: [
                      'Fixed login form validation issues',
                      'Resolved notification delivery problems',
                      'Fixed profile image upload failures',
                      'Corrected timezone handling in datetime display',
                      'Fixed memory leaks in background services',
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),

                  // Known issues
                  _buildSection(
                    context,
                    title: '⚠️ Known Issues',
                    icon: Icons.warning_amber,
                    items: [
                      'Large file uploads may timeout on slow connections',
                      'Some features require internet connectivity',
                      'Certain older devices may experience performance issues',
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),

                  // Feedback
                  Container(
                    padding: const EdgeInsets.all(AppSizes.spacing16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have feedback about this version?',
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Text(
                          'We\'d love to hear what you think! Send us your feedback through the feedback form.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSizes.spacing12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to feedback screen
                              // Navigator.of(context).pushNamed('/feedback');
                            },
                            child: const Text('Send Feedback'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Theme.of(context).primaryColor),
            const SizedBox(width: AppSizes.spacing12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacing16),
        ...items
            .map(
              (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.spacing12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: AppSizes.spacing4),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spacing12),
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        )
            .toList(),
      ],
    );
  }
}
