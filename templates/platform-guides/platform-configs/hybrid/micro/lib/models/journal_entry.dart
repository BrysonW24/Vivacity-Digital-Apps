import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Represents a journal entry in the application
class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Mood? mood;
  final String? categoryId;
  final List<String> tags;
  final bool isFavorite;
  final String? imagePath;

  JournalEntry({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.mood,
    this.categoryId,
    this.tags = const [],
    this.isFavorite = false,
    this.imagePath,
  }) :
    id = id ?? const Uuid().v4(),
    createdAt = createdAt ?? DateTime.now(),
    updatedAt = updatedAt ?? DateTime.now();

  /// Creates a copy of this entry with updated fields
  JournalEntry copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    Mood? mood,
    String? categoryId,
    List<String>? tags,
    bool? isFavorite,
    String? imagePath,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mood: mood ?? this.mood,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// Converts the entry to a map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'mood': mood?.index,
      'category_id': categoryId,
      'tags': tags.join(','), // Store as comma-separated string
      'is_favorite': isFavorite ? 1 : 0,
      'image_path': imagePath,
    };
  }

  /// Creates an entry from a database map
  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      mood: map['mood'] != null ? Mood.values[map['mood']] : null,
      categoryId: map['category_id'],
      tags: (map['tags'] as String?)?.split(',').where((tag) => tag.isNotEmpty).toList() ?? [],
      isFavorite: map['is_favorite'] == 1,
      imagePath: map['image_path'],
    );
  }

  /// Gets a preview of the content (first 100 characters)
  String get contentPreview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// Gets the word count of the content
  int get wordCount {
    return content.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  /// Gets the reading time estimate in minutes
  int get readingTimeMinutes {
    // Average reading speed: ~200 words per minute
    return (wordCount / 200).ceil();
  }

  @override
  String toString() {
    return 'JournalEntry(id: $id, title: $title, createdAt: $createdAt, mood: $mood)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JournalEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Represents the mood associated with a journal entry
enum Mood {
  verySad,
  sad,
  neutral,
  happy,
  veryHappy;

  String get displayName {
    switch (this) {
      case Mood.verySad:
        return 'Very Sad';
      case Mood.sad:
        return 'Sad';
      case Mood.neutral:
        return 'Neutral';
      case Mood.happy:
        return 'Happy';
      case Mood.veryHappy:
        return 'Very Happy';
    }
  }

  String get emoji {
    switch (this) {
      case Mood.verySad:
        return '😢';
      case Mood.sad:
        return '😔';
      case Mood.neutral:
        return '😐';
      case Mood.happy:
        return '😊';
      case Mood.veryHappy:
        return '😁';
    }
  }

  Color get color {
    switch (this) {
      case Mood.verySad:
        return const Color(0xFF1565C0); // Dark Blue
      case Mood.sad:
        return const Color(0xFF42A5F5); // Light Blue
      case Mood.neutral:
        return const Color(0xFF66BB6A); // Light Green
      case Mood.happy:
        return const Color(0xFFFFA726); // Orange
      case Mood.veryHappy:
        return const Color(0xFFAB47BC); // Purple
    }
  }
}

/// Represents a category for organizing journal entries
class Category {
  final String id;
  final String name;
  final String? description;
  final Color color;
  final String? iconName;
  final DateTime createdAt;

  Category({
    String? id,
    required this.name,
    this.description,
    required this.color,
    this.iconName,
    DateTime? createdAt,
  }) :
    id = id ?? const Uuid().v4(),
    createdAt = createdAt ?? DateTime.now();

  Category copyWith({
    String? id,
    String? name,
    String? description,
    Color? color,
    String? iconName,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color.value, // Store color as int
      'icon_name': iconName,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      color: Color(map['color']),
      iconName: map['icon_name'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name, color: $color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Represents a tag for organizing journal entries
class Tag {
  final String id;
  final String name;
  final Color color;
  final DateTime createdAt;

  Tag({
    String? id,
    required this.name,
    required this.color,
    DateTime? createdAt,
  }) :
    id = id ?? const Uuid().v4(),
    createdAt = createdAt ?? DateTime.now();

  Tag copyWith({
    String? id,
    String? name,
    Color? color,
    DateTime? createdAt,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      name: map['name'],
      color: Color(map['color']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  @override
  String toString() => 'Tag(id: $id, name: $name, color: $color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tag && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}