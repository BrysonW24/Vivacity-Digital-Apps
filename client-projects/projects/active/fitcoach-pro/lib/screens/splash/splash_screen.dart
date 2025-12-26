import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/assets.dart';
import '../../services/logger_service.dart';

/// Splash Screen
///
/// Initial screen displayed while app initializes.
/// Typically shown for 2-3 seconds before routing to appropriate screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      LoggerService.info('SplashScreen: Initializing');

      // Simulate initialization delay (remove in production)
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Check authentication state and navigate accordingly
      // Example:
      // if (mounted) {
      //   final authProvider = context.read<AuthProvider>();
      //   if (authProvider.isAuthenticated) {
      //     Navigator.of(context).pushReplacementNamed('/home');
      //   } else {
      //     Navigator.of(context).pushReplacementNamed('/login');
      //   }
      // }

    } catch (e) {
      LoggerService.error('SplashScreen: Initialization failed', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to initialize app')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                Assets.Images.logo,
                width: 120,
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.onPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Icon(
                      Icons.app_shortcut,
                      size: 60,
                      color: AppColors.onPrimary,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // App Name
              Text(
                'Small App',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              Text(
                'Production-ready Flutter boilerplate',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onPrimary.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 48),

              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.onPrimary,
                  ),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Initializing...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onPrimary.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
