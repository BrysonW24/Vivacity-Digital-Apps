import 'venue_feature_model.dart';

typedef VenueFeature = VenueFeatureModel;

class VenueModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double distance;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final String imageUrl;
  final List<String> amenities;
  final String phone;
  final String website;
  final String priceRange;
  final bool isOpen;
  final String openingHours;
  final int footTraffic;
  final List<VenueFeature> features; // NEW: Detailed features with pricing

  VenueModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.categories,
    required this.imageUrl,
    required this.amenities,
    required this.phone,
    required this.website,
    required this.priceRange,
    required this.isOpen,
    required this.openingHours,
    required this.footTraffic,
    this.features = const [], // NEW
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      categories: List<String>.from(json['categories'] as List),
      imageUrl: json['imageUrl'] as String,
      amenities: List<String>.from(json['amenities'] as List),
      phone: json['phone'] as String,
      website: json['website'] as String,
      priceRange: json['priceRange'] as String,
      isOpen: json['isOpen'] as bool,
      openingHours: json['openingHours'] as String,
      footTraffic: json['footTraffic'] as int,
      features: json['features'] != null
          ? (json['features'] as List)
              .map((f) => VenueFeature.fromJson(f as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'rating': rating,
      'reviewCount': reviewCount,
      'categories': categories,
      'imageUrl': imageUrl,
      'amenities': amenities,
      'phone': phone,
      'website': website,
      'priceRange': priceRange,
      'isOpen': isOpen,
      'openingHours': openingHours,
      'footTraffic': footTraffic,
      'features': features.map((f) => f.toJson()).toList(),
    };
  }

  VenueModel copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    double? distance,
    double? rating,
    int? reviewCount,
    List<String>? categories,
    String? imageUrl,
    List<String>? amenities,
    String? phone,
    String? website,
    String? priceRange,
    bool? isOpen,
    String? openingHours,
    int? footTraffic,
    List<VenueFeature>? features,
  }) {
    return VenueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      categories: categories ?? this.categories,
      imageUrl: imageUrl ?? this.imageUrl,
      amenities: amenities ?? this.amenities,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      priceRange: priceRange ?? this.priceRange,
      isOpen: isOpen ?? this.isOpen,
      openingHours: openingHours ?? this.openingHours,
      footTraffic: footTraffic ?? this.footTraffic,
      features: features ?? this.features,
    );
  }
}
