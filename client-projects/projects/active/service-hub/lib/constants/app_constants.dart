/// Application-wide constants
/// Centralized constants for easy maintenance and consistency

class AppConstants {
  // ==================== App Info ====================
  static const String appName = 'Flutter App';
  static const String appVersion = '0.1.0';
  static const String buildNumber = '1';

  // ==================== API Configuration ====================
  static const String apiBaseUrl = 'https://api.example.com/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int apiRetryCount = 3;
  static const Duration apiRetryDelay = Duration(seconds: 2);

  // ==================== Database ====================
  static const String databaseName = 'app.db';
  static const int databaseVersion = 1;

  // ==================== Storage Keys ====================
  static const String storageKeyUserToken = 'user_token';
  static const String storageKeyUserData = 'user_data';
  static const String storageKeyThemeMode = 'theme_mode';
  static const String storageKeyLanguage = 'language';
  static const String storageKeyFirstLaunch = 'first_launch';

  // ==================== Pagination ====================
  static const int defaultPageSize = 20;
  static const int defaultInitialPage = 1;

  // ==================== Durations ====================
  static const Duration debounceDelay = Duration(milliseconds: 500);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration dialogAnimationDuration = Duration(milliseconds: 300);
  static const Duration loadingTimeout = Duration(seconds: 60);

  // ==================== Cache Configuration ====================
  static const Duration apiCacheDuration = Duration(hours: 1);
  static const Duration imageCacheDuration = Duration(days: 7);

  // ==================== Logging ====================
  static const bool enableLogging = true;
  static const bool enableNetworkLogging = true;
  static const bool enableErrorLogging = true;

  // ==================== Feature Flags ====================
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableOfflineMode = true;

  // ==================== Sizes & Dimensions ====================
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;

  // ==================== Regular Expressions ====================
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[\d\s\-()]+$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  static const String urlRegex = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&/=]*)$';

  // ==================== Empty/Default Values ====================
  static const String emptyString = '';
  static const int zeroInt = 0;
  static const double zeroDouble = 0.0;
}
