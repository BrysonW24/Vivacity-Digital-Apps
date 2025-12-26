import 'package:flutter/foundation.dart';
import '../models/reward_model.dart';
import '../enums/loading_status.dart';

class RewardProvider extends ChangeNotifier {
  List<RewardModel> _availableRewards = [];
  List<RewardModel> _redeemedRewards = [];
  int _totalPoints = 0;
  LoadingStatus _status = LoadingStatus.initial;
  String _errorMessage = '';

  List<RewardModel> get availableRewards => _availableRewards;
  List<RewardModel> get redeemedRewards => _redeemedRewards;
  int get totalPoints => _totalPoints;
  LoadingStatus get status => _status;
  String get errorMessage => _errorMessage;

  // Fetch available rewards
  Future<void> fetchAvailableRewards() async {
    _status = LoadingStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _availableRewards = [
        RewardModel(
          id: '1',
          venueId: '1',
          venueName: 'The Red Lion',
          title: 'Free Pint',
          description: 'Redeem for a complimentary pint of your choice',
          pointsRequired: 100,
          rewardType: 'Drink',
          imageUrl: 'https://via.placeholder.com/300x200',
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          isRedeemed: false,
        ),
      ];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch rewards: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Fetch redeemed rewards
  Future<void> fetchRedeemedRewards() async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _redeemedRewards = [];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch redeemed rewards: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Fetch user's points
  Future<void> fetchUserPoints() async {
    try {
      // TODO: Replace with actual API call
      _totalPoints = 250;
    } catch (e) {
      _errorMessage = 'Failed to fetch points: ${e.toString()}';
    }
    notifyListeners();
  }

  // Redeem reward
  Future<void> redeemReward(RewardModel reward) async {
    if (_totalPoints < reward.pointsRequired) {
      _errorMessage = 'Insufficient points to redeem this reward';
      notifyListeners();
      return;
    }

    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _totalPoints -= reward.pointsRequired;
      _availableRewards.removeWhere((r) => r.id == reward.id);
      _redeemedRewards.add(reward.copyWith(isRedeemed: true));
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to redeem reward: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Add points
  void addPoints(int points) {
    _totalPoints += points;
    notifyListeners();
  }

  // Get rewards by venue
  List<RewardModel> getRewardsByVenue(String venueId) {
    return _availableRewards.where((reward) => reward.venueId == venueId).toList();
  }

  // Get available points for reward
  List<RewardModel> getRewardsAffordableWithCurrentPoints() {
    return _availableRewards.where((reward) => reward.pointsRequired <= _totalPoints).toList();
  }

  // Get expiring soon rewards
  List<RewardModel> getExpiringSoonRewards({int daysThreshold = 7}) {
    final threshold = DateTime.now().add(Duration(days: daysThreshold));
    return _availableRewards
        .where((reward) => reward.expiryDate.isBefore(threshold) && !reward.isExpired)
        .toList();
  }
}
