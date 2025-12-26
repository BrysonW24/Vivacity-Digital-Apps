# Phase 1: Quick Start Implementation Guide
**Date:** November 30, 2025
**Scope:** Foundation files to get production app running
**Timeline:** 10-14 days estimated
**Files to Create:** 15 files

---

## Overview

Phase 1 focuses on creating the minimal set of files needed for a functional production app with authentication, API integration, and basic screens. All files follow existing patterns in the boilerplate.

---

## 📋 Phase 1 Checklist (15 Files)

### Config Layer (6 files) - Days 1-2
- [ ] `lib/config/routes.dart` - Named routes & route generator
- [ ] `lib/config/app_strings.dart` - All UI text & i18n keys
- [ ] `lib/config/app_colors.dart` - Color palette
- [ ] `lib/config/app_sizes.dart` - Spacing constants
- [ ] `lib/config/api_endpoints.dart` - API route strings
- [ ] `lib/config/storage_keys.dart` - LocalStorage keys

### Models (4 files) - Days 2-3
- [ ] `lib/models/api_response_model.dart` - Generic API wrapper
- [ ] `lib/models/auth_response_model.dart` - Login/signup response
- [ ] `lib/models/notification_model.dart` - Notification data
- [ ] `lib/models/app_settings_model.dart` - User preferences

### Exception Handling (3 files) - Days 3-4
- [ ] `lib/exceptions/app_exception.dart` - Base exception
- [ ] `lib/exceptions/auth_exception.dart` - Auth errors
- [ ] `lib/exceptions/network_exception.dart` - Network errors

### Core Services (2 files) - Days 4-5
- [ ] `lib/services/auth_service.dart` - Token management
- [ ] `lib/repositories/auth_repository.dart` - Auth API calls

### State Management (1 file) - Day 5
- [ ] `lib/providers/auth_provider.dart` - Login/logout state

### Root Configuration (3 files) - Days 5-6
- [ ] `.env.development` - Dev configuration
- [ ] `.env.staging` - Staging configuration
- [ ] `.env.production` - Prod configuration

---

## 📝 File-by-File Implementation

### 1. `lib/config/routes.dart` (40-50 lines)

```dart
/// Route definitions and route generator
/// Centralizes all navigation paths and enables type-safe navigation

class Routes {
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';

  // Utility routes
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String error = '/error';
  static const String noInternet = '/no-internet';
}

class RouteGenerator {
  // Generates routes dynamically
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
```

**Pattern:** Static string constants + route generator function

---

### 2. `lib/config/app_strings.dart` (100+ lines)

```dart
/// All UI strings and i18n keys
/// Centralized text management for easy translation

class AppStrings {
  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';

  // Auth
  static const String welcome = 'Welcome';
  static const String login = 'Log In';
  static const String signup = 'Sign Up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';

  // Validation
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 8 characters';

  // Errors
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again.';
  static const String unknownError = 'An unknown error occurred.';
}
```

**Pattern:** Static string constants organized by feature

---

### 3. `lib/config/app_colors.dart` (50-60 lines)

```dart
/// Centralized color palette
/// Supports light and dark themes

class AppColors {
  // Primary
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);

  // Secondary
  static const Color secondary = Color(0xFFFF6B6B);

  // Backgrounds
  static const Color bgLight = Color(0xFFFAFAFA);
  static const Color bgDark = Color(0xFF121212);

  // Text
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFF999999);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Utility
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);
}
```

**Pattern:** Organized color groups for easy theme switching

---

### 4. `lib/config/app_sizes.dart` (40-50 lines)

```dart
/// Spacing and sizing constants
/// Provides consistent spacing throughout the app

class AppSizes {
  // Padding
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Margins
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusCircle = 50.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // Button Heights
  static const double buttonHeight = 48.0;
  static const double buttonSmallHeight = 40.0;
}
```

**Pattern:** Organized by purpose with clear naming

---

### 5. `lib/config/api_endpoints.dart` (30-40 lines)

```dart
/// API endpoint constants
/// Centralized API route definitions

class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String getUserProfile = '/users/me';
  static const String updateProfile = '/users/me';
  static const String changePassword = '/users/me/password';

  // Notification endpoints
  static const String getNotifications = '/notifications';
  static const String markAsRead = '/notifications/:id/read';

  // Settings endpoints
  static const String getSettings = '/settings';
  static const String updateSettings = '/settings';
}
```

**Pattern:** Organized by resource type

---

### 6. `lib/config/storage_keys.dart` (25-30 lines)

```dart
/// SharedPreferences and local storage keys
/// Centralized key management for local storage

class StorageKeys {
  // Auth
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';

  // App State
  static const String isDarkMode = 'is_dark_mode';
  static const String appLanguage = 'app_language';
  static const String lastSyncTime = 'last_sync_time';

  // User Preferences
  static const String notificationsEnabled = 'notifications_enabled';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String firstTimeUser = 'first_time_user';
}
```

