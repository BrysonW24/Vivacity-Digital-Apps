/// Application Environment Enum
///
/// Defines different deployment environments for the application.
enum AppEnvironment {
  development,
  staging,
  production,
}

extension AppEnvironmentExtension on AppEnvironment {
  /// Check if app is in development mode
  bool get isDevelopment => this == AppEnvironment.development;

  /// Check if app is in staging mode
  bool get isStaging => this == AppEnvironment.staging;

  /// Check if app is in production mode
  bool get isProduction => this == AppEnvironment.production;

  /// Get environment display name
  String get displayName {
    switch (this) {
      case AppEnvironment.development:
        return 'Development';
      case AppEnvironment.staging:
        return 'Staging';
      case AppEnvironment.production:
        return 'Production';
    }
  }

  /// Get API base URL for environment
  String get apiBaseUrl {
    switch (this) {
      case AppEnvironment.development:
        return 'https://dev-api.example.com';
      case AppEnvironment.staging:
        return 'https://staging-api.example.com';
      case AppEnvironment.production:
        return 'https://api.example.com';
    }
  }

  /// Check if debug features are enabled
  bool get enableDebug => !isProduction;

  /// Check if API logging is enabled
  bool get enableApiLogging => !isProduction;

  /// Check if crash reporting is enabled
  bool get enableCrashReporting => isProduction;

  /// Check if analytics are enabled
  bool get enableAnalytics => true;
}
