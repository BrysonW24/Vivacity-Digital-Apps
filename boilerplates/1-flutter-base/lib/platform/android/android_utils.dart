/// Utility methods specifically for Android platform.
///
/// This file helps isolate any Android-only logic such as
/// permission handling, intent launching, or Android SDK integrations.
///
/// Keep logic here minimal unless using MethodChannels or platform-specific packages.

import 'dart:io';

class AndroidUtils {
  /// Checks if the current platform is Android.
  static bool isAndroid() => Platform.isAndroid;

  /// Example method stub for Android-specific logic.
  static void logAndroidMessage(String message) {
    if (isAndroid()) {
      print("[ANDROID] $message");
    }
  }

  // Add permission, intent, or channel logic here in future tiers.
}
