import 'package:intl/intl.dart';

/// Format Utilities
///
/// String formatting helpers for dates, currency, etc.
class Formatters {
  /// Format date to display format (dd/MM/yyyy)
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date to full format (EEEE, MMMM dd, yyyy)
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(date);
  }

  /// Format date to time format (hh:mm a)
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Format date to datetime format
  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }

  /// Format currency
  static String formatCurrency(double amount, {String currency = '\$'}) {
    return '$currency${amount.toStringAsFixed(2)}';
  }

  /// Format phone number (US format)
  static String formatPhoneNumber(String phone) {
    if (phone.length != 10) return phone;
    return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-'
        '${phone.substring(6)}';
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Capitalize all words
  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) => capitalize(word))
        .join(' ');
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Format number with thousand separators
  static String formatNumber(num number) {
    return NumberFormat('#,##0').format(number);
  }

  /// Truncate text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