**Pattern:** Organized by feature

---

### 7. `lib/models/api_response_model.dart` (40-50 lines)

```dart
/// Generic API response wrapper
/// Used to wrap all API responses for consistent error handling

class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;
  final dynamic error;

  ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
    this.error,
  });

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      message: message ?? 'Success',
      success: true,
      statusCode: statusCode ?? 200,
    );
  }

  factory ApiResponse.error(dynamic error, {String? message, int? statusCode}) {
    return ApiResponse(
      message: message ?? 'Error',
      success: false,
      statusCode: statusCode ?? 500,
      error: error,
    );
  }

  bool get isSuccess => success && data != null;
  bool get isError => !success;
}
```

**Pattern:** Generic wrapper with factory constructors

---

### 8. `lib/models/auth_response_model.dart` (50-60 lines)

```dart
/// Authentication response model
/// Handles login/signup response from API

class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final User user;
  final DateTime expiresAt;

  AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
    required this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'],
      user: User.fromJson(json['user']),
      expiresAt: DateTime.parse(json['expiresAt'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  bool get isTokenExpired => DateTime.now().isAfter(expiresAt);
}
```

**Pattern:** JSON serialization with expiry tracking

---

### 9. `lib/models/notification_model.dart` (40-50 lines)

```dart
/// Notification model
/// Represents a single notification/message

class Notification {
  final String id;
  final String title;
  final String message;
  final String? imageUrl;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final Map<String, dynamic>? payload;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    this.imageUrl,
    required this.type,
    this.isRead = false,
    required this.createdAt,
    this.payload,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      imageUrl: json['imageUrl'],
      type: NotificationType.values
          .byName(json['type'] ?? 'general'),
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      payload: json['payload'],
    );
  }
}

enum NotificationType { general, alert, promotional, system }
```

**Pattern:** JSON serialization with enum handling

---

### 10. `lib/models/app_settings_model.dart` (40-50 lines)

```dart
/// User app settings/preferences model
/// Stores user-specific preferences

class AppSettings {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String appLanguage;
  final bool analyticsEnabled;
  final bool biometricEnabled;
  final DateTime? lastSyncTime;

  AppSettings({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.appLanguage = 'en',
    this.analyticsEnabled = true,
    this.biometricEnabled = false,
    this.lastSyncTime,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      darkModeEnabled: json['darkModeEnabled'] ?? false,
      appLanguage: json['appLanguage'] ?? 'en',
      analyticsEnabled: json['analyticsEnabled'] ?? true,
      biometricEnabled: json['biometricEnabled'] ?? false,
      lastSyncTime: json['lastSyncTime'] != null
          ? DateTime.parse(json['lastSyncTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'appLanguage': appLanguage,
      'analyticsEnabled': analyticsEnabled,
      'biometricEnabled': biometricEnabled,
      'lastSyncTime': lastSyncTime?.toIso8601String(),
    };
  }
}
```

**Pattern:** JSON serialization with sensible defaults

---

### 11. `lib/exceptions/app_exception.dart` (60-70 lines)

**See error_handler.dart** - Exception hierarchy already partially implemented. This file should extract/expand the base exception class:

```dart
/// Base exception class for all app exceptions
/// All exceptions extend this for consistent error handling

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => message;
}

class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class DatabaseException extends AppException {
  DatabaseException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}
```

---

### 12. `lib/exceptions/auth_exception.dart` (30-40 lines)

```dart
/// Authentication-specific exceptions
/// Used in auth flow for error handling

class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class UnauthorizedException extends AuthException {
  UnauthorizedException({String? message})
      : super(
        message: message ?? 'Unauthorized. Please log in again.',
        code: 'UNAUTHORIZED',
      );
}

class TokenExpiredException extends AuthException {
  TokenExpiredException({String? message})
      : super(
        message: message ?? 'Session expired. Please log in again.',
        code: 'TOKEN_EXPIRED',
      );
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException({String? message})
      : super(
        message: message ?? 'Invalid email or password.',
        code: 'INVALID_CREDENTIALS',
      );
}
```

---

### 13. `lib/exceptions/network_exception.dart` (40-50 lines)

**See error_handler.dart** - Partially implemented. Enhance:

