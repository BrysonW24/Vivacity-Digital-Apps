import 'dart:developer' as dev;

/// Simple wrapper around `dart:developer` to standardize debug logging.
///
/// This keeps logs clean and consistent, and can be extended later to include
/// different log levels or third-party integrations like Firebase Crashlytics.

class Logger {
  static void info(String message, {String tag = "INFO"}) {
    dev.log('[$tag] $message');
  }

  static void warning(String message, {String tag = "WARN"}) {
    dev.log('[$tag] ⚠️ $message');
  }

  static void error(String message, {String tag = "ERROR"}) {
    dev.log('[$tag] ❌ $message');
  }
}
