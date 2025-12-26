# Unit Testing in Flutter

## Overview

Unit tests validate individual functions, methods, or classes in isolation. They're fast, focused, and form the foundation of your testing strategy.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

## Basic Unit Test

```dart
// lib/utils/calculator.dart
class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  double divide(int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a / b;
  }
}

// test/utils/calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/utils/calculator.dart';

void main() {
  group('Calculator', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('add returns sum of two numbers', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-1, 1), equals(0));
    });

    test('subtract returns difference', () {
      expect(calculator.subtract(5, 3), equals(2));
    });

    test('divide throws on zero divisor', () {
      expect(
        () => calculator.divide(10, 0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('divide returns correct result', () {
      expect(calculator.divide(10, 2), equals(5.0));
    });
  });
}
```

## Testing Async Code

```dart
// lib/services/data_service.dart
class DataService {
  Future<List<String>> fetchItems() async {
    await Future.delayed(Duration(seconds: 1));
    return ['Item 1', 'Item 2', 'Item 3'];
  }
}

// test/services/data_service_test.dart
void main() {
  group('DataService', () {
    late DataService service;

    setUp(() {
      service = DataService();
    });

    test('fetchItems returns list', () async {
      final items = await service.fetchItems();

      expect(items, isA<List<String>>());
      expect(items.length, equals(3));
      expect(items.first, equals('Item 1'));
    });
  });
}
```

## Mocking Dependencies

```dart
// lib/repositories/user_repository.dart
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}

// lib/services/user_service.dart
class UserService {
  final UserRepository repository;

  UserService(this.repository);

  Future<User> getUserByEmail(String email) async {
    final user = await repository.getUser(email);
    if (user == null) throw UserNotFoundException();
    return user;
  }
}

// test/services/user_service_test.dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UserRepository])
void main() {
  group('UserService', () {
    late MockUserRepository mockRepository;
    late UserService service;

    setUp(() {
      mockRepository = MockUserRepository();
      service = UserService(mockRepository);
    });

    test('getUserByEmail returns user when found', () async {
      final user = User(id: '1', email: 'test@example.com');

      when(mockRepository.getUser('test@example.com'))
          .thenAnswer((_) async => user);

      final result = await service.getUserByEmail('test@example.com');

      expect(result, equals(user));
      verify(mockRepository.getUser('test@example.com')).called(1);
    });

    test('getUserByEmail throws when user not found', () async {
      when(mockRepository.getUser('notfound@example.com'))
          .thenAnswer((_) async => null);

      expect(
        () => service.getUserByEmail('notfound@example.com'),
        throwsA(isA<UserNotFoundException>()),
      );
    });
  });
}
```

## Run Tests

```bash
# Run all tests
flutter test

# Run specific file
flutter test test/utils/calculator_test.dart

# Run with coverage
flutter test --coverage

# Generate mocks
flutter pub run build_runner build
```

## Best Practices

1. **Use descriptive test names**
2. **Follow AAA pattern**: Arrange, Act, Assert
3. **Test one thing per test**
4. **Use setUp() and tearDown()**
5. **Mock external dependencies**
6. **Aim for high coverage**

## Common Matchers

```dart
expect(actual, equals(expected));
expect(actual, isA<Type>());
expect(actual, isNull);
expect(actual, isNotNull);
expect(list, contains(item));
expect(list, isEmpty);
expect(list, hasLength(5));
expect(() => fn(), throwsException);
expect(value, greaterThan(5));
expect(value, lessThan(10));
```

---

**Resources:**
- [Flutter Testing Guide](https://docs.flutter.dev/testing/overview)
- [Mockito Package](https://pub.dev/packages/mockito)
