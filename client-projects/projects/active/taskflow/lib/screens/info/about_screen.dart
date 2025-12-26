import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// About Screen
///
/// Displays information about the app including version, developer info, and links.
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerService.info('AboutScreen: Opened');

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.spacing16),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  Text(
                    'Small App',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacing32),
            Text(
              'About',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacing12),
            Text(
              'Production-ready Flutter boilerplate with clean architecture and best practices.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSizes.spacing32),
            ListTile(
              title: const Text('Website'),
              subtitle: const Text('www.example.com'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: const Text('support@example.com'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
