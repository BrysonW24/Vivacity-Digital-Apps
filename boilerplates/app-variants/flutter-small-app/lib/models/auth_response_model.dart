/// Authentication response model
/// Handles login/signup response from API with token and user data

class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final User user;
  final DateTime expiresAt;

  AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
    required this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] ?? json['access_token'] ?? '',
      refreshToken: json['refreshToken'] ?? json['refresh_token'],
      user: User.fromJson(json['user'] ?? {}),
      expiresAt: DateTime.parse(
        json['expiresAt'] ??
            json['expires_at'] ??
            DateTime.now().add(Duration(hours: 24)).toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  /// Check if token has expired
  bool get isTokenExpired => DateTime.now().isAfter(expiresAt);

  /// Check if token is valid (not expired)
  bool get isTokenValid => !isTokenExpired;
}
