# PubMate - Venue Features & Pricing System

## Overview

The features and pricing system is a critical differentiator for PubMate. It allows venues to showcase what makes them unique and helps users discover exactly what they're looking for.

---

## Data Models

### VenueFeatureModel

Represents a specific feature or amenity offered by a venue with optional pricing and scheduling.

```dart
class VenueFeatureModel {
  final String id;                    // Unique feature ID
  final String venueId;               // Venue this belongs to
  final String featureName;           // Display name (e.g., "Pool Table", "Happy Hour")
  final String category;              // Category for organization
  final bool isAvailable;             // Currently available?
  final FeaturePricing? pricing;      // Pricing information (optional)
  final String? details;              // Additional description
  final FeatureSchedule? schedule;    // When available (optional)
  final int? capacity;                // Capacity if applicable (e.g., pool table: 4 people)
  final List<String> tags;            // Searchable keywords
  final String? imageUrl;             // Feature image/icon
}
```

### FeaturePricing

Contains pricing information for a feature.

```dart
class FeaturePricing {
  final bool hasPricing;              // Does this feature have a cost?
  final double? price;                // Price amount
  final String priceUnit;             // "per game", "per hour", "per item", etc.
  final String currency;              // £, $, €, etc.
  final String? description;          // e.g., "£2 per game or £5 per hour"

  // Example usage:
  // Pool Table: price=2.0, priceUnit="per game", currency="£"
  // Happy Hour: price=0, hasPricing=true, priceUnit="select drinks"
  // Darts: price=1.0, priceUnit="per game", currency="£"
}
```

### FeatureSchedule

Contains schedule information for when a feature is available.

```dart
class FeatureSchedule {
  final bool isAvailableDaily;        // Available every day?
  final List<String> daysAvailable;   // ["Mon", "Tue", ...] or empty if daily
  final String timeStart;             // "09:00" format
  final String timeEnd;               // "23:00" format
  final String? specialNotes;         // "Hosted Dart League on Thursdays"

  // Methods:
  bool isAvailableNow()               // Check if available right now
  String getScheduleDisplay()         // "Daily, 09:00 - 23:00"
}
```

### FeatureCategory

Constants for feature categories to ensure consistency.

```dart
class FeatureCategory {
  static const String entertainment = 'entertainment';
  static const String dining = 'dining';
  static const String seating = 'seating';
  static const String technology = 'technology';
  static const String events = 'events';
  static const String safety = 'safety';
  static const String accessibility = 'accessibility';
  static const String specialOffers = 'specialOffers';
  static const String parking = 'parking';
}
```

### CommonFeatures

Pre-defined feature constants for common amenities.

```dart
class CommonFeatures {
  // Entertainment & Games
  static const String poolTable = 'Pool Table';
  static const String darts = 'Darts';
  static const String sportsBar = 'Sports Bar';
  static const String karaoke = 'Karaoke';
  static const String triviaQuiz = 'Trivia/Quiz Night';
  static const String boardGames = 'Board Games';
  // ... and many more
}
```

---

## Feature Categories

### 1. Entertainment & Games
- **Sports Bar** - Multi-screen, live matches
- **Pool Table** - With pricing (£1-3 per game, £5-10 per hour)
- **Darts Board** - With pricing (£0.50-2 per game), League nights
- **Table Football/Foosball** - With pricing model
- **Trivia/Quiz Nights** - Schedule and frequency
- **Karaoke** - Nights available, pricing
- **Jukebox** - Free, subscription, or paid
- **Gaming/Arcade Machines**
- **Board Games Available**
- **Ping Pong Table**
- **Shuffleboard**

### 2. Entertainment & Events
- **Live Music** - Specific genres (rock, jazz, acoustic, cover bands)
- **Live DJ** - Specific nights
- **Comedy Nights** - Schedule and capacity
- **Open Mic Nights** - When hosted
- **Movie Screenings** - Schedule
- **Special Event Capacity** - How many people for events
- **Outdoor Event Space** - For special events
- **Private Event/Function Room** - Capacity and pricing (£50-200+ per hour)
- **Happy Hour** - Times and specific deals

