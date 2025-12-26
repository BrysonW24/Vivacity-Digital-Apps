/// Application-wide configuration constants and initialization
class AppConfig {
  static const String appName = 'Production Flutter App';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com';
  static const int apiTimeoutSeconds = 30;
  static const int apiRetryAttempts = 3;

  // Feature flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableLogging = true;
  static const bool debugMode = false;

  // Database
  static const String databaseName = 'app.db';
  static const int databaseVersion = 1;

  /// Initialize app configuration
  /// Call this in main() before runApp()
  static Future<void> initialize() async {
    // Load environment variables
    // Load configuration from secure storage
    // Initialize shared preferences
    // Any other async initialization
  }

  /// Get API base URL (can be overridden for different environments)
  static String getApiUrl(String endpoint) {
    return '$apiBaseUrl$endpoint';
  }

  /// Check if app is in debug mode
  static bool isDebugMode() => debugMode;

  /// Get app identifier for analytics and crash reporting
  static String getAppIdentifier() => '$appName v$appVersion+$buildNumber';
}
