import 'package:flutter/material.dart';

/// NotificationProvider handles local UI-based notifications.
/// This does NOT deal with Firebase push notifications (handled in higher tiers).
///
/// It's useful for showing snackbars, alert dialogs, banners, or toasts
/// across the app using centralized state or commands.

class NotificationProvider with ChangeNotifier {
  String? _notification;

  /// Returns the latest notification message
  String? get notification => _notification;

  /// Triggers a new notification
  void showNotification(String message) {
    _notification = message;
    notifyListeners();
  }

  /// Clears the current notification after it's been shown
  void clearNotification() {
    _notification = null;
    notifyListeners();
  }
}
