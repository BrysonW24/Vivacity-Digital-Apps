/// Validation utilities for form inputs and data validation
/// Provides reusable validation methods across the app

import 'package:small_app/constants/app_constants.dart';

class Validators {
  // ==================== Email Validation ====================
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static bool isValidEmail(String email) {
    return RegExp(AppConstants.emailRegex).hasMatch(email);
  }

  // ==================== Password Validation ====================
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    if (!value.contains(RegExp(r'[@$!%*?&]'))) {
      return 'Password must contain special character (@\$!%*?&)';
    }
    return null;
  }

  static String? validatePasswordConfirm(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static PasswordStrength getPasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[@$!%*?&]'))) strength++;

    switch (strength) {
      case 0:
      case 1:
        return PasswordStrength.weak;
      case 2:
      case 3:
        return PasswordStrength.fair;
      case 4:
        return PasswordStrength.good;
      default:
        return PasswordStrength.strong;
    }
  }

  // ==================== Phone Number Validation ====================
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Phone number must have at least 10 digits';
    }
    if (!RegExp(AppConstants.phoneRegex).hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // ==================== Name Validation ====================
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Name must be less than 100 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }
    return null;
  }

  // ==================== URL Validation ====================
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    if (!RegExp(AppConstants.urlRegex).hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  static bool isValidUrl(String url) {
    return RegExp(AppConstants.urlRegex).hasMatch(url);
  }

  // ==================== Required Field Validation ====================
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // ==================== Number Validation ====================
  static String? validateNumber(String? value, {int min = 0, int max = 999999}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number < min) {
      return 'Must be at least $min';
    }
    if (number > max) {
      return 'Must be no more than $max';
    }
    return null;
  }

  // ==================== Range Validation ====================
  static String? validateLength(String? value, {required int min, int? max}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < min) {
      return 'Must be at least $min characters';
    }
    if (max != null && value.length > max) {
      return 'Must be no more than $max characters';
    }
    return null;
  }

  // ==================== Date Validation ====================
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return 'Please enter a valid date';
    }
  }

  // ==================== Credit Card Validation ====================
  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    final cardNumber = value.replaceAll(RegExp(r'\s'), '');
    if (cardNumber.length < 13 || cardNumber.length > 19) {
      return 'Invalid card number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cardNumber)) {
      return 'Card number must contain only digits';
    }
    return null;
  }
}

enum PasswordStrength {
  weak,
  fair,
  good,
  strong,
}

extension PasswordStrengthExtension on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.fair:
        return 'Fair';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  int get percentage {
    switch (this) {
      case PasswordStrength.weak:
        return 25;
      case PasswordStrength.fair:
        return 50;
      case PasswordStrength.good:
        return 75;
      case PasswordStrength.strong:
        return 100;
    }
  }
}
