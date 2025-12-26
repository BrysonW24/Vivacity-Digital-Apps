/// Centralized color palette
/// Supports light and dark themes with Material Design 3 colors

import 'package:flutter/material.dart';

class AppColors {
  // ==================== Primary Colors ====================
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryVeryLight = Color(0xFFBBDEFB);

  // ==================== Secondary Colors ====================
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color secondaryDark = Color(0xFFE53935);
  static const Color secondaryLight = Color(0xFFEF9A9A);

  // ==================== Backgrounds ====================
  static const Color bgLight = Color(0xFFFAFAFA);
  static const Color bgDark = Color(0xFF121212);
  static const Color bgLightSurface = Color(0xFFFFFFFF);
  static const Color bgDarkSurface = Color(0xFF1E1E1E);

  // ==================== Text Colors ====================
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFF999999);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ==================== Status Colors ====================
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFC8E6C9);
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFE082);
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFFFCDD2);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFBBDEFB);

  // ==================== Borders & Dividers ====================
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFDDDDDD);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFF424242);

  // ==================== Utility Colors ====================
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color overlay = Color(0x4D000000); // 30% black
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ==================== Shimmer Colors ====================
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // ==================== Gradient Colors ====================
  static const List<Color> primaryGradient = [primary, primaryDark];
  static const List<Color> successGradient = [success, Color(0xFF388E3C)];
  static const List<Color> errorGradient = [error, Color(0xFFD32F2F)];
}
