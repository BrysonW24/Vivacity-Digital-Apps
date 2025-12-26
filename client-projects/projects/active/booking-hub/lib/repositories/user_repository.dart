import 'base_repository.dart';
import '../models/user_model.dart';

/// User Repository
///
/// Handles user data operations.
abstract class UserRepository extends BaseRepository {
  /// Get user profile
  Future<UserModel> getProfile();

  /// Update user profile
  Future<UserModel> updateProfile({
    String? name,
    String? email,
    String? phone,
  });

  /// Upload user avatar
  Future<String> uploadAvatar(String imagePath);

  /// Search users
  Future<List<UserModel>> searchUsers(String query);

  /// Get user by ID
  Future<UserModel> getUserById(String userId);
}

/// User Repository Implementation
class UserRepositoryImpl extends UserRepository {
  // TODO: Inject dependencies (api_client, local_storage, etc.)

  @override
  Future<UserModel> getProfile() async {
    // TODO: Call API endpoint to get profile
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    // TODO: Call API endpoint to update profile
    throw UnimplementedError();
  }

  @override
  Future<String> uploadAvatar(String imagePath) async {
    // TODO: Upload image file and return URL
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    // TODO: Call API endpoint to search users
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    // TODO: Call API endpoint to get user by ID
    throw UnimplementedError();
  }
}
