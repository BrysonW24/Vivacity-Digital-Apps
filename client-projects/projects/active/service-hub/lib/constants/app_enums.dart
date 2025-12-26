/// Application-wide enums
/// Strongly-typed constants for consistent state management

/// API Response Status
enum ApiStatus {
  initial,
  loading,
  success,
  error,
  networkError,
  timeoutError,
}

/// Authentication State
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  authenticating,
  refreshing,
}

/// User Role
enum UserRole {
  admin,
  moderator,
  user,
  guest,
}

/// Network Connectivity Status
enum NetworkStatus {
  online,
  offline,
  unknown,
}

/// Sort Order
enum SortOrder {
  ascending,
  descending,
}

/// Date Range Filter
enum DateRangeFilter {
  today,
  thisWeek,
  thisMonth,
  thisYear,
  custom,
}

/// Language
enum AppLanguage {
  english,
  spanish,
  french,
  german,
  portuguese,
}

/// Theme Mode
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Error Severity
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// Cache Strategy
enum CacheStrategy {
  /// Only use network, never cache
  networkOnly,

  /// Only use cache, never network
  cacheOnly,

  /// Try network first, fall back to cache
  networkFirst,

  /// Try cache first, fall back to network
  cacheFirst,

  /// Always fetch from network and update cache
  refresh,
}

/// Request Priority
enum RequestPriority {
  low,
  normal,
  high,
  critical,
}

extension ApiStatusExtension on ApiStatus {
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isError => this == ApiStatus.error || this == ApiStatus.networkError || this == ApiStatus.timeoutError;
  bool get isNetworkError => this == ApiStatus.networkError;
  bool get isTimeoutError => this == ApiStatus.timeoutError;
}

extension AuthStatusExtension on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isLoading => this == AuthStatus.authenticating || this == AuthStatus.refreshing;
}

extension NetworkStatusExtension on NetworkStatus {
  bool get isOnline => this == NetworkStatus.online;
  bool get isOffline => this == NetworkStatus.offline;
}

extension AppThemeModeExtension on AppThemeMode {
  String get label {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
}

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.spanish:
        return 'es';
      case AppLanguage.french:
        return 'fr';
      case AppLanguage.german:
        return 'de';
      case AppLanguage.portuguese:
        return 'pt';
    }
  }

  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.spanish:
        return 'Español';
      case AppLanguage.french:
        return 'Français';
      case AppLanguage.german:
        return 'Deutsch';
      case AppLanguage.portuguese:
        return 'Português';
    }
  }
}
