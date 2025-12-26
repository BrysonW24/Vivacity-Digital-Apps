import 'base_repository.dart';
import '../models/notification_model.dart';

/// Notification Repository
///
/// Handles notification data operations.
abstract class NotificationRepository extends BaseRepository {
  /// Get notifications
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 20,
  });

  /// Mark notification as read
  Future<void> markAsRead(String notificationId);

  /// Mark all notifications as read
  Future<void> markAllAsRead();

  /// Delete notification
  Future<void> deleteNotification(String notificationId);

  /// Clear all notifications
  Future<void> clearAll();

  /// Get unread count
  Future<int> getUnreadCount();
}

/// Notification Repository Implementation
class NotificationRepositoryImpl extends NotificationRepository {
  // TODO: Inject dependencies (api_client, local_storage, etc.)

  @override
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 20,
  }) async {
    // TODO: Call API endpoint to get notifications
    throw UnimplementedError();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    // TODO: Call API endpoint to mark as read
    throw UnimplementedError();
  }

  @override
  Future<void> markAllAsRead() async {
    // TODO: Call API endpoint to mark all as read
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    // TODO: Call API endpoint to delete notification
    throw UnimplementedError();
  }

  @override
  Future<void> clearAll() async {
    // TODO: Call API endpoint to clear all
    throw UnimplementedError();
  }

  @override
  Future<int> getUnreadCount() async {
    // TODO: Call API endpoint to get unread count
    throw UnimplementedError();
  }
}
