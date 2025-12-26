import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application-wide constants for spacing, sizing, animations, etc.
class AppConstants {
  AppConstants._();

  // ==================== SPACING ====================

  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;

  // ==================== BORDER RADIUS ====================

  // Modern Minimalist - Sharper corners
  static const double modernRadiusXs = 4.0;
  static const double modernRadiusSm = 8.0;
  static const double modernRadiusMd = 12.0;
  static const double modernRadiusLg = 16.0;
  static const double modernRadiusXl = 20.0;

  // Calming Zen - More rounded
  static const double zenRadiusXs = 8.0;
  static const double zenRadiusSm = 12.0;
  static const double zenRadiusMd = 16.0;
  static const double zenRadiusLg = 24.0;
  static const double zenRadiusXl = 32.0;

  // ==================== ELEVATION & SHADOWS ====================

  // Modern Minimalist - Crisp shadows
  static List<BoxShadow> modernShadowSm(bool isDark) => [
        BoxShadow(
          color: isDark
              ? AppColors.modernShadowDark
              : AppColors.modernShadowLight,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> modernShadowMd(bool isDark) => [
        BoxShadow(
          color: isDark
              ? AppColors.modernShadowDark
              : AppColors.modernShadowLight,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> modernShadowLg(bool isDark) => [
        BoxShadow(
          color: isDark
              ? AppColors.modernShadowDark
              : AppColors.modernShadowLight,
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  // Calming Zen - Softer, more diffused shadows
  static List<BoxShadow> zenShadowSm(bool isDark) => [
        BoxShadow(
          color:
              isDark ? AppColors.zenShadowDark : AppColors.zenShadowLight,
          blurRadius: 8,
          offset: const Offset(0, 2),
          spreadRadius: 1,
        ),
      ];

  static List<BoxShadow> zenShadowMd(bool isDark) => [
        BoxShadow(
          color:
              isDark ? AppColors.zenShadowDark : AppColors.zenShadowLight,
          blurRadius: 16,
          offset: const Offset(0, 4),
          spreadRadius: 2,
        ),
      ];

  static List<BoxShadow> zenShadowLg(bool isDark) => [
        BoxShadow(
          color:
              isDark ? AppColors.zenShadowDark : AppColors.zenShadowLight,
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: 3,
        ),
      ];

  // ==================== ANIMATION DURATIONS ====================

  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  // ==================== ANIMATION CURVES ====================

  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveEmphasized = Curves.easeOutCubic;
  static const Curve curveDecelerate = Curves.decelerate;
  static const Curve curveAccelerate = Curves.easeIn;
  static const Curve curveBounce = Curves.bounceOut;

  // ==================== ICON SIZES ====================

  static const double iconSizeXs = 16.0;
  static const double iconSizeSm = 20.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;

  // ==================== BUTTON HEIGHTS ====================

  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;

  // ==================== APP BAR ====================

  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;

  // ==================== CARD DIMENSIONS ====================

  static const double cardElevation = 2.0;
  static const double cardPadding = spaceMd;

  // ==================== OPACITY VALUES ====================

  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.6;
  static const double opacityHigh = 0.87;

  // ==================== BREAKPOINTS (for responsive design) ====================

  static const double breakpointMobile = 600;
  static const double breakpointTablet = 900;
  static const double breakpointDesktop = 1200;

  // ==================== JOURNAL SPECIFIC ====================

  static const int maxTitleLength = 100;
  static const int maxContentLength = 10000;
  static const int contentPreviewLength = 150;
  static const int wordsPerMinute = 200; // For reading time estimation

  // ==================== HELPER METHODS ====================

  /// Get border radius based on theme preset
  static BorderRadius getBorderRadius(
    String size,
    ThemePreset preset,
  ) {
    final isModern = preset == ThemePreset.modernMinimalist;

    switch (size) {
      case 'xs':
        return BorderRadius.circular(
          isModern ? modernRadiusXs : zenRadiusXs,
        );
      case 'sm':
        return BorderRadius.circular(
          isModern ? modernRadiusSm : zenRadiusSm,
        );
      case 'md':
        return BorderRadius.circular(
          isModern ? modernRadiusMd : zenRadiusMd,
        );
      case 'lg':
        return BorderRadius.circular(
          isModern ? modernRadiusLg : zenRadiusLg,
        );
      case 'xl':
        return BorderRadius.circular(
          isModern ? modernRadiusXl : zenRadiusXl,
        );
      default:
        return BorderRadius.circular(
          isModern ? modernRadiusMd : zenRadiusMd,
        );
    }
  }

  /// Get box shadow based on theme preset
  static List<BoxShadow> getShadow(
    String size,
    ThemePreset preset,
    bool isDark,
  ) {
    final isModern = preset == ThemePreset.modernMinimalist;

    switch (size) {
      case 'sm':
        return isModern ? modernShadowSm(isDark) : zenShadowSm(isDark);
      case 'md':
        return isModern ? modernShadowMd(isDark) : zenShadowMd(isDark);
      case 'lg':
        return isModern ? modernShadowLg(isDark) : zenShadowLg(isDark);
      default:
        return isModern ? modernShadowMd(isDark) : zenShadowMd(isDark);
    }
  }
}
