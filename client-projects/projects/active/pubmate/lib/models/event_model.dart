class EventModel {
  final String id;
  final String venueId;
  final String venueName;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String category;
  final String imageUrl;
  final int attendeeCount;
  final int capacity;
  final bool isBooked;
  final List<String> tags;
  final String pricePerPerson;
  final bool hasFood;
  final bool hasLiveMusic;

  EventModel({
    required this.id,
    required this.venueId,
    required this.venueName,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.imageUrl,
    required this.attendeeCount,
    required this.capacity,
    required this.isBooked,
    required this.tags,
    required this.pricePerPerson,
    required this.hasFood,
    required this.hasLiveMusic,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      venueName: json['venueName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      attendeeCount: json['attendeeCount'] as int,
      capacity: json['capacity'] as int,
      isBooked: json['isBooked'] as bool,
      tags: List<String>.from(json['tags'] as List),
      pricePerPerson: json['pricePerPerson'] as String,
      hasFood: json['hasFood'] as bool,
      hasLiveMusic: json['hasLiveMusic'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'venueName': venueName,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'category': category,
      'imageUrl': imageUrl,
      'attendeeCount': attendeeCount,
      'capacity': capacity,
      'isBooked': isBooked,
      'tags': tags,
      'pricePerPerson': pricePerPerson,
      'hasFood': hasFood,
      'hasLiveMusic': hasLiveMusic,
    };
  }

  EventModel copyWith({
    String? id,
    String? venueId,
    String? venueName,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? category,
    String? imageUrl,
    int? attendeeCount,
    int? capacity,
    bool? isBooked,
    List<String>? tags,
    String? pricePerPerson,
    bool? hasFood,
    bool? hasLiveMusic,
  }) {
    return EventModel(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      venueName: venueName ?? this.venueName,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      capacity: capacity ?? this.capacity,
      isBooked: isBooked ?? this.isBooked,
      tags: tags ?? this.tags,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      hasFood: hasFood ?? this.hasFood,
      hasLiveMusic: hasLiveMusic ?? this.hasLiveMusic,
    );
  }

  bool get isSoldOut => attendeeCount >= capacity;
  bool get isUpcoming => startTime.isAfter(DateTime.now());
  bool get isOngoing => !isUpcoming && endTime.isAfter(DateTime.now());
}
