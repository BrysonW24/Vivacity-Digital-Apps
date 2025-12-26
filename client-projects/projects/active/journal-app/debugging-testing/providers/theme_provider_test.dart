import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:journal_app/constants/app_colors.dart';

void main() {
  late ThemeProvider provider;

  setUp(() {
    provider = ThemeProvider();
  });

  group('ThemeProvider', () {
    test('initial theme is system default', () async {
      // Wait for initialization to complete
      await Future.delayed(const Duration(milliseconds: 10));
      expect(provider.themeMode, ThemeMode.system);
      expect(provider.isDarkMode, false);
      expect(provider.isSystemMode, true);
    });

    test('setThemeMode changes theme mode', () async {
      await provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);
      expect(provider.isDarkMode, true);
      expect(provider.isSystemMode, false);

      await provider.setThemeMode(ThemeMode.light);
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.isDarkMode, false);
      expect(provider.isSystemMode, false);
    });

    test('toggleTheme switches between light and dark', () async {
      // Start with system (default)
      expect(provider.themeMode, ThemeMode.system);

      // Toggle to dark
      await provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.dark);
      expect(provider.isDarkMode, true);

      // Toggle back to light
      await provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.isDarkMode, false);
    });

    test('setDarkMode and setLightMode work correctly', () async {
      await provider.setDarkMode();
      expect(provider.themeMode, ThemeMode.dark);
      expect(provider.isDarkMode, true);

      await provider.setLightMode();
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.isDarkMode, false);
    });

    test('getLightTheme returns light theme data', () async {
      final lightTheme = provider.getLightTheme();
      expect(lightTheme.brightness, Brightness.light);
    });

    test('getDarkTheme returns dark theme data', () async {
      final darkTheme = provider.getDarkTheme();
      expect(darkTheme.brightness, Brightness.dark);
    });

    test('setThemePreset changes preset', () async {
      await provider.setThemePreset(ThemePreset.calmingZen);
      expect(provider.themePreset, ThemePreset.calmingZen);
      expect(provider.isCalmingZen, true);
      expect(provider.isModernMinimalist, false);
    });

    test('togglePreset switches between presets', () async {
      expect(provider.isModernMinimalist, true);

      await provider.togglePreset();
      expect(provider.isCalmingZen, true);

      await provider.togglePreset();
      expect(provider.isModernMinimalist, true);
    });

    test('presetDisplayName returns correct name', () async {
      expect(provider.presetDisplayName, 'Modern Minimalist');

      await provider.setThemePreset(ThemePreset.calmingZen);
      expect(provider.presetDisplayName, 'Calming Zen');
    });

    test('static preset methods work', () {
      expect(ThemeProvider.getPresetName(ThemePreset.modernMinimalist), 'Modern Minimalist');
      expect(ThemeProvider.getPresetName(ThemePreset.calmingZen), 'Calming Zen');

      expect(ThemeProvider.getPresetDescription(ThemePreset.modernMinimalist).isNotEmpty, true);
      expect(ThemeProvider.getPresetDescription(ThemePreset.calmingZen).isNotEmpty, true);
    });
  });
}