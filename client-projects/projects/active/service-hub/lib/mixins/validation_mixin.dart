import '../exceptions/validation_exception.dart';

/// Validation Mixin
///
/// Provides common validation methods for forms and inputs.
mixin ValidationMixin {
  /// Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  /// Check password strength requirements
  List<String> checkPasswordStrength(String password) {
    final failedChecks = <String>[];

    if (password.length < 8) failedChecks.add('too_short');
    if (!password.contains(RegExp(r'[A-Z]'))) {
      failedChecks.add('missing_uppercase');
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      failedChecks.add('missing_lowercase');
    }
    if (!password.contains(RegExp(r'[0-9]'))) failedChecks.add('missing_digits');
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      failedChecks.add('missing_special_char');
    }

    return failedChecks;
  }

  /// Validate phone number
  bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^[0-9\s\-\+\(\)]{10,}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Validate URL
  bool isValidUrl(String url) {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(url);
  }

  /// Validate required field
  bool isRequired(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validate min length
  bool minLength(String value, int min) {
    return value.length >= min;
  }

  /// Validate max length
  bool maxLength(String value, int max) {
    return value.length <= max;
  }

  /// Validate numeric
  bool isNumeric(String value) {
    return num.tryParse(value) != null;
  }

  /// Validate integer
  bool isInteger(String value) {
    return int.tryParse(value) != null;
  }

  /// Validate that strings match
  bool stringsMatch(String value1, String value2) {
    return value1 == value2;
  }
}
