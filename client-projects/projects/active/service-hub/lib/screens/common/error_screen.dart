import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// Error Screen
///
/// Displays when an error occurs during app operation.
/// Allows users to retry or return to home screen.
class ErrorScreen extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;

  const ErrorScreen({
    Key? key,
    this.message = 'An unexpected error occurred',
    this.title = 'Error',
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerService.error('ErrorScreen: $message');

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Error'),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
              const SizedBox(height: AppSizes.spacing24),
              Text(
                title ?? 'Error',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing16),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacing32),
              ElevatedButton(
                onPressed: onRetry ?? () => Navigator.of(context).pop(),
                child: const Text('Try Again'),
              ),
              const SizedBox(height: AppSizes.spacing12),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