```dart
/// Network and API-specific exceptions
/// Handles HTTP errors, timeouts, connectivity issues

class NetworkException extends AppException {
  final int? statusCode;

  NetworkException({
    required String message,
    this.statusCode,
    String? code,
  }) : super(message: message, code: code);
}

class TimeoutException extends NetworkException {
  TimeoutException({String? message})
      : super(
        message: message ?? 'Request timeout. Please try again.',
        code: 'TIMEOUT',
      );
}

class ServerException extends NetworkException {
  ServerException({
    required int statusCode,
    String? message,
  }) : super(
    message: message ?? 'Server error. Please try again later.',
    statusCode: statusCode,
    code: 'SERVER_ERROR',
  );
}

class NoInternetException extends NetworkException {
  NoInternetException({String? message})
      : super(
        message: message ?? 'No internet connection.',
        code: 'NO_INTERNET',
      );
}
```

---

### 14. `lib/services/auth_service.dart` (120-150 lines)

```dart
/// Authentication service
/// Handles token management, token refresh, session lifecycle

class AuthService {
  final LocalStorageService _storageService;
  final ApiClient _apiClient;
  final Logger _logger;

  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiryTime;

  AuthService({
    required LocalStorageService storageService,
    required ApiClient apiClient,
    required Logger logger,
  })  : _storageService = storageService,
        _apiClient = apiClient,
        _logger = logger;

  // Initialize from stored tokens
  Future<bool> initializeFromStorage() async {
    try {
      _accessToken = await _storageService.getString(StorageKeys.accessToken);
      _refreshToken = await _storageService.getString(StorageKeys.refreshToken);

      return _accessToken != null && !isTokenExpired;
    } catch (e) {
      _logger.e('Failed to initialize auth: $e');
      return false;
    }
  }

  // Check if token is expired
  bool get isTokenExpired {
    if (_tokenExpiryTime == null) return true;
    return DateTime.now().isAfter(_tokenExpiryTime!);
  }

  // Get current access token
  String? get accessToken => _accessToken;

  // Refresh token if expired
  Future<bool> refreshTokenIfExpired() async {
    if (!isTokenExpired) return true;

    if (_refreshToken == null) {
      await logout();
      return false;
    }

    return _refreshToken;
  }

  // Save tokens
  Future<void> saveTokens(AuthResponse response) async {
    _accessToken = response.accessToken;
    _refreshToken = response.refreshToken;
    _tokenExpiryTime = response.expiresAt;

    await _storageService.setString(
      StorageKeys.accessToken,
      response.accessToken,
    );

    if (response.refreshToken != null) {
      await _storageService.setString(
        StorageKeys.refreshToken,
        response.refreshToken!,
      );
    }
  }

  // Logout
  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _tokenExpiryTime = null;

    await _storageService.remove(StorageKeys.accessToken);
    await _storageService.remove(StorageKeys.refreshToken);
  }

  // Check if user is authenticated
  bool get isAuthenticated => _accessToken != null && !isTokenExpired;
}
```

**Pattern:** Service layer with token lifecycle management

---

### 15. `lib/repositories/auth_repository.dart` (100-120 lines)

```dart
/// Authentication repository
/// Handles authentication API calls and business logic

class AuthRepository extends BaseRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final LocalStorageService _storageService;

  AuthRepository({
    required ApiClient apiClient,
    required AuthService authService,
    required LocalStorageService storageService,
  })  : _apiClient = apiClient,
        _authService = authService,
        _storageService = storageService;

  // Login
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponse.fromJson(response);
      await _authService.saveTokens(authResponse);

      return Result.success(authResponse);
    } on DioException catch (e) {
      return Result.failure(ApiException.fromDioException(e));
    }
  }

  // Sign up
  Future<Result<AuthResponse>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.signup,
        data: {'email': email, 'password': password, 'name': name},
      );

      final authResponse = AuthResponse.fromJson(response);
      await _authService.saveTokens(authResponse);

      return Result.success(authResponse);
    } on DioException catch (e) {
      return Result.failure(ApiException.fromDioException(e));
    }
  }

  // Logout
  Future<Result<void>> logout() async {
    try {
      await _apiClient.post(ApiEndpoints.logout);
      await _authService.logout();
      return Result.success(null);
    } on DioException catch (e) {
      // Even if API call fails, clear local auth
      await _authService.logout();
      return Result.failure(ApiException.fromDioException(e));
    }
  }

  // Forgot password
  Future<Result<void>> forgotPassword({
    required String email,
  }) async {
    try {
      await _apiClient.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(ApiException.fromDioException(e));
    }
  }
}
```

**Pattern:** Repository with Result wrapper for functional error handling

---

### 16. `lib/providers/auth_provider.dart` (150-180 lines)

