/// Network and API-specific exceptions
/// Handles HTTP errors, timeouts, connectivity issues

import 'app_exception.dart';

class NetworkException extends AppException {
  final int? statusCode;

  NetworkException({
    required String message,
    this.statusCode,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'NETWORK_ERROR',
    originalException: originalException,
  );
}

/// Connection timeout exception - request took too long
class TimeoutException extends NetworkException {
  TimeoutException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Request timeout. Please try again.',
    code: 'TIMEOUT',
    originalException: originalException,
  );
}

/// Server error exception - 5xx status codes
class ServerException extends NetworkException {
  ServerException({
    required int statusCode,
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Server error. Please try again later.',
    statusCode: statusCode,
    code: 'SERVER_ERROR',
    originalException: originalException,
  );
}

/// No internet connection exception
class NoInternetException extends NetworkException {
  NoInternetException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'No internet connection.',
    code: 'NO_INTERNET',
    originalException: originalException,
  );
}

/// Bad request exception - 400 status code
class BadRequestException extends NetworkException {
  BadRequestException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Bad request. Please check your input.',
    statusCode: 400,
    code: 'BAD_REQUEST',
    originalException: originalException,
  );
}

/// Not found exception - 404 status code
class NotFoundException extends NetworkException {
  NotFoundException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'The requested resource was not found.',
    statusCode: 404,
    code: 'NOT_FOUND',
    originalException: originalException,
  );
}

/// Forbidden exception - 403 status code
class ForbiddenException extends NetworkException {
  ForbiddenException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'You do not have permission to access this resource.',
    statusCode: 403,
    code: 'FORBIDDEN',
    originalException: originalException,
  );
}

/// Conflict exception - 409 status code
class ConflictException extends NetworkException {
  ConflictException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'A conflict occurred. Please try again.',
    statusCode: 409,
    code: 'CONFLICT',
    originalException: originalException,
  );
}