### 3. Dining & Beverage
- **Food Service** - Full menu, snacks, bar bites
- **Specific Cuisine Type** - If applicable
- **Happy Hour** - Times and what's included (30-60% discount)
- **Cocktail Specialties** - Craft cocktail menu
- **Craft Beer Selection** - Types available
- **Wine Selection** - By glass/bottle
- **Spirits Range** - Premium vs. standard
- **Cider Selection**
- **Non-Alcoholic Options** - Soft drinks, mocktails
- **Food Delivery Options** - UberEats, Deliveroo, etc.
- **Sunday Roast** - Day/time
- **Burger Night** - Specific nights with pricing

### 4. Atmosphere & Seating
- **Outdoor Seating/Patio** - How many covers
- **Garden/Terrace** - Size and season availability
- **Rooftop Area** - Views, capacity
- **Heated Outdoor Area** - Patio heaters, blankets
- **Covered Smoking Area** - Seating capacity
- **Family-Friendly** - Kids menu, high chairs
- **Pet-Friendly** - Specific details (outside only, breed restrictions)
- **Quiet Area Available** - For conversation/work
- **Large Groups Welcome** - Group size limits

### 5. Technology & Connectivity
- **Free WiFi** - Speed details optional
- **Charging Stations** - USB, wireless capabilities
- **Live Sports Streaming** - Specific sports (football, rugby, boxing)
- **Table Service/App Ordering** - Mobile ordering capability
- **Card/Cashless Only** - Or notes about payment methods

### 6. Accessibility & Comfort
- **Parking Available** - Type (street, lot, valet), free/paid, spaces count
- **Public Transport Nearby** - Closest stations
- **Disabled Access** - Full wheelchair access
- **Accessible Toilets** - On ground floor, spacious
- **Gender-Neutral Toilets** - Available
- **High Chair Available** - How many
- **Baby Changing** - Location (toilet, dedicated room)
- **Air Conditioning** - Essential in summer
- **Heating System** - Type (radiators, underfloor, etc.)
- **Music Volume Level** - Quiet, moderate, loud

### 7. Safety & Experience
- **Security** - CCTV, door staff, security team
- **ID Policy** - Strict (ID always), standard (looks under 25), relaxed
- **Dress Code** - Smart casual, casual, formal, none
- **Age Restriction** - 18+, 21+, family hours
- **Late License** - Closing time, after-hours capability
- **First Aid Available** - AED, trained staff
- **Staff Training** - Safeguarding, LGBTQ+ friendly, etc.

### 8. Special Offers & Programs
- **Happy Hour Times & Deals** - Specific time windows and discounts
- **Ladies Night** - Specific nights/details
- **Student Discount** - Percentage off
- **Loyalty Program** - Points system, membership tiers
- **Referral Rewards** - Incentives for bringing friends
- **Group Booking Discounts** - For parties 10+
- **Birthday Party Packages** - Pricing, inclusions
- **Private Event Options** - Room hire, catering

---

## Feature Pricing Examples

### Pool Table
```
Price: £2.00
Unit: per game
Alternative: £5.00 per hour
Best for: Casual players, tournaments
```

### Darts
```
Price: £1.00
Unit: per game
League: Hosted Thursday nights, membership £5/week
Best for: Competition, league play
```

### Private Function Room
```
Price: £100-200+
Unit: per hour
Min Spend: £500
Capacity: 50-200 people
Included: Tables, chairs, sound system
Catering: In-house or external
```

### Karaoke
```
Price: £3.00
Unit: per song
OR £50.00 per hour for private room
Days: Thursday-Saturday
```

### Happy Hour
```
Times: 17:00-19:00 (5pm-7pm)
Included: Select beers £2.50 (normally £5.50)
          Select spirits £2.50
          House wine £4.50
```

---

## Feature-Based Bar Types

### Traditional Pub
**Signature Features:**
- Quiz Nights ✓
- Darts ✓
- Real Ale Selection ✓
- Fireplace/Cozy Atmosphere ✓
- Board Games ✓
- Sunday Roast ✓
- Car Parking ✓
- Traditional Food Menu

