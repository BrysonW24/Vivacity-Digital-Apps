/// API exception classes
class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.code,
    this.originalException,
  });

  final String message;
  final int? statusCode;
  final String? code;
  final dynamic originalException;

  @override
  String toString() => 'ApiException: $message';
}

class TimeoutException extends ApiException {
  TimeoutException()
      : super(
          message: 'Request timeout. Please try again.',
          code: 'TIMEOUT',
        );
}

class ServerException extends ApiException {
  ServerException({int? statusCode})
      : super(
          message: 'Server error. Please try again later.',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );
}

class NoInternetException extends ApiException {
  NoInternetException()
      : super(
          message: 'No internet connection.',
          code: 'NO_INTERNET',
        );
}

class BadRequestException extends ApiException {
  BadRequestException({String? message})
      : super(
          message: message ?? 'Bad request.',
          statusCode: 400,
          code: 'BAD_REQUEST',
        );
}

class UnauthorizedException extends ApiException {
  UnauthorizedException()
      : super(
          message: 'Unauthorized. Please login again.',
          statusCode: 401,
          code: 'UNAUTHORIZED',
        );
}

class ForbiddenException extends ApiException {
  ForbiddenException()
      : super(
          message: 'You do not have permission to access this resource.',
          statusCode: 403,
          code: 'FORBIDDEN',
        );
}

class NotFoundException extends ApiException {
  NotFoundException()
      : super(
          message: 'The requested resource was not found.',
          statusCode: 404,
          code: 'NOT_FOUND',
        );
}

class ConflictException extends ApiException {
  ConflictException({String? message})
      : super(
          message: message ?? 'A conflict occurred.',
          statusCode: 409,
          code: 'CONFLICT',
        );
}
