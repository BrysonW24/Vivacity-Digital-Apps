/// Environment Configuration
///
/// Manages environment-specific settings and API endpoints.
/// Load from environment variables or .env file.
class Env {
  static const String appName = 'Personal Journal';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com';
  static const String apiTimeout = '30'; // seconds
  static const bool enableApiLogging = true;

  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableCrashReporting = true;

  // Debug
  static const bool isDebugMode = true;
  static const bool showDebugBanner = true;

  /// Get current environment (development, staging, production)
  static const String environment = 'development';

  /// Check if app is in development mode
  static bool get isDevelopment => environment == 'development';

  /// Check if app is in staging mode
  static bool get isStaging => environment == 'staging';

  /// Check if app is in production mode
  static bool get isProduction => environment == 'production';
}
