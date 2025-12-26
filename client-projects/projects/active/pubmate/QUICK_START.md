# PubMate - Quick Start Guide

## 📦 What Has Been Created

### Project Structure
- ✅ **Full Flutter app boilerplate** with 99 Dart files
- ✅ **5 Custom Models** for core features
- ✅ **4 State Management Providers** for reactive UI
- ✅ **1 Geolocation Service** for location-based features
- ✅ **4 Complete UI Screens** with Material Design 3
- ✅ **Enhanced Configuration** with PubMate-specific strings

### Files Created

#### Models (5 files)
```
lib/models/
├── venue_model.dart           - Pub/venue information
├── event_model.dart           - Events at venues
├── friend_model.dart          - Social connections
├── review_model.dart          - Venue reviews
└── reward_model.dart          - Loyalty rewards
```

#### Providers (4 files)
```
lib/providers/
├── venue_provider.dart        - Venue discovery & search
├── event_provider.dart        - Event browsing & bookings
├── friend_provider.dart       - Social management
└── reward_provider.dart       - Loyalty system
```

#### Services (1 file)
```
lib/services/
└── geolocation_service.dart   - Location & permissions
```

#### Screens (4 files)
```
lib/screens/
├── discover/discover_screen.dart       - Find nearby pubs
├── events/events_screen.dart           - Browse & book events
├── friends/friends_screen.dart         - Manage friends
└── rewards/rewards_screen.dart         - View loyalty rewards
```

#### Documentation (2 files)
```
├── PUBMATE_IMPLEMENTATION.md   - Complete implementation guide
└── QUICK_START.md             - This file
```

## 🚀 Getting Started

### 1. Install Dependencies
```bash
cd client-projects/active/pubmate
flutter pub get
```

### 2. Generate Code (if needed)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### 3. Run the App
```bash
flutter run
```

### 4. Configure (Required Before Running)
- Add Google Maps API key to `ios/Runner/GoogleMaps.h` and `android/app/build.gradle`
- Update `.env.development` with your API base URL
- Configure location permissions in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist`

## 📋 Feature Overview

### 🗺️ Discover Screen
**File:** [discover_screen.dart](lib/screens/discover/discover_screen.dart)

Find nearby pubs with:
- Real-time search by name/address
- Distance-based filtering (0.5-20km)
- Category filtering
- Venue cards showing ratings, distance, and amenities
- Tap to view details

**Key Methods:**
```dart
VenueProvider.fetchNearbyVenues()  // Load by location
VenueProvider.searchVenues()       // Search venues
VenueProvider.addCategoryFilter()  // Filter by type
```

### 🎉 Events Screen
**File:** [events_screen.dart](lib/screens/events/events_screen.dart)

Discover and book events with:
- Nearby event discovery
- Event details with date/time
- Attendee count and capacity
- One-tap event booking
- Sold-out status handling

**Key Methods:**
```dart
EventProvider.fetchUpcomingEvents()  // Load nearby events
EventProvider.bookEvent()            // Book an event
EventProvider.cancelBooking()        // Cancel booking
```

### 👥 Friends Screen
**File:** [friends_screen.dart](lib/screens/friends/friends_screen.dart)

Manage social connections with:
- Friend list with online status
- Current venue display (when shared)
- Friend requests management
- Add friends by email
- Remove/unfriend functionality

**Key Methods:**
```dart
FriendProvider.fetchFriends()           // Load friends
FriendProvider.addFriend()              // Add friend
FriendProvider.removeFriend()           // Remove friend
FriendProvider.acceptFriendRequest()    // Accept request
```

### 🏆 Rewards Screen
**File:** [rewards_screen.dart](lib/screens/rewards/rewards_screen.dart)

Manage loyalty and rewards with:
- Points balance display
- Available rewards browsing
- One-tap redemption
- Redeemed history
- Points sufficiency checking

**Key Methods:**
```dart
RewardProvider.fetchAvailableRewards()  // Load rewards
RewardProvider.fetchUserPoints()        // Get points balance
RewardProvider.redeemReward()           // Redeem reward
```

### 📍 Geolocation Service
**File:** [geolocation_service.dart](lib/services/geolocation_service.dart)

Location functionality with:
- Permission handling
- Current location fetching
- Location stream monitoring
- Distance calculation
- Settings access

**Key Methods:**
```dart
GeolocationService.getCurrentLocation()      // Get current position
GeolocationService.watchLocation()           // Stream updates
GeolocationService.calculateDistance()       // Distance between points
GeolocationService.requestLocationPermission()  // Ask permission
```

## 🔄 State Management Pattern

All features use the **Provider pattern** with ChangeNotifier:

```dart
// Reading state
context.read<VenueProvider>().fetchNearbyVenues();

// Listening to changes
Consumer<VenueProvider>(
  builder: (context, venueProvider, child) {
    return ListView(
      children: venueProvider.venues.map((v) => Text(v.name)).toList(),
    );
  },
)

