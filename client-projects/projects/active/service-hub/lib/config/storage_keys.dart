/// SharedPreferences and local storage keys
/// Centralized key management for all local storage operations

class StorageKeys {
  // ==================== Authentication ====================
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiryTime = 'token_expiry_time';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userProfileImage = 'user_profile_image';

  // ==================== App State ====================
  static const String isDarkMode = 'is_dark_mode';
  static const String appLanguage = 'app_language';
  static const String lastSyncTime = 'last_sync_time';
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';

  // ==================== User Preferences ====================
  static const String notificationsEnabled = 'notifications_enabled';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String biometricEnabled = 'biometric_enabled';

  // ==================== Onboarding ====================
  static const String firstTimeUser = 'first_time_user';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String lastOnboardingVersion = 'last_onboarding_version';

  // ==================== Cache ====================
  static const String cachedUserProfile = 'cached_user_profile';
  static const String cachedNotifications = 'cached_notifications';
  static const String cachedSettings = 'cached_settings';
  static const String cacheTimestamp = 'cache_timestamp';

  // ==================== Device Info ====================
  static const String deviceId = 'device_id';
  static const String deviceName = 'device_name';
  static const String osVersion = 'os_version';

  // ==================== API Configuration ====================
  static const String apiBaseUrl = 'api_base_url';
  static const String apiTimeout = 'api_timeout';
  static const String environment = 'environment';
}
