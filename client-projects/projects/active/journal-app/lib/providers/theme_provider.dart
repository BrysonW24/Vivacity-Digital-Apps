import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';
import '../theme/app_theme.dart';

/// Provider class for managing app theme settings with preset support
class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _presetKey = 'theme_preset';

  ThemeMode _themeMode = ThemeMode.system;
  ThemePreset _themePreset = ThemePreset.modernMinimalist;
  bool _isInitialized = false;

  ThemeProvider() {
    _loadPreferences();
  }

  // Getters
  ThemeMode get themeMode => _themeMode;
  ThemePreset get themePreset => _themePreset;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  bool get isInitialized => _isInitialized;
  bool get isModernMinimalist => _themePreset == ThemePreset.modernMinimalist;
  bool get isCalmingZen => _themePreset == ThemePreset.calmingZen;

  /// Load theme preferences from shared preferences
  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load theme mode
      final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      _themeMode = ThemeMode.values[themeIndex];

      // Load theme preset
      final presetIndex = prefs.getInt(_presetKey) ?? ThemePreset.modernMinimalist.index;
      _themePreset = ThemePreset.values[presetIndex];
    } catch (e) {
      // Fall back to defaults if loading fails
      _themeMode = ThemeMode.system;
      _themePreset = ThemePreset.modernMinimalist;
    }

    _isInitialized = true;
    notifyListeners();
  }

  /// Save theme mode to shared preferences
  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, themeMode.index);
    } catch (e) {
      // Silently fail if saving fails
    }
  }

  /// Save theme preset to shared preferences
  Future<void> _saveThemePreset(ThemePreset preset) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_presetKey, preset.index);
    } catch (e) {
      // Silently fail if saving fails
    }
  }

  // ==================== THEME MODE METHODS ====================

  /// Set theme mode (light/dark/system)
  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;

    _themeMode = themeMode;
    notifyListeners();

    await _saveThemeMode(themeMode);
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newThemeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newThemeMode);
  }

  /// Set to light mode
  Future<void> setLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  /// Set to dark mode
  Future<void> setDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  /// Set to system mode
  Future<void> setSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }

  // ==================== THEME PRESET METHODS ====================

  /// Set theme preset (modernMinimalist/calmingZen)
  Future<void> setThemePreset(ThemePreset preset) async {
    if (_themePreset == preset) return;

    _themePreset = preset;
    notifyListeners();

    await _saveThemePreset(preset);
  }

  /// Toggle between theme presets
  Future<void> togglePreset() async {
    final newPreset = isModernMinimalist
        ? ThemePreset.calmingZen
        : ThemePreset.modernMinimalist;
    await setThemePreset(newPreset);
  }

  /// Set to Modern Minimalist preset
  Future<void> setModernMinimalist() async {
    await setThemePreset(ThemePreset.modernMinimalist);
  }

  /// Set to Calming Zen preset
  Future<void> setCalmingZen() async {
    await setThemePreset(ThemePreset.calmingZen);
  }

  // ==================== THEME DATA GETTERS ====================

  /// Get light theme based on current preset
  ThemeData getLightTheme() {
    return AppTheme.getLightTheme(_themePreset);
  }

  /// Get dark theme based on current preset
  ThemeData getDarkTheme() {
    return AppTheme.getDarkTheme(_themePreset);
  }

  /// Get the current theme data based on mode and preset
  ThemeData getCurrentTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return getLightTheme();
      case ThemeMode.dark:
        return getDarkTheme();
      case ThemeMode.system:
      default:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? getDarkTheme() : getLightTheme();
    }
  }

  /// Check if current theme is dark (useful for widgets)
  bool isDark(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
      default:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  // ==================== PRESET DISPLAY NAMES ====================

  /// Get display name for current preset
  String get presetDisplayName {
    switch (_themePreset) {
      case ThemePreset.modernMinimalist:
        return 'Modern Minimalist';
      case ThemePreset.calmingZen:
        return 'Calming Zen';
    }
  }

  /// Get display name for a specific preset
  static String getPresetName(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.modernMinimalist:
        return 'Modern Minimalist';
      case ThemePreset.calmingZen:
        return 'Calming Zen';
    }
  }

  /// Get description for a specific preset
  static String getPresetDescription(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.modernMinimalist:
        return 'Clean, crisp, and professional design with sharp lines and high contrast';
      case ThemePreset.calmingZen:
        return 'Soft, peaceful, and therapeutic design with gentle colors and rounded edges';
    }
  }
}