// Watching specific property
Selector<VenueProvider, List<VenueModel>>(
  selector: (_, provider) => provider.venues,
  builder: (_, venues, __) => Text('${venues.length} venues'),
)
```

## 📊 Data Models

### VenueModel
```dart
VenueModel(
  id: 'pub-001',
  name: 'The Red Lion',
  address: '123 Oxford Street',
  latitude: 51.515, longitude: -0.127,
  distance: 0.5, // km
  rating: 4.5,
  reviewCount: 234,
  categories: ['Pub', 'Bar'],
  amenities: ['WiFi', 'Outdoor Seating', 'Live Music'],
  priceRange: '£',
  isOpen: true,
  footTraffic: 45, // approx people
)
```

### EventModel
```dart
EventModel(
  id: 'event-001',
  title: 'Live Music Night',
  venueName: 'The Red Lion',
  startTime: DateTime.now().add(Duration(days: 3)),
  attendeeCount: 45,
  capacity: 100,
  category: 'Live Music',
  pricePerPerson: '£5',
  hasFood: true,
  hasLiveMusic: true,
  isBooked: false,
)
```

### FriendModel
```dart
FriendModel(
  id: 'user-001',
  name: 'John Doe',
  email: 'john@example.com',
  status: 'Active',
  lastKnownVenueName: 'The Red Lion',
  isOnline: true,
)
```

### RewardModel
```dart
RewardModel(
  id: 'reward-001',
  title: 'Free Pint',
  venueName: 'The Red Lion',
  pointsRequired: 100,
  rewardType: 'Drink',
  expiryDate: DateTime.now().add(Duration(days: 30)),
  isRedeemed: false,
)
```

## 🔗 Integration Points

### Models ↔ Providers
All providers use models and provide methods to manipulate them:
```dart
VenueProvider {
  List<VenueModel> get venues => _filteredVenues;
  VenueModel? get selectedVenue => _selectedVenue;
  selectVenue(VenueModel venue) => _selectedVenue = venue;
}
```

### Providers ↔ Screens
Screens consume providers and react to state changes:
```dart
Consumer<VenueProvider>(
  builder: (context, provider, _) {
    if (provider.status == LoadingStatus.loading) {
      return CircularProgressIndicator();
    }
    return ListView(children: provider.venues.map(...).toList());
  },
)
```

### Services ↔ Providers
Services handle business logic, providers manage state:
```dart
// In VenueProvider.fetchNearbyVenues()
Future<void> fetchNearbyVenues({required double latitude, required double longitude}) {
  try {
    _venues = await _venueService.getNearbyVenues(lat, lng);
    _status = LoadingStatus.loaded;
  } catch (e) {
    _errorMessage = e.toString();
    _status = LoadingStatus.error;
  }
  notifyListeners();
}
```

## 📱 Screen Navigation

Current screens are standalone. To integrate into main navigation:

1. **Update routes.dart:**
```dart
class Routes {
  static const String discover = '/discover';
  static const String events = '/events';
  static const String friends = '/friends';
  static const String rewards = '/rewards';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case discover:
        return MaterialPageRoute(builder: (_) => const DiscoverScreen());
      case events:
        return MaterialPageRoute(builder: (_) => const EventsScreen());
      // ... etc
    }
  }
}
```

2. **Add to providers (in app.dart):**
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => VenueProvider()),
    ChangeNotifierProvider(create: (_) => EventProvider()),
    ChangeNotifierProvider(create: (_) => FriendProvider()),
    ChangeNotifierProvider(create: (_) => RewardProvider()),
  ],
  child: MaterialApp(
    onGenerateRoute: Routes.generateRoute,
  ),
)
```

## 🚧 Next Steps

1. **API Integration** - Replace mock data with API calls
2. **Map Screen** - Implement Google Maps integration
3. **Detail Screens** - Create venue/event detail screens
4. **Testing** - Write unit and widget tests
5. **Polish** - Animations, transitions, error handling

See [PUBMATE_IMPLEMENTATION.md](PUBMATE_IMPLEMENTATION.md) for detailed roadmap.

## 🐛 Troubleshooting

### Location Permission Errors
```dart
// Check if location is enabled
final hasPermission = await GeolocationService().hasLocationPermission();

// Request manually if needed
await GeolocationService().requestLocationPermission();
```

### Provider State Not Updating
```dart
// Ensure notifyListeners() is called
class MyProvider extends ChangeNotifier {
  void updateState() {
    _state = newState;
    notifyListeners();  // ← Required
  }
}
```

### Screen Not Responding
Check that:
- Provider is wrapped in MultiProvider in app.dart
- Screen is consuming the correct provider
- LoadingStatus is handled (loading, loaded, error)

## 📚 Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter Docs](https://flutter.dev/docs)
- [Geolocator Package](https://pub.dev/packages/geolocator)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Material Design 3](https://m3.material.io/)

## 💡 Pro Tips

1. **Use Selector for Performance**
   ```dart
   Selector<VenueProvider, int>(
     selector: (_, provider) => provider.venues.length,
     builder: (_, count, __) => Text('$count venues'),
   )
   ```

2. **Handle Loading States**
   ```dart
   if (provider.status == LoadingStatus.loading) {
     return Center(child: CircularProgressIndicator());
   }
   ```

3. **Mock Data for Testing**
   All providers include mock data generation for testing before API integration.

4. **Location Permissions**
   Always check permissions before accessing location.

---

**Happy coding! 🚀**
