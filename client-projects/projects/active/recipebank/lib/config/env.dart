/// Environment configuration loader
import 'package:flutter/foundation.dart';

/// Environment configuration class
class Env {
  Env._();

  /// Current environment mode
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// API base URL
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  /// API timeout in seconds
  static const int apiTimeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30,
  );

  /// Max retry attempts
  static const int maxRetryAttempts = int.fromEnvironment(
    'MAX_RETRY_ATTEMPTS',
    defaultValue: 3,
  );

  /// Enable logging
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  /// Enable analytics
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: false,
  );

  /// Check if production
  static bool get isProduction => environment == 'production';

  /// Check if development
  static bool get isDevelopment => environment == 'development';

  /// Check if staging
  static bool get isStaging => environment == 'staging';

  /// Check debug mode
  static bool get isDebugMode => kDebugMode || isDevelopment;
}
