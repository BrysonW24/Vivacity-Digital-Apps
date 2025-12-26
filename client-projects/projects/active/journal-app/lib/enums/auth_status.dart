/// Authentication Status Enum
///
/// Represents the different authentication states in the application.
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  emailVerificationRequired,
  locked,
  suspended,
  sessionExpired,
}

extension AuthStatusExtension on AuthStatus {
  /// Check if user is authenticated
  bool get isAuthenticated => this == AuthStatus.authenticated;

  /// Check if user is currently loading auth state
  bool get isLoading => this == AuthStatus.loading;

  /// Check if authentication is pending (initial state)
  bool get isPending => this == AuthStatus.initial;

  /// Check if user session has expired
  bool get isSessionExpired => this == AuthStatus.sessionExpired;

  /// Check if email verification is required
  bool get needsEmailVerification =>
      this == AuthStatus.emailVerificationRequired;

  /// Get display name for auth status
  String get displayName {
    switch (this) {
      case AuthStatus.initial:
        return 'Initializing';
      case AuthStatus.authenticated:
        return 'Authenticated';
      case AuthStatus.unauthenticated:
        return 'Not Authenticated';
      case AuthStatus.loading:
        return 'Loading';
      case AuthStatus.emailVerificationRequired:
        return 'Email Verification Required';
      case AuthStatus.locked:
        return 'Account Locked';
      case AuthStatus.suspended:
        return 'Account Suspended';
      case AuthStatus.sessionExpired:
        return 'Session Expired';
    }
  }
}
