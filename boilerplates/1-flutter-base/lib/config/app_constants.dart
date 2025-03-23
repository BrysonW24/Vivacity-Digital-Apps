/// This file contains global static constants used across the app.
///
/// These constants are not specific to UI layout (which are defined in `core/constants.dart`)
/// but rather high-level application-wide values such as app name, durations,
/// default locales, etc.
///
/// Use these constants when you want to access fixed values across features.

class AppConstants {
  // The official name of the app used in titles, metadata, etc.
  static const String appName = "Flutter Base App";

  // A standard duration used across animations or timed actions.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Default horizontal/vertical padding applied to containers and widgets.
  static const double defaultPadding = 16.0;

  // The default language/locale of the app
  static const String defaultLocale = 'en';
}
