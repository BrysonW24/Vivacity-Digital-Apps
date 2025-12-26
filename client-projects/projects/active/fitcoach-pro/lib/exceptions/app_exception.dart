/// Base exception class for all app exceptions
/// All exceptions in the app should extend this for consistent error handling

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => message;
}

/// Validation exception for form and input validation errors
class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'VALIDATION_ERROR',
    originalException: originalException,
  );
}

/// Database exception for database operation errors
class DatabaseException extends AppException {
  DatabaseException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'DATABASE_ERROR',
    originalException: originalException,
  );
}

/// Cache exception for cache operation errors
class CacheException extends AppException {
  CacheException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'CACHE_ERROR',
    originalException: originalException,
  );
}
