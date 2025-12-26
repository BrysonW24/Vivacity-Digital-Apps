import 'package:flutter/foundation.dart';
import '../models/friend_model.dart';
import '../enums/loading_status.dart';

class FriendProvider extends ChangeNotifier {
  List<FriendModel> _friends = [];
  List<FriendModel> _friendRequests = [];
  LoadingStatus _status = LoadingStatus.initial;
  String _errorMessage = '';

  List<FriendModel> get friends => _friends;
  List<FriendModel> get friendRequests => _friendRequests;
  LoadingStatus get status => _status;
  String get errorMessage => _errorMessage;

  // Fetch friends list
  Future<void> fetchFriends() async {
    _status = LoadingStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _friends = [
        FriendModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatarUrl: 'https://via.placeholder.com/100',
          status: 'Active',
          addedDate: DateTime.now().subtract(const Duration(days: 30)),
          lastKnownVenueName: 'The Red Lion',
          isOnline: true,
        ),
      ];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch friends: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Fetch friend requests
  Future<void> fetchFriendRequests() async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _friendRequests = [];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch friend requests: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Add friend
  Future<void> addFriend(String userId) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to add friend: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Remove friend
  Future<void> removeFriend(String friendId) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _friends.removeWhere((friend) => friend.id == friendId);
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to remove friend: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Accept friend request
  Future<void> acceptFriendRequest(String userId) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _friendRequests.removeWhere((request) => request.id == userId);
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to accept request: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Reject friend request
  Future<void> rejectFriendRequest(String userId) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _friendRequests.removeWhere((request) => request.id == userId);
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to reject request: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Get friend by ID
  FriendModel? getFriendById(String id) {
    try {
      return _friends.firstWhere((friend) => friend.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get online friends
  List<FriendModel> getOnlineFriends() {
    return _friends.where((friend) => friend.isOnline).toList();
  }

  // Update friend location
  void updateFriendLocation(
    String friendId,
    double latitude,
    double longitude,
    String? venueName,
  ) {
    final index = _friends.indexWhere((friend) => friend.id == friendId);
    if (index != -1) {
      _friends[index] = _friends[index].copyWith(
        lastKnownLatitude: latitude,
        lastKnownLongitude: longitude,
        lastKnownVenueName: venueName,
        lastLocationUpdate: DateTime.now(),
      );
      notifyListeners();
    }
  }
}
