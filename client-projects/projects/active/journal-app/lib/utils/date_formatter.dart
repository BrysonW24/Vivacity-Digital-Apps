import 'package:intl/intl.dart';

/// Utility class for formatting dates in the journal app
class DateFormatter {
  DateFormatter._();

  // ==================== DATE FORMATS ====================

  static final DateFormat _fullDate = DateFormat('MMMM d, yyyy');
  static final DateFormat _shortDate = DateFormat('MMM d, yyyy');
  static final DateFormat _time = DateFormat('h:mm a');
  static final DateFormat _dateTime = DateFormat('MMM d, yyyy • h:mm a');
  static final DateFormat _dayMonth = DateFormat('MMMM d');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy');

  // ==================== FORMAT METHODS ====================

  /// Format as "January 15, 2025"
  static String fullDate(DateTime date) => _fullDate.format(date);

  /// Format as "Jan 15, 2025"
  static String shortDate(DateTime date) => _shortDate.format(date);

  /// Format as "3:45 PM"
  static String time(DateTime date) => _time.format(date);

  /// Format as "Jan 15, 2025 • 3:45 PM"
  static String dateTime(DateTime date) => _dateTime.format(date);

  /// Format as "January 15"
  static String dayMonth(DateTime date) => _dayMonth.format(date);

  /// Format as "January 2025"
  static String monthYear(DateTime date) => _monthYear.format(date);

  // ==================== RELATIVE TIME ====================

  /// Format as "Today", "Yesterday", "2 days ago", etc.
  static String relativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else {
      final difference = today.difference(dateOnly).inDays;
      if (difference < 7) {
        return '$difference days ago';
      } else if (difference < 30) {
        final weeks = (difference / 7).floor();
        return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
      } else if (difference < 365) {
        final months = (difference / 30).floor();
        return months == 1 ? '1 month ago' : '$months months ago';
      } else {
        final years = (difference / 365).floor();
        return years == 1 ? '1 year ago' : '$years years ago';
      }
    }
  }

  /// Format as "Just now", "5 minutes ago", "2 hours ago", etc.
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1 ? '1 day ago' : '$days days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  /// Format with relative date + time: "Today at 3:45 PM", "Yesterday at 9:00 AM"
  static String relativeDateWithTime(DateTime dateTime) {
    final relDate = relativeDate(dateTime);
    final timeStr = time(dateTime);
    return '$relDate at $timeStr';
  }

  // ==================== UTILITY METHODS ====================

  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Get start of day (midnight)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day (11:59:59.999)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
}
