/// Authentication-specific exceptions
/// Used in auth flow for structured error handling

import 'app_exception.dart';

class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code ?? 'AUTH_ERROR',
    originalException: originalException,
  );
}

/// Unauthorized access exception - user needs to login again
class UnauthorizedException extends AuthException {
  UnauthorizedException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Unauthorized. Please log in again.',
    code: 'UNAUTHORIZED',
    originalException: originalException,
  );
}

/// Token expired exception - refresh token needed
class TokenExpiredException extends AuthException {
  TokenExpiredException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Session expired. Please log in again.',
    code: 'TOKEN_EXPIRED',
    originalException: originalException,
  );
}

/// Invalid credentials exception - wrong email/password
class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Invalid email or password.',
    code: 'INVALID_CREDENTIALS',
    originalException: originalException,
  );
}

/// Account locked exception
class AccountLockedException extends AuthException {
  AccountLockedException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Your account has been locked. Please contact support.',
    code: 'ACCOUNT_LOCKED',
    originalException: originalException,
  );
}

/// Email not verified exception
class EmailNotVerifiedException extends AuthException {
  EmailNotVerifiedException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'Please verify your email address.',
    code: 'EMAIL_NOT_VERIFIED',
    originalException: originalException,
  );
}

/// User already exists exception - during signup
class UserAlreadyExistsException extends AuthException {
  UserAlreadyExistsException({
    String? message,
    dynamic originalException,
  }) : super(
    message: message ?? 'This account already exists.',
    code: 'USER_ALREADY_EXISTS',
    originalException: originalException,
  );
}
