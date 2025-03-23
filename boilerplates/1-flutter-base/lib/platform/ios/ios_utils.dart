/// Utility methods specifically for iOS platform.
///
/// This file helps isolate any iOS-specific logic such as permission handling,
/// Apple Sign-In checks, or platform limitations.
///
/// Keep this minimal in base tier. Use in combination with Platform checks.

import 'dart:io';

class IOSUtils {
  /// Checks if the current platform is iOS.
  static bool isIOS() => Platform.isIOS;

  /// Example method stub for iOS-specific behavior.
  static void logIOSMessage(String message) {
    if (isIOS()) {
      print("[iOS] $message");
    }
  }

  // Add iOS-specific integrations or permission logic here as needed.
}