**Example Features Array:**
```dart
[
  VenueFeatureModel(
    featureName: 'Quiz Night',
    category: FeatureCategory.entertainment,
    schedule: FeatureSchedule(
      isAvailableDaily: false,
      daysAvailable: ['Thu'],
      timeStart: '19:30',
      timeEnd: '21:30',
    ),
    tags: ['trivia', 'free', 'team-based'],
  ),
  VenueFeatureModel(
    featureName: 'Darts',
    category: FeatureCategory.entertainment,
    pricing: FeaturePricing(
      hasPricing: true,
      price: 1.0,
      priceUnit: 'per game',
      currency: '£',
    ),
    schedule: FeatureSchedule(isAvailableDaily: true),
    tags: ['games', 'league'],
  ),
  // ... more features
]
```

### Sports Bar
**Signature Features:**
- Multi-Screen Sports ✓
- Pool Tables ✓
- Darts ✓
- Large Groups Welcome ✓
- Loud Music/Atmosphere ✓
- Late License ✓
- Standing Room ✓
- Food Menu

### Cocktail Bar
**Signature Features:**
- Craft Cocktails ✓
- Lounge Seating ✓
- DJ/Music ✓
- Smart Casual Dress Code ✓
- Premium Spirits ✓
- Happy Hour ✓
- Upscale Vibe ✓

### Casual Bar
**Signature Features:**
- Happy Hour ✓
- Pool/Darts ✓
- Food Menu ✓
- Free WiFi ✓
- Varied Music ✓
- Mixed Age Groups ✓
- Family Areas ✓

### Club/Nightclub
**Signature Features:**
- DJ/Dancing ✓
- Late License ✓
- Loud Music ✓
- Door Staff ✓
- VIP Areas ✓
- Premium Pricing ✓
- Age Restrictions ✓

---

## UI/UX Implementation

### Venue Card Display (List View)
Show top 3-5 most distinctive features:
```
🎱 Pool Tables · 🎯 Darts · 📺 Sports TV

⭐ 4.5 (234 reviews) · 0.5 km away · Happy Hour Now
```

### Venue Detail Screen
Organize features by category with tabs:
- **Entertainment** - Pool, Darts, Karaoke, etc.
- **Dining** - Food, Happy Hour, Specialties
- **Atmosphere** - Seating, Parking, Accessibility
- **Technology** - WiFi, Streaming, Charging
- **Events** - Private rooms, event capacity

Each feature card shows:
- Feature icon and name
- Availability status (Available/Not available/Seasonal)
- Pricing (if applicable)
- Schedule (if time-specific)
- Description and photos
- User reviews specific to that feature

### Search & Filter
```
Filters:
□ Pool Tables
□ Darts
□ Happy Hour
□ Sports Bar
□ Food Service
□ Outdoor Seating
□ Pet Friendly
□ Free WiFi
□ Private Room

Search: "Sports bar with pool near me"
Results: 12 venues matching criteria
```

### Feature Discovery
**"I'm looking for..."** filters:
- "A quiet place to work" → WiFi, Quiet Area, Electrical Outlets
- "Group night out" → Large Groups, Food, Private Room, Parking
- "Date night" → Cocktails, Lounge, DJ, Upscale
- "Sports watching" → Multi-screen, Food, Alcohol, Late License
- "Pub games" → Pool, Darts, Trivia, Board Games

---

## Implementation Checklist

### Data Model Layer ✅
- [x] VenueFeatureModel created
- [x] FeaturePricing created
- [x] FeatureSchedule created
- [x] FeatureCategory constants created
- [x] CommonFeatures constants created
- [x] VenueModel updated to include features

### Provider Layer 🚧
- [ ] Update VenueProvider to handle feature filtering
- [ ] Add feature-based search methods
- [ ] Implement feature availability checking
- [ ] Add feature recommendation logic

