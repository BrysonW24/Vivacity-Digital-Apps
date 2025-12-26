import 'package:flutter/foundation.dart';
import '../enums/loading_status.dart';
import '../models/notification_model.dart';

/// Notification Provider
///
/// Manages notifications and notification state.
class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  LoadingStatus _loadingStatus = LoadingStatus.initial;
  int _unreadCount = 0;
  String? _errorMessage;

  // Getters
  List<NotificationModel> get notifications => _notifications;
  LoadingStatus get loadingStatus => _loadingStatus;
  int get unreadCount => _unreadCount;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _loadingStatus == LoadingStatus.loading;
  bool get isEmpty => _notifications.isEmpty;
  bool get hasUnread => _unreadCount > 0;

  /// Fetch notifications
  Future<void> fetchNotifications() async {
    _setLoadingStatus(LoadingStatus.loading);
    _clearError();

    try {
      // TODO: Call notification service to fetch notifications
      // Update _notifications list
      // Calculate unread count

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to fetch notifications: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Load more notifications (pagination)
  Future<void> loadMore() async {
    if (_loadingStatus == LoadingStatus.loadingMore) return;

    _setLoadingStatus(LoadingStatus.loadingMore);
    _clearError();

    try {
      // TODO: Call notification service with offset/page
      // Append to existing _notifications

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to load more: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      // TODO: Call notification service to mark as read
      // Update notification in list
      // Decrement unread count

      final index = _notifications
          .indexWhere((n) => n.id == notificationId);
      if (index >= 0 && !_notifications[index].isRead) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        _unreadCount--;
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to mark as read: ${e.toString()}');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      // TODO: Call notification service to mark all as read

      for (var i = 0; i < _notifications.length; i++) {
        if (!_notifications[i].isRead) {
          _notifications[i] = _notifications[i].copyWith(isRead: true);
        }
      }
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      _setError('Failed to mark all as read: ${e.toString()}');
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      // TODO: Call notification service to delete

      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete notification: ${e.toString()}');
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    try {
      // TODO: Call notification service to clear all

      _notifications.clear();
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      _setError('Failed to clear notifications: ${e.toString()}');
    }
  }

  /// Refresh notifications
  Future<void> refresh() async {
    _clearError();
    await fetchNotifications();
  }

  /// Add notification (for real-time updates)
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    if (!notification.isRead) {
      _unreadCount++;
    }
    notifyListeners();
  }

  // Private helpers
  void _setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
