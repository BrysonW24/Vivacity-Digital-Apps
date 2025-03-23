import 'package:flutter/material.dart';

/// UIConstants holds layout-related constants that are shared across the app.
///
/// These constants help standardize spacing, padding, radius, icon sizes,
/// and other dimension values to ensure a consistent visual structure.
class UIConstants {
  // Standard padding used throughout the app (e.g. in screens, cards, buttons)
  static const double padding = 16.0;

  // Standard border radius for cards, buttons, containers, etc.
  static const double radius = 12.0;

  // Standard icon size used for general icons in the app
  static const double iconSize = 24.0;

  // Standard page padding for screen-level containers
  static const EdgeInsets pagePadding = EdgeInsets.all(padding);

  // Padding for inner content blocks or sections
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(horizontal: padding);
}
