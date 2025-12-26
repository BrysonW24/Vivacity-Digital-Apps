import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// Maintenance Screen
///
/// Displayed when app is under maintenance.
class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerService.warning('MaintenanceScreen: App under maintenance');
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 80, color: Colors.grey[600]),
              const SizedBox(height: AppSizes.spacing24),
              Text(
                'Under Maintenance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing16),
              Text(
                'We are currently performing maintenance. Please check back later.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing32),
              Text(
                'Estimated time: 1 hour',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
