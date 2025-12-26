/// Notification model
/// Represents a single notification/message for the user

class Notification {
  final String id;
  final String title;
  final String message;
  final String? imageUrl;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final Map<String, dynamic>? payload;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    this.imageUrl,
    required this.type,
    this.isRead = false,
    required this.createdAt,
    this.readAt,
    this.payload,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      imageUrl: json['imageUrl'],
      type: _parseNotificationType(json['type']),
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'imageUrl': imageUrl,
      'type': type.toString().split('.').last,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'payload': payload,
    };
  }

  static NotificationType _parseNotificationType(dynamic type) {
    if (type == null) return NotificationType.general;
    if (type is String) {
      try {
        return NotificationType.values.byName(type);
      } catch (_) {
        return NotificationType.general;
      }
    }
    return NotificationType.general;
  }

  /// Copy with method for immutable updates
  Notification copyWith({
    String? id,
    String? title,
    String? message,
    String? imageUrl,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    Map<String, dynamic>? payload,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      payload: payload ?? this.payload,
    );
  }
}

/// Notification types enum
enum NotificationType {
  general,
  alert,
  promotional,
  system,
  message,
  reminder,
}
