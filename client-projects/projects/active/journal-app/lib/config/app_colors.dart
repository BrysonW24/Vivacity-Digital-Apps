import 'package:flutter/material.dart';

/// App Colors Configuration
///
/// Centralized color constants for consistent design.
/// Supports light and dark themes.
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  // Secondary Colors
  static const Color secondary = Color(0xFFFFC107);
  static const Color secondaryLight = Color(0xFFFFD54F);
  static const Color secondaryDark = Color(0xFFFFA000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);

  // Text Colors - Light Theme
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFFBDBDBD);

  // Text Colors - Dark Theme
  static const Color darkTextPrimary = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);
  static const Color darkTextTertiary = Color(0xFF757575);

  // Background - Dark Theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // Shadow
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x3F000000);

  // Transparent
  static const Color transparent = Color(0x00000000);
  static const Color transparentBlack = Color(0x80000000);
  static const Color transparentWhite = Color(0x80FFFFFF);
}