### UI Layer 🚧
- [ ] Create VenueFeatureCard widget
- [ ] Add feature display to DiscoverScreen
- [ ] Create feature filters UI
- [ ] Build VenueDetailScreen with feature tabs
- [ ] Add pricing display with formatting
- [ ] Show schedule availability

### API Integration 🚧
- [ ] Create FeatureRepository
- [ ] Add API endpoints for features
- [ ] Implement feature search backend
- [ ] Add pricing management endpoints

### Testing 🚧
- [ ] Unit tests for feature models
- [ ] Schedule availability tests
- [ ] Filter logic tests
- [ ] Widget tests for feature displays

---

## Example JSON Structure

### API Response - Venue with Features

```json
{
  "id": "pub-001",
  "name": "The Red Lion",
  "description": "Historic pub with great atmosphere",
  "address": "123 Oxford Street, London",
  "latitude": 51.515,
  "longitude": -0.127,
  "rating": 4.5,
  "reviewCount": 234,
  "categories": ["Pub", "Bar"],
  "priceRange": "£",
  "isOpen": true,
  "openingHours": "12:00 - 23:00",
  "footTraffic": 45,
  "features": [
    {
      "id": "feat-001",
      "featureName": "Pool Table",
      "category": "entertainment",
      "isAvailable": true,
      "pricing": {
        "hasPricing": true,
        "price": 2.0,
        "priceUnit": "per game",
        "currency": "£",
        "description": "£2 per game or £5 per hour"
      },
      "capacity": 4,
      "tags": ["games", "billiards", "casual"]
    },
    {
      "id": "feat-002",
      "featureName": "Darts",
      "category": "entertainment",
      "isAvailable": true,
      "pricing": {
        "hasPricing": true,
        "price": 1.0,
        "priceUnit": "per game",
        "currency": "£"
      },
      "details": "League play hosted Thursdays",
      "schedule": {
        "isAvailableDaily": true,
        "daysAvailable": [],
        "timeStart": "18:00",
        "timeEnd": "23:00"
      },
      "tags": ["games", "competitive", "league"]
    },
    {
      "id": "feat-003",
      "featureName": "Happy Hour",
      "category": "dining",
      "isAvailable": true,
      "details": "50% off select beers and spirits",
      "schedule": {
        "isAvailableDaily": true,
        "daysAvailable": [],
        "timeStart": "17:00",
        "timeEnd": "19:00"
      },
      "tags": ["drinks", "discounts", "dailyoffer"]
    },
    {
      "id": "feat-004",
      "featureName": "Private Function Room",
      "category": "events",
      "isAvailable": true,
      "pricing": {
        "hasPricing": true,
        "price": 150.0,
        "priceUnit": "per hour",
        "currency": "£",
        "description": "Min spend £500, max capacity 100 people"
      },
      "capacity": 100,
      "details": "Tables, chairs, and sound system included",
      "tags": ["events", "parties", "bookings"]
    }
  ]
}
```

---

## Best Practices

1. **Always validate pricing** - Ensure prices are reasonable for the category
2. **Update schedules regularly** - Happy hour times change seasonally
3. **Use tags for search** - Make features discoverable through keywords
4. **Include images** - Visual features are more appealing
5. **Gather user feedback** - Track which features drive bookings
6. **Highlight unique features** - Show what makes each venue different
7. **Keep pricing competitive** - Monitor comparable venues

---

## Future Enhancements

1. **AI-Powered Recommendations** - "Based on your interests, you'd love this bar"
2. **Feature Availability API** - Real-time availability checks
3. **Review by Feature** - Allow users to review specific features (not just venue)
4. **Feature Photos** - Photo galleries per feature
5. **Dynamic Pricing** - Surge pricing during peak hours
6. **Venue Packages** - Bundle features at discounted rates
7. **Feature Comparisons** - "Compare 3 sports bars near you"

---

**Last Updated:** December 2025
**Status:** MVP Ready
**Files:**
- `venue_feature_model.dart` - Feature data models
- `venue_model.dart` - Updated to include features
- `PUBMATE_LLM_BRIEF.md` - Comprehensive feature section
