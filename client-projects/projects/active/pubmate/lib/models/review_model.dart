class ReviewModel {
  final String id;
  final String venueId;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final double rating;
  final String comment;
  final DateTime createdDate;
  final List<String> photos;

  ReviewModel({
    required this.id,
    required this.venueId,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.rating,
    required this.comment,
    required this.createdDate,
    required this.photos,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatarUrl: json['userAvatarUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      photos: List<String>.from(json['photos'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'rating': rating,
      'comment': comment,
      'createdDate': createdDate.toIso8601String(),
      'photos': photos,
    };
  }

  ReviewModel copyWith({
    String? id,
    String? venueId,
    String? userId,
    String? userName,
    String? userAvatarUrl,
    double? rating,
    String? comment,
    DateTime? createdDate,
    List<String>? photos,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdDate: createdDate ?? this.createdDate,
      photos: photos ?? this.photos,
    );
  }
}