```dart
/// Authentication provider
/// Manages auth state: login, logout, user data, tokens

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthService _authService;

  // State
  AuthStatus _authStatus = AuthStatus.initial;
  User? _currentUser;
  String? _errorMessage;
  bool _isLoading = false;

  AuthProvider({
    required AuthRepository authRepository,
    required AuthService authService,
  })  : _authRepository = authRepository,
        _authService = authService;

  // Getters
  AuthStatus get authStatus => _authStatus;
  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;
  bool get isLoggedOut => _authStatus == AuthStatus.loggedOut;

  // Initialize auth state from storage
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isInitialized = await _authService.initializeFromStorage();

      if (isInitialized) {
        _authStatus = AuthStatus.authenticated;
        // TODO: Load user data from API or storage
      } else {
        _authStatus = AuthStatus.loggedOut;
      }
    } catch (e) {
      _authStatus = AuthStatus.error;
      _errorMessage = 'Initialization failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepository.login(
        email: email,
        password: password,
      );

      result.when(
        onSuccess: (authResponse) {
          _currentUser = authResponse.user;
          _authStatus = AuthStatus.authenticated;
          _errorMessage = null;
        },
        onFailure: (error) {
          _authStatus = AuthStatus.error;
          _errorMessage = error.message;
        },
      );
    } catch (e) {
      _authStatus = AuthStatus.error;
      _errorMessage = 'Login failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign up
  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepository.signup(
        email: email,
        password: password,
        name: name,
      );

      result.when(
        onSuccess: (authResponse) {
          _currentUser = authResponse.user;
          _authStatus = AuthStatus.authenticated;
        },
        onFailure: (error) {
          _authStatus = AuthStatus.error;
          _errorMessage = error.message;
        },
      );
    } catch (e) {
      _authStatus = AuthStatus.error;
      _errorMessage = 'Sign up failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.logout();
      _currentUser = null;
      _authStatus = AuthStatus.loggedOut;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Logout failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

**Pattern:** ChangeNotifier with status enum and error handling

---

## 🔧 Environment Configuration Files

### `.env.development`
```
API_BASE_URL=http://localhost:3000/api
API_TIMEOUT=30
LOG_LEVEL=debug
ENABLE_ANALYTICS=false
FIREBASE_PROJECT_ID=your-project-dev
```

### `.env.staging`
```
API_BASE_URL=https://api-staging.example.com/v1
API_TIMEOUT=30
LOG_LEVEL=info
ENABLE_ANALYTICS=true
FIREBASE_PROJECT_ID=your-project-staging
```

### `.env.production`
```
API_BASE_URL=https://api.example.com/v1
API_TIMEOUT=30
LOG_LEVEL=warn
ENABLE_ANALYTICS=true
FIREBASE_PROJECT_ID=your-project-prod
```

---

## 🚀 Implementation Steps

### Day 1-2: Config Files
1. Create all 6 config files in `lib/config/`
2. Ensure all strings, colors, sizes, endpoints are properly defined
3. Test by importing configs in existing screens

### Day 2-3: Models
1. Create all 4 model files in `lib/models/`
2. Implement JSON serialization for each
3. Create factory constructors

### Day 3-4: Exceptions
1. Create base exception and auth-specific exceptions
2. Enhance network exceptions from existing error_handler.dart
3. Create helper functions for common error patterns

### Day 4-5: Services & Repositories
1. Implement AuthService with token lifecycle management
2. Implement AuthRepository with API calls
3. Wire together with existing ApiClient

### Day 5-6: State Management
1. Implement AuthProvider with login/logout/signup
2. Add to main.dart with MultiProvider
3. Test with simple login screen

### Days 6-7: Environment Setup
1. Create .env files for dev/staging/prod
2. Add flutter_dotenv dependency to pubspec.yaml
3. Load environment variables in app_config.dart

---

## ✅ Validation Checklist

Before moving to Phase 2, verify:

- [ ] All config files created and import correctly
- [ ] All models serialize/deserialize JSON properly
- [ ] Exception hierarchy covers auth, network, validation
- [ ] AuthService manages tokens correctly
- [ ] AuthRepository handles API calls with Result wrapper
- [ ] AuthProvider integrates with UI (Provider Consumer pattern)
- [ ] Login/signup flow works end-to-end
- [ ] Environment variables load correctly
- [ ] Error messages display properly
- [ ] No compilation errors in entire project

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Models won't serialize | Ensure factory.fromJson & toJson methods match API response |
| Token not persisting | Verify StorageService saves to SharedPreferences |
| AuthProvider changes not reflecting | Wrap widgets with Consumer<AuthProvider> |
| API calls failing | Check ApiEndpoints match your backend routes |
| Environment variables not loading | Add flutter_dotenv to pubspec.yaml |

---

## Next: Phase 2 Files to Create

Once Phase 1 is complete, Phase 2 adds (8 files):
1. User repository & provider
2. Theme provider & repository
3. Connectivity service & provider
4. Settings repository
5. More API models

See `PRODUCTION_BOILERPLATE_ROADMAP_30112025.md` for details.

---

*Generated by Claude Code - Phase 1 Implementation Guide*
*Date: November 30, 2025*
