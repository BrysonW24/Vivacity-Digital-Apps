import 'package:flutter/foundation.dart';
import '../enums/auth_status.dart';
import '../models/user_model.dart';

/// Auth Provider
///
/// Manages authentication state and user sessions.
/// Handles login, signup, logout, and token management.
class AuthProvider extends ChangeNotifier {
  AuthStatus _authStatus = AuthStatus.initial;
  UserModel? _user;
  String? _token;
  String? _refreshToken;
  String? _errorMessage;

  // Getters
  AuthStatus get authStatus => _authStatus;
  UserModel? get user => _user;
  String? get token => _token;
  String? get refreshToken => _refreshToken;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;
  bool get isLoading => _authStatus == AuthStatus.loading;
  bool get needsEmailVerification =>
      _authStatus == AuthStatus.emailVerificationRequired;
  bool get isSessionExpired => _authStatus == AuthStatus.sessionExpired;

  /// Initialize auth state from storage
  Future<void> initialize() async {
    _setAuthStatus(AuthStatus.initial);
    try {
      // TODO: Load token and user from secure storage
      // If token exists and is valid, set as authenticated
      // Otherwise, set as unauthenticated
      _setAuthStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setAuthStatus(AuthStatus.unauthenticated);
    }
  }

  /// Login user
  Future<void> login({
    required String email,
    required String password,
  }) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to login
      // Receive token and user data
      // Store token in secure storage
      // Update user state

      // Example:
      // final response = await authService.login(email, password);
      // _token = response.token;
      // _refreshToken = response.refreshToken;
      // _user = response.user;
      // await secureStorageService.saveToken(_token!);

      _setAuthStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError('Login failed: ${e.toString()}');
      _setAuthStatus(AuthStatus.unauthenticated);
    }
  }

  /// Signup user
  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to signup
      // Receive token and user data
      // Store token in secure storage

      _setAuthStatus(AuthStatus.emailVerificationRequired);
    } catch (e) {
      _setError('Signup failed: ${e.toString()}');
      _setAuthStatus(AuthStatus.unauthenticated);
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      // TODO: Call auth service to logout
      // Clear tokens from secure storage
      // Notify server if needed

      _clearAuth();
      _setAuthStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError('Logout failed: ${e.toString()}');
    }
  }

  /// Verify email
  Future<void> verifyEmail(String code) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to verify email
      // Update user verified status

      _setAuthStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError('Email verification failed: ${e.toString()}');
      _setAuthStatus(AuthStatus.emailVerificationRequired);
    }
  }

  /// Request password reset
  Future<void> requestPasswordReset(String email) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to request password reset
      // Send reset email to user

      _setAuthStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError('Password reset request failed: ${e.toString()}');
    }
  }

  /// Reset password
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to reset password
      // Update password on server

      _setAuthStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError('Password reset failed: ${e.toString()}');
    }
  }

  /// Refresh token
  Future<void> refreshToken() async {
    if (_refreshToken == null) {
      _setAuthStatus(AuthStatus.unauthenticated);
      return;
    }

    try {
      // TODO: Call auth service to refresh token
      // Update token in secure storage

      _setAuthStatus(AuthStatus.authenticated);
    } catch (e) {
      _setAuthStatus(AuthStatus.sessionExpired);
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to change password

      _setAuthStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError('Password change failed: ${e.toString()}');
    }
  }

  /// Delete account
  Future<void> deleteAccount({required String password}) async {
    _setAuthStatus(AuthStatus.loading);
    _clearError();

    try {
      // TODO: Call auth service to delete account
      // Clear user data and tokens

      _clearAuth();
      _setAuthStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError('Account deletion failed: ${e.toString()}');
    }
  }

  // Private helpers
  void _setAuthStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void _clearAuth() {
    _user = null;
    _token = null;
    _refreshToken = null;
    _errorMessage = null;
  }
}
