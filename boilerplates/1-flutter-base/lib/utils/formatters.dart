/// A collection of utility methods for formatting strings, numbers, and dates.
///
/// These are pure functions — no side effects or dependencies.
/// Useful for consistent display across UI layers.

class Formatters {
  /// Capitalizes the first letter of a word
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Formats a double as currency with 2 decimal places
  static String formatCurrency(double value, {String symbol = '\$'}) {
    return '$symbol${value.toStringAsFixed(2)}';
  }

  /// Truncates a long string with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
