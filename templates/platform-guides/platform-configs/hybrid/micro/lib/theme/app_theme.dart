import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../constants/app_constants.dart';

/// Main theme configuration with support for theme presets
class AppTheme {
  AppTheme._();

  // ==================== PUBLIC THEME GETTERS ====================

  /// Get light theme for a specific preset
  static ThemeData getLightTheme(ThemePreset preset) {
    return preset == ThemePreset.modernMinimalist
        ? _modernMinimalistLight
        : _calmingZenLight;
  }

  /// Get dark theme for a specific preset
  static ThemeData getDarkTheme(ThemePreset preset) {
    return preset == ThemePreset.modernMinimalist
        ? _modernMinimalistDark
        : _calmingZenDark;
  }

  // Convenience getters (backwards compatible)
  static ThemeData get lightTheme => _modernMinimalistLight;
  static ThemeData get darkTheme => _modernMinimalistDark;

  // ==================== MODERN MINIMALIST THEMES ====================

  static final ThemeData _modernMinimalistLight = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTextStyles.fontFamily,

    colorScheme: const ColorScheme.light(
      primary: AppColors.modernMinimalistLightPrimary,
      secondary: AppColors.modernMinimalistLightSecondary,
      tertiary: AppColors.modernMinimalistLightAccent,
      surface: AppColors.modernMinimalistLightSurface,
      surfaceContainerHighest: AppColors.modernMinimalistLightSurfaceVariant,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.modernMinimalistLightOnSurface,
      onSurfaceVariant: AppColors.modernMinimalistLightOnSurfaceVariant,
      outline: AppColors.modernMinimalistLightOutline,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.modernMinimalistLightBackground,

    textTheme: AppTextStyles.getTextTheme(ThemePreset.modernMinimalist, false),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.modernMinimalistLightPrimary,
      foregroundColor: Colors.white,
      elevation: AppConstants.appBarElevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.modernHeadlineSmall.copyWith(
        color: Colors.white,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
      ),
      color: AppColors.modernMinimalistLightSurface,
      shadowColor: AppColors.modernShadowLight,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.modernMinimalistLightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: AppTextStyles.modernLabelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.modernMinimalistLightPrimary,
        textStyle: AppTextStyles.modernLabelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.modernMinimalistLightSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: BorderSide(color: AppColors.modernMinimalistLightOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: BorderSide(color: AppColors.modernMinimalistLightOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: const BorderSide(
          color: AppColors.modernMinimalistLightPrimary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: AppTextStyles.modernBodyMedium.copyWith(
        color: AppColors.modernMinimalistLightOnSurfaceVariant,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.modernMinimalistLightSurfaceVariant,
      selectedColor: AppColors.modernMinimalistLightPrimary.withOpacity(0.2),
      checkmarkColor: AppColors.modernMinimalistLightPrimary,
      labelStyle: AppTextStyles.modernLabelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('xl', ThemePreset.modernMinimalist),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.modernMinimalistLightPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
  );

  static final ThemeData _modernMinimalistDark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTextStyles.fontFamily,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.modernMinimalistDarkPrimary,
      secondary: AppColors.modernMinimalistDarkSecondary,
      tertiary: AppColors.modernMinimalistDarkAccent,
      surface: AppColors.modernMinimalistDarkSurface,
      surfaceContainerHighest: AppColors.modernMinimalistDarkSurfaceVariant,
      onPrimary: AppColors.modernMinimalistDarkBackground,
      onSecondary: AppColors.modernMinimalistDarkBackground,
      onSurface: AppColors.modernMinimalistDarkOnSurface,
      onSurfaceVariant: AppColors.modernMinimalistDarkOnSurfaceVariant,
      outline: AppColors.modernMinimalistDarkOutline,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.modernMinimalistDarkBackground,

    textTheme: AppTextStyles.getTextTheme(ThemePreset.modernMinimalist, true),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.modernMinimalistDarkSurface,
      foregroundColor: AppColors.modernMinimalistDarkOnSurface,
      elevation: AppConstants.appBarElevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.modernHeadlineSmall.copyWith(
        color: AppColors.modernMinimalistDarkOnSurface,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
      ),
      color: AppColors.modernMinimalistDarkSurface,
      shadowColor: AppColors.modernShadowDark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.modernMinimalistDarkPrimary,
        foregroundColor: AppColors.modernMinimalistDarkBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: AppTextStyles.modernLabelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.modernMinimalistDarkPrimary,
        textStyle: AppTextStyles.modernLabelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.modernMinimalistDarkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: BorderSide(color: AppColors.modernMinimalistDarkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: BorderSide(color: AppColors.modernMinimalistDarkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.modernMinimalist),
        borderSide: const BorderSide(
          color: AppColors.modernMinimalistDarkPrimary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: AppTextStyles.modernBodyMedium.copyWith(
        color: AppColors.modernMinimalistDarkOnSurfaceVariant,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.modernMinimalistDarkSurfaceVariant,
      selectedColor: AppColors.modernMinimalistDarkPrimary.withOpacity(0.3),
      checkmarkColor: AppColors.modernMinimalistDarkPrimary,
      labelStyle: AppTextStyles.modernLabelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('xl', ThemePreset.modernMinimalist),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.modernMinimalistDarkPrimary,
      foregroundColor: AppColors.modernMinimalistDarkBackground,
      elevation: 4,
    ),
  );

  // ==================== CALMING ZEN THEMES ====================

  static final ThemeData _calmingZenLight = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTextStyles.fontFamily,

    colorScheme: const ColorScheme.light(
      primary: AppColors.calmingZenLightPrimary,
      secondary: AppColors.calmingZenLightSecondary,
      tertiary: AppColors.calmingZenLightAccent,
      surface: AppColors.calmingZenLightSurface,
      surfaceContainerHighest: AppColors.calmingZenLightSurfaceVariant,
      onPrimary: Colors.white,
      onSecondary: AppColors.calmingZenLightOnSurface,
      onSurface: AppColors.calmingZenLightOnSurface,
      onSurfaceVariant: AppColors.calmingZenLightOnSurfaceVariant,
      outline: AppColors.calmingZenLightOutline,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.calmingZenLightBackground,

    textTheme: AppTextStyles.getTextTheme(ThemePreset.calmingZen, false),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.calmingZenLightPrimary,
      foregroundColor: Colors.white,
      elevation: AppConstants.appBarElevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.zenHeadlineSmall.copyWith(
        color: Colors.white,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
      ),
      color: AppColors.calmingZenLightSurface,
      shadowColor: AppColors.zenShadowLight,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.calmingZenLightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: AppTextStyles.zenLabelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.calmingZenLightPrimary,
        textStyle: AppTextStyles.zenLabelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.calmingZenLightSurface,
      border: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: BorderSide(color: AppColors.calmingZenLightOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: BorderSide(color: AppColors.calmingZenLightOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: const BorderSide(
          color: AppColors.calmingZenLightPrimary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      hintStyle: AppTextStyles.zenBodyMedium.copyWith(
        color: AppColors.calmingZenLightOnSurfaceVariant,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.calmingZenLightSurfaceVariant,
      selectedColor: AppColors.calmingZenLightPrimary.withOpacity(0.2),
      checkmarkColor: AppColors.calmingZenLightPrimary,
      labelStyle: AppTextStyles.zenLabelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('xl', ThemePreset.calmingZen),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.calmingZenLightSecondary,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: CircleBorder(),
    ),
  );

  static final ThemeData _calmingZenDark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTextStyles.fontFamily,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.calmingZenDarkPrimary,
      secondary: AppColors.calmingZenDarkSecondary,
      tertiary: AppColors.calmingZenDarkAccent,
      surface: AppColors.calmingZenDarkSurface,
      surfaceContainerHighest: AppColors.calmingZenDarkSurfaceVariant,
      onPrimary: AppColors.calmingZenDarkBackground,
      onSecondary: AppColors.calmingZenDarkBackground,
      onSurface: AppColors.calmingZenDarkOnSurface,
      onSurfaceVariant: AppColors.calmingZenDarkOnSurfaceVariant,
      outline: AppColors.calmingZenDarkOutline,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.calmingZenDarkBackground,

    textTheme: AppTextStyles.getTextTheme(ThemePreset.calmingZen, true),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.calmingZenDarkSurface,
      foregroundColor: AppColors.calmingZenDarkOnSurface,
      elevation: AppConstants.appBarElevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.zenHeadlineSmall.copyWith(
        color: AppColors.calmingZenDarkOnSurface,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
      ),
      color: AppColors.calmingZenDarkSurface,
      shadowColor: AppColors.zenShadowDark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.calmingZenDarkPrimary,
        foregroundColor: AppColors.calmingZenDarkBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: AppTextStyles.zenLabelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.calmingZenDarkPrimary,
        textStyle: AppTextStyles.zenLabelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.calmingZenDarkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: BorderSide(color: AppColors.calmingZenDarkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: BorderSide(color: AppColors.calmingZenDarkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppConstants.getBorderRadius('md', ThemePreset.calmingZen),
        borderSide: const BorderSide(
          color: AppColors.calmingZenDarkPrimary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      hintStyle: AppTextStyles.zenBodyMedium.copyWith(
        color: AppColors.calmingZenDarkOnSurfaceVariant,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.calmingZenDarkSurfaceVariant,
      selectedColor: AppColors.calmingZenDarkPrimary.withOpacity(0.3),
      checkmarkColor: AppColors.calmingZenDarkPrimary,
      labelStyle: AppTextStyles.zenLabelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('xl', ThemePreset.calmingZen),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.calmingZenDarkSecondary,
      foregroundColor: AppColors.calmingZenDarkBackground,
      elevation: 2,
      shape: CircleBorder(),
    ),
  );
}
