import 'package:flutter/material.dart';
import '../../config/theme.dart';

/// AppTheme defines the light and dark theme styles used in the app.
///
/// This includes primary colors, background colors, app bar themes,
/// and text styling to create a visually cohesive experience.
///
/// Themes are imported into `main.dart` and applied using MaterialApp's
/// `theme`, `darkTheme`, and `themeMode`.

class AppTheme {
  /// Light mode theme configuration
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      titleTextStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor),
      bodyMedium: TextStyle(color: AppColors.textColor),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
  );

  /// Dark mode theme configuration
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
