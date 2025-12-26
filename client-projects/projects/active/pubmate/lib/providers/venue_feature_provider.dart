import 'package:flutter/foundation.dart';
import '../models/venue_feature_model.dart';
import '../enums/loading_status.dart';

class VenueFeatureProvider extends ChangeNotifier {
  List<String> _selectedFeatures = [];
  List<String> _selectedCategories = [];
  LoadingStatus _status = LoadingStatus.initial;
  String _errorMessage = '';

  List<String> get selectedFeatures => _selectedFeatures;
  List<String> get selectedCategories => _selectedCategories;
  LoadingStatus get status => _status;
  String get errorMessage => _errorMessage;

  /// Toggle feature selection
  void toggleFeature(String featureName) {
    if (_selectedFeatures.contains(featureName)) {
      _selectedFeatures.remove(featureName);
    } else {
      _selectedFeatures.add(featureName);
    }
    notifyListeners();
  }

  /// Select multiple features at once
  void selectFeatures(List<String> features) {
    _selectedFeatures = features;
    notifyListeners();
  }

  /// Clear all feature selections
  void clearFeatureSelections() {
    _selectedFeatures.clear();
    notifyListeners();
  }

  /// Toggle category selection
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  /// Select multiple categories at once
  void selectCategories(List<String> categories) {
    _selectedCategories = categories;
    notifyListeners();
  }

  /// Clear all category selections
  void clearCategorySelections() {
    _selectedCategories.clear();
    notifyListeners();
  }

  /// Clear all filters
  void clearAllFilters() {
    _selectedFeatures.clear();
    _selectedCategories.clear();
    notifyListeners();
  }

  /// Check if a venue has all selected features
  bool venueHasSelectedFeatures(List<VenueFeatureModel> venueFeatures) {
    if (_selectedFeatures.isEmpty) return true;

    return _selectedFeatures.every((selectedFeature) {
      return venueFeatures.any((venueFeature) =>
          venueFeature.featureName == selectedFeature &&
          venueFeature.isAvailable);
    });
  }

  /// Check if a venue has any selected categories
  bool venueHasSelectedCategories(List<VenueFeatureModel> venueFeatures) {
    if (_selectedCategories.isEmpty) return true;

    return _selectedCategories.any((selectedCategory) {
      return venueFeatures.any((venueFeature) =>
          venueFeature.category == selectedCategory &&
          venueFeature.isAvailable);
    });
  }

  /// Get features by category
  List<VenueFeatureModel> getFeaturesByCategory(
    List<VenueFeatureModel> venueFeatures,
    String category,
  ) {
    return venueFeatures
        .where((f) => f.category == category && f.isAvailable)
        .toList();
  }

  /// Get currently available features (checking schedule)
  List<VenueFeatureModel> getAvailableNowFeatures(
    List<VenueFeatureModel> venueFeatures,
  ) {
    return venueFeatures.where((feature) {
      if (!feature.isAvailable) return false;
      if (feature.schedule == null) return true;
      return feature.schedule!.isAvailableNow();
    }).toList();
  }

  /// Get most distinctive/popular features for quick display
  List<VenueFeatureModel> getTopFeatures(
    List<VenueFeatureModel> venueFeatures, {
    int limit = 5,
  }) {
    // Prioritize: entertainment > events > dining > tech > others
    final priorityMap = {
      FeatureCategory.entertainment: 5,
      FeatureCategory.events: 4,
      FeatureCategory.dining: 3,
      FeatureCategory.technology: 2,
      FeatureCategory.accessibility: 1,
    };

    final sorted = venueFeatures.where((f) => f.isAvailable).toList()
      ..sort((a, b) {
        final aPriority = priorityMap[a.category] ?? 0;
        final bPriority = priorityMap[b.category] ?? 0;
        return bPriority.compareTo(aPriority);
      });

    return sorted.take(limit).toList();
  }

  /// Search features by tag or name
  List<VenueFeatureModel> searchFeatures(
    List<VenueFeatureModel> venueFeatures,
    String query,
  ) {
    if (query.isEmpty) return venueFeatures;

    final lowerQuery = query.toLowerCase();
    return venueFeatures
        .where((feature) =>
            feature.featureName.toLowerCase().contains(lowerQuery) ||
            feature.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)) ||
            (feature.details?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  /// Filter features available at specific time
  List<VenueFeatureModel> getFeaturesAvailableAt(
    List<VenueFeatureModel> venueFeatures,
    DateTime dateTime,
  ) {
    return venueFeatures.where((feature) {
      if (!feature.isAvailable) return false;
      if (feature.schedule == null) return true;

      final schedule = feature.schedule!;
      final dayName = _getDayName(dateTime.weekday);

      if (!schedule.isAvailableDaily &&
          !schedule.daysAvailable.contains(dayName)) {
        return false;
      }

      final currentTime = _timeStringToMinutes(
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
      );
      final startMinutes = _timeStringToMinutes(schedule.timeStart);
      final endMinutes = _timeStringToMinutes(schedule.timeEnd);

      return currentTime >= startMinutes && currentTime <= endMinutes;
    }).toList();
  }

  /// Get features with pricing information
  List<VenueFeatureModel> getFeaturesWithPricing(
    List<VenueFeatureModel> venueFeatures,
  ) {
    return venueFeatures
        .where((f) => f.pricing != null && f.pricing!.hasPricing)
        .toList();
  }

  /// Get free features
  List<VenueFeatureModel> getFreeFeatures(
    List<VenueFeatureModel> venueFeatures,
  ) {
    return venueFeatures
        .where((f) =>
            f.pricing == null ||
            !f.pricing!.hasPricing ||
            (f.pricing!.price == 0 || f.pricing!.price == null))
        .toList();
  }

  static String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  static int _timeStringToMinutes(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return hours * 60 + minutes;
  }
}
