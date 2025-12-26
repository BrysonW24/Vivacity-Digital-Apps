/// Extension methods for common types
/// Provides convenient helper methods across the app

import 'dart:math';

extension StringExtensions on String {
  /// Check if string is empty or whitespace only
  bool get isEmptyOrWhitespace => trim().isEmpty;

  /// Check if string is valid email
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  /// Check if string is valid URL
  bool get isValidUrl {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&/=]*)$',
    ).hasMatch(this);
  }

  /// Check if string contains only digits
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Remove all whitespace
  String removeWhitespace() => replaceAll(RegExp(r'\s'), '');

  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Capitalize each word
  String capitalizeWords() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Truncate string with ellipsis
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return substring(0, length - ellipsis.length) + ellipsis;
  }

  /// Check if string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string is alphanumeric
  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Reverse string
  String reverse() => split('').reversed.join('');

  /// Check if string is palindrome
  bool get isPalindrome => toLowerCase() == toLowerCase().reverse();

  /// Convert string to slug format
  String toSlug() {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-');
  }

  /// Extract numbers from string
  String extractNumbers() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Remove special characters
  String removeSpecialCharacters() {
    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }
}

extension IntExtensions on int {
  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Clamp value between min and max
  int clamp(int min, int max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Repeat action n times
  void times(Function(int) action) {
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }

  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return '$symbol${toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}';
  }

  /// Format as percentage
  String toPercentage({int decimals = 0}) {
    final value = toDouble();
    return '${(value).toStringAsFixed(decimals)}%';
  }
}

extension DoubleExtensions on double {
  /// Check if double is even
  bool get isEven => toInt() % 2 == 0;

  /// Check if double is odd
  bool get isOdd => toInt() % 2 != 0;

  /// Check if double is positive
  bool get isPositive => this > 0;

  /// Check if double is negative
  bool get isNegative => this < 0;

  /// Check if double is zero
  bool get isZero => this == 0;

  /// Round to specific decimal places
  double roundToDecimal(int decimals) {
    final factor = pow(10.0, decimals);
    return (this * factor).round() / factor;
  }

  /// Clamp value between min and max
  double clamp(double min, double max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return '$symbol${toStringAsFixed(2).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}';
  }

  /// Format as percentage
  String toPercentage({int decimals = 2}) {
    return '${toStringAsFixed(decimals)}%';
  }
}

extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get age from birth date
  int getAge() {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  /// Get difference in days
  int getDaysDifference(DateTime other) {
    return difference(other).inDays;
  }

  /// Format date as readable string
  String toReadableString() {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';

    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '$day ${months[month]} $year';
  }

  /// Format as time string (HH:MM)
  String toTimeString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Format as date string (MM/DD/YYYY)
  String toDateString() {
    return '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year';
  }

  /// Format as full string (MM/DD/YYYY HH:MM)
  String toFullString() {
    return '${toDateString()} ${toTimeString()}';
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

extension ListExtensions<T> on List<T> {
  /// Check if list is empty
  bool get isEmpty => length == 0;

  /// Check if list is not empty
  bool get isNotEmpty => length > 0;

  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Safe get at index
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Remove duplicates
  List<T> removeDuplicates() {
    return toSet().toList();
  }

  /// Shuffle list
  List<T> shuffled() {
    final list = [...this];
    list.shuffle();
    return list;
  }

  /// Reverse without modifying original
  List<T> reversed() => [...this].reversed.toList();

  /// Check if any element matches condition
  bool anyWhere(bool Function(T) test) {
    return any(test);
  }

  /// Get unique elements
  List<T> unique() => toSet().toList();

  /// Flatten nested lists
  List<dynamic> flatten() {
    final result = <dynamic>[];
    for (final item in this) {
      if (item is List) {
        result.addAll((item as List<dynamic>).flatten());
      } else {
        result.add(item);
      }
    }
    return result;
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  /// Check if map is empty
  bool get isEmpty => length == 0;

  /// Check if map is not empty
  bool get isNotEmpty => length > 0;

  /// Get value or default
  V? getOrDefault(K key, V? defaultValue) {
    return containsKey(key) ? this[key] : defaultValue;
  }

  /// Merge two maps
  Map<K, V> merge(Map<K, V> other) {
    return {...this, ...other};
  }

  /// Convert to query string (for URLs)
  String toQueryString() {
    final parts = <String>[];
    forEach((key, value) {
      parts.add('$key=$value');
    });
    return parts.join('&');
  }

  /// Filter map by values
  Map<K, V> filterByValue(bool Function(V) test) {
    final result = <K, V>{};
    forEach((key, value) {
      if (test(value)) {
        result[key] = value;
      }
    });
    return result;
  }

  /// Transform map values
  Map<K, T> mapValues<T>(T Function(V) transform) {
    final result = <K, T>{};
    forEach((key, value) {
      result[key] = transform(value);
    });
    return result;
  }
}
