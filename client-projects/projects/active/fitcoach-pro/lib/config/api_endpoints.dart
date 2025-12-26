/// API endpoint constants
/// Centralized API route definitions for all endpoints

class ApiEndpoints {
  // ==================== Auth Endpoints ====================
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';

  // ==================== User Endpoints ====================
  static const String getUserProfile = '/users/me';
  static const String updateProfile = '/users/me';
  static const String changePassword = '/users/me/password';
  static const String deleteAccount = '/users/me';
  static const String getUserById = '/users/:id';

  // ==================== Notification Endpoints ====================
  static const String getNotifications = '/notifications';
  static const String getNotificationById = '/notifications/:id';
  static const String markAsRead = '/notifications/:id/read';
  static const String markAllAsRead = '/notifications/mark-all-read';
  static const String deleteNotification = '/notifications/:id';

  // ==================== Settings Endpoints ====================
  static const String getSettings = '/settings';
  static const String updateSettings = '/settings';

  // ==================== Health Check ====================
  static const String healthCheck = '/health';
}
