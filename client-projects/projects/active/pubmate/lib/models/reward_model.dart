class RewardModel {
  final String id;
  final String venueId;
  final String venueName;
  final String title;
  final String description;
  final int pointsRequired;
  final String rewardType;
  final String imageUrl;
  final DateTime expiryDate;
  final bool isRedeemed;

  RewardModel({
    required this.id,
    required this.venueId,
    required this.venueName,
    required this.title,
    required this.description,
    required this.pointsRequired,
    required this.rewardType,
    required this.imageUrl,
    required this.expiryDate,
    required this.isRedeemed,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      venueName: json['venueName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      pointsRequired: json['pointsRequired'] as int,
      rewardType: json['rewardType'] as String,
      imageUrl: json['imageUrl'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      isRedeemed: json['isRedeemed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'venueName': venueName,
      'title': title,
      'description': description,
      'pointsRequired': pointsRequired,
      'rewardType': rewardType,
      'imageUrl': imageUrl,
      'expiryDate': expiryDate.toIso8601String(),
      'isRedeemed': isRedeemed,
    };
  }

  RewardModel copyWith({
    String? id,
    String? venueId,
    String? venueName,
    String? title,
    String? description,
    int? pointsRequired,
    String? rewardType,
    String? imageUrl,
    DateTime? expiryDate,
    bool? isRedeemed,
  }) {
    return RewardModel(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      venueName: venueName ?? this.venueName,
      title: title ?? this.title,
      description: description ?? this.description,
      pointsRequired: pointsRequired ?? this.pointsRequired,
      rewardType: rewardType ?? this.rewardType,
      imageUrl: imageUrl ?? this.imageUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      isRedeemed: isRedeemed ?? this.isRedeemed,
    );
  }

  bool get isExpired => expiryDate.isBefore(DateTime.now());
}
