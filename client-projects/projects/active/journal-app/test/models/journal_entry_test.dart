import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/models/journal_entry.dart';

void main() {
  group('JournalEntry', () {
    test('creates entry with default values', () {
      final entry = JournalEntry(
        title: 'Test Title',
        content: 'Test Content',
      );

      expect(entry.id, isNotEmpty);
      expect(entry.title, 'Test Title');
      expect(entry.content, 'Test Content');
      expect(entry.createdAt, isA<DateTime>());
      expect(entry.updatedAt, isA<DateTime>());
      expect(entry.mood, isNull);
      expect(entry.categoryId, isNull);
      expect(entry.tags, isEmpty);
      expect(entry.isFavorite, false);
      expect(entry.imagePath, isNull);
    });

    test('creates entry with custom ID and dates', () {
      final customDate = DateTime(2025, 1, 1);
      final entry = JournalEntry(
        id: 'custom-id',
        title: 'Test',
        content: 'Content',
        createdAt: customDate,
        updatedAt: customDate,
      );

      expect(entry.id, 'custom-id');
      expect(entry.createdAt, customDate);
      expect(entry.updatedAt, customDate);
    });

    test('creates entry with mood and tags', () {
      final entry = JournalEntry(
        title: 'Happy Day',
        content: 'Great things happened!',
        mood: Mood.happy,
        tags: ['work', 'achievement'],
        isFavorite: true,
      );

      expect(entry.mood, Mood.happy);
      expect(entry.tags, ['work', 'achievement']);
      expect(entry.isFavorite, true);
    });

    test('copyWith creates modified copy', () {
      final original = JournalEntry(
        title: 'Original',
        content: 'Content',
        mood: Mood.neutral,
      );

      final modified = original.copyWith(
        title: 'Modified',
        mood: Mood.happy,
      );

      expect(modified.id, original.id);
      expect(modified.title, 'Modified');
      expect(modified.content, 'Content');
      expect(modified.mood, Mood.happy);
    });

    test('toMap converts to database format', () {
      final entry = JournalEntry(
        id: 'test-id',
        title: 'Test',
        content: 'Content',
        mood: Mood.happy,
        tags: ['tag1', 'tag2'],
        isFavorite: true,
      );

      final map = entry.toMap();

      expect(map['id'], 'test-id');
      expect(map['title'], 'Test');
      expect(map['content'], 'Content');
      expect(map['mood'], Mood.happy.index);
      expect(map['tags'], 'tag1,tag2');
      expect(map['is_favorite'], 1);
      expect(map['created_at'], isA<String>());
      expect(map['updated_at'], isA<String>());
    });

    test('fromMap creates entry from database format', () {
      final createdAt = DateTime.now();
      final map = {
        'id': 'test-id',
        'title': 'Test',
        'content': 'Content',
        'created_at': createdAt.toIso8601String(),
        'updated_at': createdAt.toIso8601String(),
        'mood': Mood.sad.index,
        'category_id': 'cat-123',
        'tags': 'work,personal',
        'is_favorite': 1,
        'image_path': '/path/to/image.jpg',
      };

      final entry = JournalEntry.fromMap(map);

      expect(entry.id, 'test-id');
      expect(entry.title, 'Test');
      expect(entry.content, 'Content');
      expect(entry.mood, Mood.sad);
      expect(entry.categoryId, 'cat-123');
      expect(entry.tags, ['work', 'personal']);
      expect(entry.isFavorite, true);
      expect(entry.imagePath, '/path/to/image.jpg');
    });

    test('fromMap handles empty tags', () {
      final map = {
        'id': 'test-id',
        'title': 'Test',
        'content': 'Content',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'mood': null,
        'category_id': null,
        'tags': '',
        'is_favorite': 0,
        'image_path': null,
      };

      final entry = JournalEntry.fromMap(map);

      expect(entry.tags, isEmpty);
      expect(entry.mood, isNull);
      expect(entry.isFavorite, false);
    });

    test('contentPreview returns first 100 characters', () {
      final shortContent = 'Short content';
      final shortEntry = JournalEntry(
        title: 'Test',
        content: shortContent,
      );

      expect(shortEntry.contentPreview, shortContent);

      final longContent = 'a' * 150;
      final longEntry = JournalEntry(
        title: 'Test',
        content: longContent,
      );

      expect(longEntry.contentPreview.length, 103); // 100 + '...'
      expect(longEntry.contentPreview.endsWith('...'), true);
    });

    test('wordCount calculates correctly', () {
      final entry = JournalEntry(
        title: 'Test',
        content: 'This is a test with five words',
      );

      expect(entry.wordCount, 7); // 'is a test with five words' = 6 words + 'This' = 7

      final emptyEntry = JournalEntry(
        title: 'Test',
        content: '',
      );

      expect(emptyEntry.wordCount, 0);

      final multiSpaceEntry = JournalEntry(
        title: 'Test',
        content: 'Word1    Word2     Word3',
      );

      expect(multiSpaceEntry.wordCount, 3);
    });

    test('readingTimeMinutes calculates correctly', () {
      // 200 words = 1 minute
      final content200 = List.generate(200, (i) => 'word').join(' ');
      final entry200 = JournalEntry(
        title: 'Test',
        content: content200,
      );

      expect(entry200.readingTimeMinutes, 1);

      // 500 words = 3 minutes (500/200 = 2.5, ceil = 3)
      final content500 = List.generate(500, (i) => 'word').join(' ');
      final entry500 = JournalEntry(
        title: 'Test',
        content: content500,
      );

      expect(entry500.readingTimeMinutes, 3);
    });

    test('equality based on ID', () {
      final entry1 = JournalEntry(
        id: 'same-id',
        title: 'Title 1',
        content: 'Content 1',
      );

      final entry2 = JournalEntry(
        id: 'same-id',
        title: 'Title 2',
        content: 'Content 2',
      );

      final entry3 = JournalEntry(
        id: 'different-id',
        title: 'Title 1',
        content: 'Content 1',
      );

      expect(entry1, equals(entry2));
      expect(entry1, isNot(equals(entry3)));
      expect(entry1.hashCode, equals(entry2.hashCode));
    });

    test('toString returns meaningful string', () {
      final entry = JournalEntry(
        id: 'test-id',
        title: 'Test Title',
        content: 'Content',
        mood: Mood.happy,
      );

      final str = entry.toString();

      expect(str.contains('test-id'), true);
      expect(str.contains('Test Title'), true);
      expect(str.contains('Mood.happy'), true);
    });
  });

  group('Mood', () {
    test('has correct display names', () {
      expect(Mood.verySad.displayName, 'Very Sad');
      expect(Mood.sad.displayName, 'Sad');
      expect(Mood.neutral.displayName, 'Neutral');
      expect(Mood.happy.displayName, 'Happy');
      expect(Mood.veryHappy.displayName, 'Very Happy');
    });

    test('has correct emojis', () {
      expect(Mood.verySad.emoji, '😢');
      expect(Mood.sad.emoji, '😔');
      expect(Mood.neutral.emoji, '😐');
      expect(Mood.happy.emoji, '😊');
      expect(Mood.veryHappy.emoji, '😁');
    });

    test('has correct colors', () {
      expect(Mood.verySad.color, const Color(0xFF1565C0));
      expect(Mood.sad.color, const Color(0xFF42A5F5));
      expect(Mood.neutral.color, const Color(0xFF66BB6A));
      expect(Mood.happy.color, const Color(0xFFFFA726));
      expect(Mood.veryHappy.color, const Color(0xFFAB47BC));
    });

    test('enum values are in correct order', () {
      expect(Mood.values, [
        Mood.verySad,
        Mood.sad,
        Mood.neutral,
        Mood.happy,
        Mood.veryHappy,
      ]);
    });
  });

  group('Category', () {
    test('creates category with default values', () {
      final category = Category(
        name: 'Work',
        color: Colors.blue,
      );

      expect(category.id, isNotEmpty);
      expect(category.name, 'Work');
      expect(category.color, Colors.blue);
      expect(category.description, isNull);
      expect(category.iconName, isNull);
      expect(category.createdAt, isA<DateTime>());
    });

    test('toMap and fromMap work correctly', () {
      final original = Category(
        id: 'cat-123',
        name: 'Personal',
        description: 'Personal thoughts',
        color: Colors.red,
        iconName: 'person',
      );

      final map = original.toMap();
      final restored = Category.fromMap(map);

      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.description, original.description);
      expect(restored.color, original.color);
      expect(restored.iconName, original.iconName);
    });

    test('equality based on ID', () {
      final cat1 = Category(id: 'same-id', name: 'Cat1', color: Colors.red);
      final cat2 = Category(id: 'same-id', name: 'Cat2', color: Colors.blue);
      final cat3 = Category(id: 'different-id', name: 'Cat1', color: Colors.red);

      expect(cat1, equals(cat2));
      expect(cat1, isNot(equals(cat3)));
    });
  });

  group('Tag', () {
    test('creates tag with default values', () {
      final tag = Tag(
        name: 'important',
        color: Colors.orange,
      );

      expect(tag.id, isNotEmpty);
      expect(tag.name, 'important');
      expect(tag.color, Colors.orange);
      expect(tag.createdAt, isA<DateTime>());
    });

    test('toMap and fromMap work correctly', () {
      final original = Tag(
        id: 'tag-123',
        name: 'work',
        color: Colors.green,
      );

      final map = original.toMap();
      final restored = Tag.fromMap(map);

      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.color, original.color);
    });

    test('equality based on ID', () {
      final tag1 = Tag(id: 'same-id', name: 'Tag1', color: Colors.red);
      final tag2 = Tag(id: 'same-id', name: 'Tag2', color: Colors.blue);
      final tag3 = Tag(id: 'different-id', name: 'Tag1', color: Colors.red);

      expect(tag1, equals(tag2));
      expect(tag1, isNot(equals(tag3)));
    });
  });
}
