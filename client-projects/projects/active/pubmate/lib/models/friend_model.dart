class FriendModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String status;
  final DateTime addedDate;
  final double? lastKnownLatitude;
  final double? lastKnownLongitude;
  final String? lastKnownVenueName;
  final DateTime? lastLocationUpdate;
  final bool isOnline;

  FriendModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.status,
    required this.addedDate,
    this.lastKnownLatitude,
    this.lastKnownLongitude,
    this.lastKnownVenueName,
    this.lastLocationUpdate,
    required this.isOnline,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
      status: json['status'] as String,
      addedDate: DateTime.parse(json['addedDate'] as String),
      lastKnownLatitude: json['lastKnownLatitude'] as double?,
      lastKnownLongitude: json['lastKnownLongitude'] as double?,
      lastKnownVenueName: json['lastKnownVenueName'] as String?,
      lastLocationUpdate: json['lastLocationUpdate'] != null
          ? DateTime.parse(json['lastLocationUpdate'] as String)
          : null,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'status': status,
      'addedDate': addedDate.toIso8601String(),
      'lastKnownLatitude': lastKnownLatitude,
      'lastKnownLongitude': lastKnownLongitude,
      'lastKnownVenueName': lastKnownVenueName,
      'lastLocationUpdate': lastLocationUpdate?.toIso8601String(),
      'isOnline': isOnline,
    };
  }

  FriendModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? status,
    DateTime? addedDate,
    double? lastKnownLatitude,
    double? lastKnownLongitude,
    String? lastKnownVenueName,
    DateTime? lastLocationUpdate,
    bool? isOnline,
  }) {
    return FriendModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      addedDate: addedDate ?? this.addedDate,
      lastKnownLatitude: lastKnownLatitude ?? this.lastKnownLatitude,
      lastKnownLongitude: lastKnownLongitude ?? this.lastKnownLongitude,
      lastKnownVenueName: lastKnownVenueName ?? this.lastKnownVenueName,
      lastLocationUpdate: lastLocationUpdate ?? this.lastLocationUpdate,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
