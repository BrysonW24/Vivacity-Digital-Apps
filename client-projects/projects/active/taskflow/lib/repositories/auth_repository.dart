import 'base_repository.dart';
import '../models/auth_response_model.dart';

/// Auth Repository
///
/// Handles authentication data operations.
abstract class AuthRepository extends BaseRepository {
  /// Login with email and password
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  /// Register new user
  Future<AuthResponseModel> signup({
    required String email,
    required String password,
    required String name,
  });

  /// Refresh authentication token
  Future<AuthResponseModel> refreshToken(String refreshToken);

  /// Verify email
  Future<void> verifyEmail(String code);

  /// Request password reset
  Future<void> requestPasswordReset(String email);

  /// Reset password
  Future<void> resetPassword({
    required String token,
    required String password,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Delete account
  Future<void> deleteAccount(String password);

  /// Logout
  Future<void> logout();
}

/// Auth Repository Implementation
class AuthRepositoryImpl extends AuthRepository {
  // TODO: Inject dependencies (api_client, local_storage, etc.)

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    // TODO: Call API endpoint for login
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseModel> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: Call API endpoint for signup
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    // TODO: Call API endpoint to refresh token
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail(String code) async {
    // TODO: Call API endpoint to verify email
    throw UnimplementedError();
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    // TODO: Call API endpoint to request reset
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    // TODO: Call API endpoint to reset password
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // TODO: Call API endpoint to change password
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount(String password) async {
    // TODO: Call API endpoint to delete account
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO: Call API endpoint for logout if needed
    // Clear local storage
    throw UnimplementedError();
  }
}
