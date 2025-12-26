import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography styles for the journal app with support for theme presets
class AppTextStyles {
  AppTextStyles._();

  // Using system default fonts (Inter font file was empty)
  static const String? fontFamily = null;

  // ==================== MODERN MINIMALIST STYLES ====================

  // Modern - Display (Largest text)
  static const modernDisplayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const modernDisplayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    height: 1.2,
  );

  static const modernDisplaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
  );

  // Modern - Headlines
  static const modernHeadlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  static const modernHeadlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  static const modernHeadlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  // Modern - Titles
  static const modernTitleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static const modernTitleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const modernTitleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Modern - Body
  static const modernBodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const modernBodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static const modernBodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.5,
  );

  // Modern - Labels
  static const modernLabelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const modernLabelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const modernLabelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ==================== CALMING ZEN STYLES ====================

  // Zen - Display (Softer, more rounded feeling)
  static const zenDisplayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600, // Slightly lighter than bold
    letterSpacing: 0,
    height: 1.3,
  );

  static const zenDisplayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  static const zenDisplaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  // Zen - Headlines
  static const zenHeadlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const zenHeadlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const zenHeadlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.5,
  );

  // Zen - Titles
  static const zenTitleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const zenTitleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const zenTitleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Zen - Body (More spacious for readability)
  static const zenBodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.6,
  );

  static const zenBodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.6,
  );

  static const zenBodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.6,
  );

  // Zen - Labels
  static const zenLabelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const zenLabelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const zenLabelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  // ==================== HELPER METHOD ====================

  /// Get text theme based on preset
  static TextTheme getTextTheme(ThemePreset preset, bool isDark) {
    final isModern = preset == ThemePreset.modernMinimalist;

    return TextTheme(
      displayLarge: isModern ? modernDisplayLarge : zenDisplayLarge,
      displayMedium: isModern ? modernDisplayMedium : zenDisplayMedium,
      displaySmall: isModern ? modernDisplaySmall : zenDisplaySmall,
      headlineLarge: isModern ? modernHeadlineLarge : zenHeadlineLarge,
      headlineMedium: isModern ? modernHeadlineMedium : zenHeadlineMedium,
      headlineSmall: isModern ? modernHeadlineSmall : zenHeadlineSmall,
      titleLarge: isModern ? modernTitleLarge : zenTitleLarge,
      titleMedium: isModern ? modernTitleMedium : zenTitleMedium,
      titleSmall: isModern ? modernTitleSmall : zenTitleSmall,
      bodyLarge: isModern ? modernBodyLarge : zenBodyLarge,
      bodyMedium: isModern ? modernBodyMedium : zenBodyMedium,
      bodySmall: isModern ? modernBodySmall : zenBodySmall,
      labelLarge: isModern ? modernLabelLarge : zenLabelLarge,
      labelMedium: isModern ? modernLabelMedium : zenLabelMedium,
      labelSmall: isModern ? modernLabelSmall : zenLabelSmall,
    );
  }
}
