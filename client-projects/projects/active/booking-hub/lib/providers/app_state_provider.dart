import 'package:flutter/material.dart';

/// Global app state provider
/// Manages theme, user preferences, and app-wide state
class AppStateProvider extends ChangeNotifier {
  // Theme state
  ThemeMode _themeMode = ThemeMode.system;

  // User data
  String? _userId;
  String? _userName;

  // App state
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  ThemeMode get themeMode => _themeMode;
  String? get userId => _userId;
  String? get userName => _userName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isAuthenticated => _userId != null;

  /// Set theme mode
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  /// Toggle theme between light and dark
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  /// Set user data after authentication
  void setUserData(String userId, String userName) {
    _userId = userId;
    _userName = userName;
    notifyListeners();
  }

  /// Clear user data on logout
  void logout() {
    _userId = null;
    _userName = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set loading state
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Set error message
  void setError(String? error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    setError(null);
  }

  /// Reset app state (useful for logout or app reset)
  void reset() {
    _themeMode = ThemeMode.system;
    _userId = null;
    _userName = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}
