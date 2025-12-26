/// Authentication state enumeration
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

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isLoading => this == AuthStatus.loading;
  bool get canAccessApp => isAuthenticated;

  String get message {
    switch (this) {
      case AuthStatus.initial:
        return 'Initializing...';
      case AuthStatus.authenticated:
        return 'Authenticated';
      case AuthStatus.unauthenticated:
        return 'Not authenticated';
      case AuthStatus.loading:
        return 'Authenticating...';
      case AuthStatus.emailVerificationRequired:
        return 'Email verification required';
      case AuthStatus.locked:
        return 'Account locked';
      case AuthStatus.suspended:
        return 'Account suspended';
      case AuthStatus.sessionExpired:
        return 'Session expired';
    }
  }
}
