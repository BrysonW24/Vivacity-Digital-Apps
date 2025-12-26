import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/utils/date_formatter.dart';

void main() {
  group('DateFormatter - Format Methods', () {
    test('fullDate formats correctly', () {
      final date = DateTime(2025, 1, 15);
      expect(DateFormatter.fullDate(date), 'January 15, 2025');
    });

    test('shortDate formats correctly', () {
      final date = DateTime(2025, 3, 5);
      expect(DateFormatter.shortDate(date), 'Mar 5, 2025');
    });

    test('time formats correctly', () {
      final morning = DateTime(2025, 1, 1, 9, 30);
      expect(DateFormatter.time(morning), '9:30 AM');

      final afternoon = DateTime(2025, 1, 1, 15, 45);
      expect(DateFormatter.time(afternoon), '3:45 PM');

      final midnight = DateTime(2025, 1, 1, 0, 0);
      expect(DateFormatter.time(midnight), '12:00 AM');
    });

    test('dateTime formats correctly', () {
      final date = DateTime(2025, 6, 20, 14, 30);
      final formatted = DateFormatter.dateTime(date);

      expect(formatted.contains('Jun 20, 2025'), true);
      expect(formatted.contains('2:30 PM'), true);
      expect(formatted.contains('•'), true);
    });

    test('dayMonth formats correctly', () {
      final date = DateTime(2025, 12, 25);
      expect(DateFormatter.dayMonth(date), 'December 25');
    });

    test('monthYear formats correctly', () {
      final date = DateTime(2025, 7, 1);
      expect(DateFormatter.monthYear(date), 'July 2025');
    });
  });

  group('DateFormatter - Relative Date', () {
    test('returns "Today" for today', () {
      final now = DateTime.now();
      expect(DateFormatter.relativeDate(now), 'Today');
    });

    test('returns "Yesterday" for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateFormatter.relativeDate(yesterday), 'Yesterday');
    });

    test('returns "X days ago" for dates within a week', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      expect(DateFormatter.relativeDate(twoDaysAgo), '2 days ago');

      final sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
      expect(DateFormatter.relativeDate(sixDaysAgo), '6 days ago');
    });

    test('returns "X weeks ago" for dates within a month', () {
      final twoWeeksAgo = DateTime.now().subtract(const Duration(days: 14));
      expect(DateFormatter.relativeDate(twoWeeksAgo), '2 weeks ago');

      final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
      expect(DateFormatter.relativeDate(oneWeekAgo), '1 week ago');
    });

    test('returns "X months ago" for dates within a year', () {
      final now = DateTime.now();
      final twoMonthsAgo = DateTime(now.year, now.month - 2, now.day);
      final result = DateFormatter.relativeDate(twoMonthsAgo);

      expect(result.contains('month'), true);
      expect(result.contains('ago'), true);
    });

    test('returns "X years ago" for dates over a year', () {
      final now = DateTime.now();
      final oneYearAgo = DateTime(now.year - 1, now.month, now.day);
      expect(DateFormatter.relativeDate(oneYearAgo), '1 year ago');

      final twoYearsAgo = DateTime(now.year - 2, now.month, now.day);
      expect(DateFormatter.relativeDate(twoYearsAgo), '2 years ago');
    });
  });

  group('DateFormatter - Time Ago', () {
    test('returns "Just now" for recent times', () {
      final now = DateTime.now();
      expect(DateFormatter.timeAgo(now), 'Just now');

      final thirtySecondsAgo = now.subtract(const Duration(seconds: 30));
      expect(DateFormatter.timeAgo(thirtySecondsAgo), 'Just now');
    });

    test('returns "X minutes ago" for times within an hour', () {
      final now = DateTime.now();
      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      expect(DateFormatter.timeAgo(fiveMinutesAgo), '5 minutes ago');

      final oneMinuteAgo = now.subtract(const Duration(minutes: 1));
      expect(DateFormatter.timeAgo(oneMinuteAgo), '1 minute ago');
    });

    test('returns "X hours ago" for times within a day', () {
      final now = DateTime.now();
      final twoHoursAgo = now.subtract(const Duration(hours: 2));
      expect(DateFormatter.timeAgo(twoHoursAgo), '2 hours ago');

      final oneHourAgo = now.subtract(const Duration(hours: 1));
      expect(DateFormatter.timeAgo(oneHourAgo), '1 hour ago');
    });

    test('returns "X days ago" for times within a week', () {
      final now = DateTime.now();
      final threeDaysAgo = now.subtract(const Duration(days: 3));
      expect(DateFormatter.timeAgo(threeDaysAgo), '3 days ago');
    });
  });

  group('DateFormatter - Relative Date With Time', () {
    test('combines relative date with time', () {
      final now = DateTime.now();
      final result = DateFormatter.relativeDateWithTime(now);

      expect(result.contains('Today at'), true);
      expect(result.contains('AM') || result.contains('PM'), true);
    });

    test('works for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final result = DateFormatter.relativeDateWithTime(yesterday);

      expect(result.contains('Yesterday at'), true);
    });
  });

  group('DateFormatter - Utility Methods', () {
    test('isSameDay compares dates correctly', () {
      final date1 = DateTime(2025, 1, 15, 10, 30);
      final date2 = DateTime(2025, 1, 15, 18, 45);
      final date3 = DateTime(2025, 1, 16, 10, 30);

      expect(DateFormatter.isSameDay(date1, date2), true);
      expect(DateFormatter.isSameDay(date1, date3), false);
    });

    test('isToday checks if date is today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day, 15, 30);
      final yesterday = DateTime.now().subtract(const Duration(days: 1));

      expect(DateFormatter.isToday(today), true);
      expect(DateFormatter.isToday(yesterday), false);
    });

    test('isYesterday checks if date is yesterday', () {
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
      final today = DateTime.now();

      expect(DateFormatter.isYesterday(yesterday), true);
      expect(DateFormatter.isYesterday(today), false);
    });

    test('startOfDay returns midnight', () {
      final date = DateTime(2025, 6, 15, 14, 30, 45);
      final start = DateFormatter.startOfDay(date);

      expect(start.year, 2025);
      expect(start.month, 6);
      expect(start.day, 15);
      expect(start.hour, 0);
      expect(start.minute, 0);
      expect(start.second, 0);
    });

    test('endOfDay returns 11:59:59.999', () {
      final date = DateTime(2025, 6, 15, 10, 30);
      final end = DateFormatter.endOfDay(date);

      expect(end.year, 2025);
      expect(end.month, 6);
      expect(end.day, 15);
      expect(end.hour, 23);
      expect(end.minute, 59);
      expect(end.second, 59);
      expect(end.millisecond, 999);
    });

    test('startOfMonth returns first day of month', () {
      final date = DateTime(2025, 3, 15);
      final start = DateFormatter.startOfMonth(date);

      expect(start.year, 2025);
      expect(start.month, 3);
      expect(start.day, 1);
      expect(start.hour, 0);
      expect(start.minute, 0);
    });

    test('endOfMonth returns last moment of month', () {
      // January has 31 days
      final jan = DateTime(2025, 1, 15);
      final endJan = DateFormatter.endOfMonth(jan);
      expect(endJan.day, 31);

      // February 2025 has 28 days (not leap year)
      final feb = DateTime(2025, 2, 15);
      final endFeb = DateFormatter.endOfMonth(feb);
      expect(endFeb.day, 28);

      // April has 30 days
      final apr = DateTime(2025, 4, 15);
      final endApr = DateFormatter.endOfMonth(apr);
      expect(endApr.day, 30);
    });

    test('endOfMonth handles leap year', () {
      // 2024 is a leap year
      final feb2024 = DateTime(2024, 2, 15);
      final end = DateFormatter.endOfMonth(feb2024);
      expect(end.day, 29);
    });
  });

  group('DateFormatter - Edge Cases', () {
    test('handles different time zones', () {
      final utcDate = DateTime.utc(2025, 1, 15, 12, 0);
      final formatted = DateFormatter.fullDate(utcDate);
      expect(formatted, 'January 15, 2025');
    });

    test('handles midnight correctly', () {
      final midnight = DateTime(2025, 1, 1, 0, 0, 0);
      final time = DateFormatter.time(midnight);
      expect(time, '12:00 AM');
    });

    test('handles noon correctly', () {
      final noon = DateTime(2025, 1, 1, 12, 0, 0);
      final time = DateFormatter.time(noon);
      expect(time, '12:00 PM');
    });
  });
}
