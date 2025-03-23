import 'package:flutter/material.dart';

/// AppProvider manages global app-level state that is unrelated
/// to business logic or user authentication.
///
/// This includes app-wide preferences such as:
/// - Current theme mode (light/dark)
/// - Locale
/// - Navigation or tab index
///
/// Extend this as needed for simple global values.

class AppProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Toggles the theme between light and dark.
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }

  /// Forcefully set the theme
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
