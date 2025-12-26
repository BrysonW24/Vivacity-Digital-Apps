import 'package:flutter/foundation.dart';
import '../enums/loading_status.dart';
import '../models/user_model.dart';

/// User Provider
///
/// Manages user profile and user-related state.
class UserProvider extends ChangeNotifier {
  UserModel? _user;
  LoadingStatus _loadingStatus = LoadingStatus.initial;
  String? _errorMessage;

  // Getters
  UserModel? get user => _user;
  LoadingStatus get loadingStatus => _loadingStatus;
  String? get errorMessage => _errorMessage;

  bool get isLoading =>
      _loadingStatus == LoadingStatus.loading ||
      _loadingStatus == LoadingStatus.refreshing;
  bool get hasUser => _user != null;

  /// Set user (from auth or elsewhere)
  void setUser(UserModel user) {
    _user = user;
    _loadingStatus = LoadingStatus.success;
    notifyListeners();
  }

  /// Fetch user profile
  Future<void> fetchUserProfile() async {
    _setLoadingStatus(LoadingStatus.loading);
    _clearError();

    try {
      // TODO: Call user service to fetch profile
      // Update _user with response data

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to fetch profile: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatar,
  }) async {
    _setLoadingStatus(LoadingStatus.loading);
    _clearError();

    try {
      // TODO: Call user service to update profile
      // Update _user with new data

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to update profile: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Update user avatar
  Future<void> updateAvatar(String imagePath) async {
    _setLoadingStatus(LoadingStatus.loading);
    _clearError();

    try {
      // TODO: Call user service to upload avatar
      // Update _user.avatar with new URL

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to update avatar: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Refresh user data
  Future<void> refresh() async {
    _setLoadingStatus(LoadingStatus.refreshing);
    _clearError();

    try {
      // TODO: Call user service to fetch latest profile
      // Update _user

      _setLoadingStatus(LoadingStatus.success);
    } catch (e) {
      _setError('Failed to refresh profile: ${e.toString()}');
      _setLoadingStatus(LoadingStatus.error);
    }
  }

  /// Clear user data
  void clearUser() {
    _user = null;
    _loadingStatus = LoadingStatus.initial;
    _clearError();
    notifyListeners();
  }

  // Private helpers
  void _setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
