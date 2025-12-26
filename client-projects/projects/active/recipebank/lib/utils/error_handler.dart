/// Error handling utilities and custom exceptions
/// Centralized error handling for consistent error management across the app

import 'package:dio/dio.dart';
import 'package:small_app/constants/app_enums.dart';

/// Base exception class for all custom exceptions
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

/// API Exception - for HTTP/API related errors
class ApiException extends AppException {
  final int? statusCode;

  ApiException({
    required String message,
    this.statusCode,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'API_ERROR',
    originalException: originalException,
  );

  factory ApiException.fromDioException(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final message = dioException.message ?? 'An error occurred';

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: 'Connection timeout. Please try again.',
          statusCode: statusCode,
          code: 'CONNECTION_TIMEOUT',
          originalException: dioException,
        );
      case DioExceptionType.sendTimeout:
        return ApiException(
          message: 'Request timeout. Please try again.',
          statusCode: statusCode,
          code: 'SEND_TIMEOUT',
          originalException: dioException,
        );
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Response timeout. Please try again.',
          statusCode: statusCode,
          code: 'RECEIVE_TIMEOUT',
          originalException: dioException,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          message: _getErrorMessageFromStatusCode(statusCode),
          statusCode: statusCode,
          code: 'BAD_RESPONSE_${statusCode ?? 'UNKNOWN'}',
          originalException: dioException,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request was cancelled',
          statusCode: statusCode,
          code: 'REQUEST_CANCELLED',
          originalException: dioException,
        );
      case DioExceptionType.unknown:
        return ApiException(
          message: message,
          statusCode: statusCode,
          code: 'UNKNOWN_ERROR',
          originalException: dioException,
        );
      case DioExceptionType.badCertificate:
        return ApiException(
          message: 'Certificate error. Connection cannot be established.',
          statusCode: statusCode,
          code: 'BAD_CERTIFICATE',
          originalException: dioException,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'Network error. Please check your connection.',
          statusCode: statusCode,
          code: 'CONNECTION_ERROR',
          originalException: dioException,
        );
    }
  }

  static String _getErrorMessageFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 403:
        return 'Access forbidden.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict. Please try again.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  bool get isNetworkError =>
      code == 'CONNECTION_ERROR' || code == 'CONNECTION_TIMEOUT';

  bool get isAuthenticationError => statusCode == 401;

  bool get isAuthorizationError => statusCode == 403;

  bool get isNotFoundError => statusCode == 404;

  bool get isServerError => statusCode != null && statusCode! >= 500;
}

/// Network Exception - for network connectivity issues
class NetworkException extends AppException {
  NetworkException({
    String message = 'Network error occurred',
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'NETWORK_ERROR',
    originalException: originalException,
  );
}

/// Cache Exception - for caching related errors
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

/// Database Exception - for database related errors
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

/// Authentication Exception - for auth related errors
class AuthenticationException extends AppException {
  AuthenticationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'AUTH_ERROR',
    originalException: originalException,
  );
}

/// Validation Exception - for validation errors
class ValidationException extends AppException {
  final Map<String, String>? errors;

  ValidationException({
    required String message,
    this.errors,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'VALIDATION_ERROR',
    originalException: originalException,
  );
}

/// Error Handler - utility class for handling errors
class ErrorHandler {
  /// Get user-friendly error message
  static String getErrorMessage(dynamic error) {
    if (error is AppException) {
      return error.message;
    } else if (error is DioException) {
      final apiException = ApiException.fromDioException(error);
      return apiException.message;
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unexpected error occurred';
    }
  }

  /// Get error code
  static String? getErrorCode(dynamic error) {
    if (error is AppException) {
      return error.code;
    }
    return null;
  }

  /// Check if error is network related
  static bool isNetworkError(dynamic error) {
    if (error is NetworkException) return true;
    if (error is ApiException) return error.isNetworkError;
    if (error is DioException) {
      return error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout;
    }
    return false;
  }

  /// Check if error is authentication related
  static bool isAuthenticationError(dynamic error) {
    if (error is AuthenticationException) return true;
    if (error is ApiException) return error.isAuthenticationError;
    return false;
  }

  /// Check if error is due to timeout
  static bool isTimeoutError(dynamic error) {
    if (error is ApiException) return error.code?.contains('TIMEOUT') ?? false;
    if (error is DioException) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout;
    }
    return false;
  }

  /// Check if error is validation related
  static bool isValidationError(dynamic error) {
    return error is ValidationException;
  }

  /// Get API error status from exception
  static ApiStatus getApiStatus(dynamic error) {
    if (isNetworkError(error)) {
      return ApiStatus.networkError;
    } else if (isTimeoutError(error)) {
      return ApiStatus.timeoutError;
    } else {
      return ApiStatus.error;
    }
  }

  /// Log error for debugging
  static void logError(dynamic error, {String? tag}) {
    final errorTag = tag ?? 'ERROR';
    final message = getErrorMessage(error);
    final code = getErrorCode(error);

    print('[$errorTag] $code: $message');

    if (error is AppException && error.originalException != null) {
      print('[$errorTag] Original: ${error.originalException}');
    }
  }
}

/// Result wrapper class for handling success/failure states
class Result<T> {
  final T? data;
  final AppException? error;
  final bool isSuccess;

  Result._success(this.data)
      : error = null,
        isSuccess = true;

  Result._failure(this.error)
      : data = null,
        isSuccess = false;

  factory Result.success(T data) => Result._success(data);

  factory Result.failure(AppException error) => Result._failure(error);

  /// Execute callback based on success/failure
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(AppException error) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onFailure(error!);
    }
  }

  /// Execute void callback based on success/failure
  void whenAsync({
    required Function(T data) onSuccess,
    required Function(AppException error) onFailure,
  }) {
    if (isSuccess) {
      onSuccess(data as T);
    } else {
      onFailure(error!);
    }
  }

  /// Get data or null
  T? getOrNull() => data;

  /// Get error or null
  AppException? getErrorOrNull() => error;

  /// Map success value
  Result<R> map<R>(R Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(data as T));
    } else {
      return Result.failure(error!);
    }
  }

  /// Flat map (chain results)
  Result<R> flatMap<R>(Result<R> Function(T) transform) {
    if (isSuccess) {
      return transform(data as T);
    } else {
      return Result.failure(error!);
    }
  }

  /// Fold pattern matching
  R fold<R>({
    required R Function(T) onRight,
    required R Function(AppException) onLeft,
  }) {
    if (isSuccess) {
      return onRight(data as T);
    } else {
      return onLeft(error!);
    }
  }

  /// Get data or throw error
  T getOrThrow() {
    if (isSuccess) {
      return data as T;
    } else {
      throw error!;
    }
  }

  /// Get data or return default value
  T getOrElse(T defaultValue) {
    return data ?? defaultValue;
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'Result<$T>.success($data)';
    } else {
      return 'Result<$T>.failure($error)';
    }
  }
}
