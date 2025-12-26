/// Validation Exception
///
/// Thrown when form or input validation fails.
class ValidationException implements Exception {
  final String message;
  final String? field;
  final dynamic value;
  final String code;

  ValidationException({
    required this.message,
    this.field,
    this.value,
    this.code = 'VALIDATION_ERROR',
  });

  @override
  String toString() => message;

  /// Check if this validation error is for a specific field
  bool isForField(String fieldName) => field == fieldName;
}

/// Thrown when email format is invalid
class InvalidEmailException extends ValidationException {
  InvalidEmailException({String? email})
      : super(
          message: 'Invalid email format',
          field: 'email',
          value: email,
          code: 'INVALID_EMAIL',
        );
}

/// Thrown when password doesn't meet requirements
class WeakPasswordException extends ValidationException {
  final List<String> failedChecks;

  WeakPasswordException({
    required this.failedChecks,
  }) : super(
    message:
        'Password does not meet requirements: ${failedChecks.join(', ')}',
    field: 'password',
    code: 'WEAK_PASSWORD',
  );

  bool get isTooShort => failedChecks.contains('too_short');
  bool get missingUppercase => failedChecks.contains('missing_uppercase');
  bool get missingLowercase => failedChecks.contains('missing_lowercase');
  bool get missingDigits => failedChecks.contains('missing_digits');
  bool get missingSpecialChar => failedChecks.contains('missing_special_char');
}

/// Thrown when passwords don't match
class PasswordMismatchException extends ValidationException {
  PasswordMismatchException()
      : super(
          message: 'Passwords do not match',
          field: 'confirmPassword',
          code: 'PASSWORD_MISMATCH',
        );
}

/// Thrown when required field is empty
class RequiredFieldException extends ValidationException {
  RequiredFieldException({required String fieldName})
      : super(
          message: '$fieldName is required',
          field: fieldName,
          code: 'REQUIRED_FIELD',
        );
}

/// Thrown when field exceeds max length
class MaxLengthException extends ValidationException {
  final int maxLength;
  final int actualLength;

  MaxLengthException({
    required String fieldName,
    required this.maxLength,
    required this.actualLength,
  }) : super(
    message:
        '$fieldName must not exceed $maxLength characters '
        '(current: $actualLength)',
    field: fieldName,
    code: 'MAX_LENGTH_EXCEEDED',
  );
}

/// Thrown when field is below min length
class MinLengthException extends ValidationException {
  final int minLength;
  final int actualLength;

  MinLengthException({
    required String fieldName,
    required this.minLength,
    required this.actualLength,
  }) : super(
    message:
        '$fieldName must be at least $minLength characters '
        '(current: $actualLength)',
    field: fieldName,
    code: 'MIN_LENGTH_FAILED',
  );
}

/// Thrown when phone number format is invalid
class InvalidPhoneException extends ValidationException {
  InvalidPhoneException({String? phone})
      : super(
          message: 'Invalid phone number format',
          field: 'phone',
          value: phone,
          code: 'INVALID_PHONE',
        );
}

/// Thrown when URL format is invalid
class InvalidUrlException extends ValidationException {
  InvalidUrlException({String? url})
      : super(
          message: 'Invalid URL format',
          field: 'url',
          value: url,
          code: 'INVALID_URL',
        );
}

/// Thrown when form validation fails
class FormValidationException extends ValidationException {
  final Map<String, String> errors;

  FormValidationException({
    required this.errors,
  }) : super(
    message: 'Form validation failed: ${errors.length} error(s)',
    code: 'FORM_VALIDATION_ERROR',
  );

  /// Get errors for a specific field
  String? getFieldError(String fieldName) => errors[fieldName];

  /// Check if field has error
  bool hasFieldError(String fieldName) => errors.containsKey(fieldName);
}
