import 'package:flutter/foundation.dart';
import '../models/venue_model.dart';
import '../enums/loading_status.dart';

class VenueProvider extends ChangeNotifier {
  List<VenueModel> _venues = [];
  List<VenueModel> _filteredVenues = [];
  VenueModel? _selectedVenue;
  LoadingStatus _status = LoadingStatus.initial;
  String _errorMessage = '';

  // Search and filter state
  String _searchQuery = '';
  List<String> _selectedCategories = [];
  double _maxDistance = 5.0; // km

  List<VenueModel> get venues => _filteredVenues.isEmpty ? _venues : _filteredVenues;
  List<VenueModel> get allVenues => _venues;
  VenueModel? get selectedVenue => _selectedVenue;
  LoadingStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  List<String> get selectedCategories => _selectedCategories;
  double get maxDistance => _maxDistance;

  // Fetch nearby venues based on location
  Future<void> fetchNearbyVenues({
    required double latitude,
    required double longitude,
  }) async {
    _status = LoadingStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // This is mock data for now
      _venues = [
        VenueModel(
          id: '1',
          name: 'The Red Lion',
          description: 'Historic pub with great atmosphere',
          address: '123 Oxford Street, London',
          latitude: latitude + 0.001,
          longitude: longitude + 0.001,
          distance: 0.5,
          rating: 4.5,
          reviewCount: 234,
          categories: ['Pub', 'Bar'],
          imageUrl: 'https://via.placeholder.com/300x200',
          amenities: ['WiFi', 'Outdoor Seating', 'Live Music'],
          phone: '+44 123 456 7890',
          website: 'https://example.com',
          priceRange: '£',
          isOpen: true,
          openingHours: '12:00 - 23:00',
          footTraffic: 45,
        ),
      ];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch venues: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Select a venue
  void selectVenue(VenueModel venue) {
    _selectedVenue = venue;
    notifyListeners();
  }

  // Clear selected venue
  void clearSelectedVenue() {
    _selectedVenue = null;
    notifyListeners();
  }

  // Search venues
  void searchVenues(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  // Add category filter
  void addCategoryFilter(String category) {
    if (!_selectedCategories.contains(category)) {
      _selectedCategories.add(category);
      _applyFilters();
    }
  }

  // Remove category filter
  void removeCategoryFilter(String category) {
    _selectedCategories.remove(category);
    _applyFilters();
  }

  // Clear category filters
  void clearCategoryFilters() {
    _selectedCategories.clear();
    _applyFilters();
  }

  // Set distance filter
  void setDistanceFilter(double distance) {
    _maxDistance = distance;
    _applyFilters();
  }

  // Apply all filters and search
  void _applyFilters() {
    _filteredVenues = _venues.where((venue) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        if (!venue.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !venue.address.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategories.isNotEmpty) {
        if (!venue.categories.any((cat) => _selectedCategories.contains(cat))) {
          return false;
        }
      }

      // Distance filter
      if (venue.distance > _maxDistance) {
        return false;
      }

      return true;
    }).toList();

    // Sort by distance
    _filteredVenues.sort((a, b) => a.distance.compareTo(b.distance));
    notifyListeners();
  }

  // Reset all filters
  void resetFilters() {
    _searchQuery = '';
    _selectedCategories.clear();
    _maxDistance = 5.0;
    _filteredVenues = [];
    notifyListeners();
  }
}
