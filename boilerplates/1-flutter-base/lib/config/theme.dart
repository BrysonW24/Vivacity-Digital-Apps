import 'package:flutter/material.dart';

/// This file defines the core color palette for the app.
///
/// These colors are used in `themes.dart` to build the light and dark ThemeData.
/// Keeping colors here allows you to maintain a single source of truth for branding.
///
/// Use `AppColors.primaryColor` and similar references in both your widgets and themes.

class AppColors {
  // Primary brand color used throughout the app (e.g. buttons, icons)
  static const primaryColor = Color(0xFF0066FF);

  // Secondary or accent color used for highlights and action elements
  static const secondaryColor = Color(0xFF00BFFF);

  // The background color for most screens
  static const backgroundColor = Color(0xFFF5F5F5);

  // Default text color for content on light backgrounds
  static const textColor = Color(0xFF333333);
}
