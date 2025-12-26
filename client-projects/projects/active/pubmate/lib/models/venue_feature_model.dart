/// Represents a specific feature/amenity offered by a venue
/// Examples: Pool Table, Darts, Happy Hour, Sports Bar, WiFi, etc.
class VenueFeatureModel {
  final String id;
  final String venueId;
  final String featureName;
  final String category; // entertainment, dining, seating, tech, events, safety, etc.
  final bool isAvailable;
  final FeaturePricing? pricing;
  final String? details; // Additional notes
  final FeatureSchedule? schedule;
  final int? capacity; // For features with capacity (e.g., pool tables: 4 people)
  final List<String> tags;
  final String? imageUrl;

  VenueFeatureModel({
    required this.id,
    required this.venueId,
    required this.featureName,
    required this.category,
    required this.isAvailable,
    this.pricing,
    this.details,
    this.schedule,
    this.capacity,
    required this.tags,
    this.imageUrl,
  });

  factory VenueFeatureModel.fromJson(Map<String, dynamic> json) {
    return VenueFeatureModel(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      featureName: json['featureName'] as String,
      category: json['category'] as String,
      isAvailable: json['isAvailable'] as bool,
      pricing: json['pricing'] != null
          ? FeaturePricing.fromJson(json['pricing'] as Map<String, dynamic>)
          : null,
      details: json['details'] as String?,
      schedule: json['schedule'] != null
          ? FeatureSchedule.fromJson(json['schedule'] as Map<String, dynamic>)
          : null,
      capacity: json['capacity'] as int?,
      tags: List<String>.from(json['tags'] as List? ?? []),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'featureName': featureName,
      'category': category,
      'isAvailable': isAvailable,
      'pricing': pricing?.toJson(),
      'details': details,
      'schedule': schedule?.toJson(),
      'capacity': capacity,
      'tags': tags,
      'imageUrl': imageUrl,
    };
  }

  VenueFeatureModel copyWith({
    String? id,
    String? venueId,
    String? featureName,
    String? category,
    bool? isAvailable,
    FeaturePricing? pricing,
    String? details,
    FeatureSchedule? schedule,
    int? capacity,
    List<String>? tags,
    String? imageUrl,
  }) {
    return VenueFeatureModel(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      featureName: featureName ?? this.featureName,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      pricing: pricing ?? this.pricing,
      details: details ?? this.details,
      schedule: schedule ?? this.schedule,
      capacity: capacity ?? this.capacity,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

/// Pricing information for a feature
class FeaturePricing {
  final bool hasPricing;
  final double? price;
  final String priceUnit; // "per game", "per hour", "per item", "flat rate", etc.
  final String currency; // £, $, €, etc.
  final String? description; // e.g., "£2 per game or £5 per hour"

  FeaturePricing({
    required this.hasPricing,
    this.price,
    required this.priceUnit,
    required this.currency,
    this.description,
  });

  factory FeaturePricing.fromJson(Map<String, dynamic> json) {
    return FeaturePricing(
      hasPricing: json['hasPricing'] as bool,
      price: json['price'] as double?,
      priceUnit: json['priceUnit'] as String? ?? 'per item',
      currency: json['currency'] as String? ?? '£',
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasPricing': hasPricing,
      'price': price,
      'priceUnit': priceUnit,
      'currency': currency,
      'description': description,
    };
  }

  /// Get formatted price string
  String getFormattedPrice() {
    if (!hasPricing || price == null) return 'Free';
    return '$currency${price!.toStringAsFixed(2)} $priceUnit';
  }
}

/// Schedule information for a feature (when it's available)
class FeatureSchedule {
  final bool isAvailableDaily;
  final List<String> daysAvailable; // ['Mon', 'Tue', 'Wed', etc.] or empty if daily
  final String timeStart; // HH:MM format
  final String timeEnd; // HH:MM format
  final String? specialNotes; // e.g., "Hosted Dart League on Thursdays"

  FeatureSchedule({
    required this.isAvailableDaily,
    required this.daysAvailable,
    required this.timeStart,
    required this.timeEnd,
    this.specialNotes,
  });

  factory FeatureSchedule.fromJson(Map<String, dynamic> json) {
    return FeatureSchedule(
      isAvailableDaily: json['isAvailableDaily'] as bool? ?? false,
      daysAvailable: List<String>.from(json['daysAvailable'] as List? ?? []),
      timeStart: json['timeStart'] as String,
      timeEnd: json['timeEnd'] as String,
      specialNotes: json['specialNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAvailableDaily': isAvailableDaily,
      'daysAvailable': daysAvailable,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'specialNotes': specialNotes,
    };
  }

  /// Check if feature is available right now
  bool isAvailableNow() {
    final now = DateTime.now();
    final dayName = _getDayName(now.weekday);

    if (!isAvailableDaily && !daysAvailable.contains(dayName)) {
      return false;
    }

    final currentTime = _timeStringToMinutes(
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
    );
    final startMinutes = _timeStringToMinutes(timeStart);
    final endMinutes = _timeStringToMinutes(timeEnd);

    return currentTime >= startMinutes && currentTime <= endMinutes;
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

  String getScheduleDisplay() {
    if (isAvailableDaily) {
      return 'Daily, $timeStart - $timeEnd';
    }
    return '${daysAvailable.join(', ')}, $timeStart - $timeEnd';
  }
}

/// Feature categories - constants for consistency
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

  static const List<String> all = [
    entertainment,
    dining,
    seating,
    technology,
    events,
    safety,
    accessibility,
    specialOffers,
    parking,
  ];
}

/// Common features - constants for consistency
class CommonFeatures {
  // Entertainment & Games
  static const String poolTable = 'Pool Table';
  static const String darts = 'Darts';
  static const String sportsBar = 'Sports Bar';
  static const String karaoke = 'Karaoke';
  static const String triviaQuiz = 'Trivia/Quiz Night';
  static const String boardGames = 'Board Games';
  static const String tableFootball = 'Table Football/Foosball';
  static const String dartLeague = 'Dart League';

  // Entertainment & Events
  static const String liveMusic = 'Live Music';
  static const String liveJazz = 'Live Jazz';
  static const String liveBands = 'Live Bands';
  static const String djMusic = 'DJ/Music';
  static const String comedyNights = 'Comedy Nights';
  static const String openMic = 'Open Mic Nights';
  static const String privateFunction = 'Private Function Room';

  // Dining & Beverage
  static const String foodService = 'Food Service';
  static const String happyHour = 'Happy Hour';
  static const String craftBeer = 'Craft Beer';
  static const String cocktails = 'Cocktails';
  static const String sundayRoast = 'Sunday Roast';

  // Atmosphere & Seating
  static const String outdoorSeating = 'Outdoor Seating';
  static const String garden = 'Garden/Terrace';
  static const String rooftop = 'Rooftop Area';
  static const String familyFriendly = 'Family-Friendly';
  static const String petFriendly = 'Pet-Friendly';

  // Technology
  static const String freeWifi = 'Free WiFi';
  static const String chargingStations = 'Charging Stations';
  static const String liveStreaming = 'Live Sports Streaming';

  // Parking & Access
  static const String parkingAvailable = 'Parking Available';
  static const String wheelchairAccessible = 'Wheelchair Accessible';

  // Special
  static const String lateeLicense = 'Late License';
  static const String studentDiscount = 'Student Discount';
}
