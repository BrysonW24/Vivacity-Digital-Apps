# Testing Frameworks

Production-ready testing templates and configurations for building robust test suites.

## Overview

This directory contains testing templates that demonstrate best practices for unit testing, integration testing, and test organization. Templates are designed to be copied into your project and customized for your specific needs.

## Available Templates

### Unit Tests (`unit_tests_example.dart`)

Comprehensive unit testing example demonstrating:
- Test structure and organization
- Mocking dependencies
- Assertion patterns
- Test lifecycle management
- Edge case coverage

**Features:**
- Clean test organization
- Mock setup examples
- Multiple test scenarios
- Comprehensive assertions
- Documentation

## Quick Start

### Copy to Your Project

```bash
# Copy all testing templates
cp -r templates/testing_frameworks/ your-project/test/

# Copy specific template
cp templates/testing_frameworks/unit_tests_example.dart your-project/test/
```

### Setup Testing

```bash
# For Flutter/Dart projects
flutter test

# For React/TypeScript projects
npm test

# For Next.js projects
npm run test
```

## Usage Examples

### Example 1: Basic Unit Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/services/calculator.dart';

void main() {
  group('Calculator', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('addition should return correct sum', () {
      final result = calculator.add(2, 3);
      expect(result, 5);
    });

    test('division by zero should throw exception', () {
      expect(
        () => calculator.divide(10, 0),
        throwsA(isA<DivisionByZeroException>()),
      );
    });
  });
}
```

### Example 2: Testing with Mocks

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app/repositories/user_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('UserRepository', () {
    late MockApiClient mockApiClient;
    late UserRepository repository;

    setUp(() {
      mockApiClient = MockApiClient();
      repository = UserRepository(mockApiClient);
    });

    test('getUserById should return user when API call succeeds', () async {
      // Arrange
      final expectedUser = User(id: '1', name: 'John Doe');
      when(mockApiClient.get('/users/1'))
          .thenAnswer((_) async => expectedUser.toJson());

      // Act
      final result = await repository.getUserById('1');

      // Assert
      expect(result, expectedUser);
      verify(mockApiClient.get('/users/1')).called(1);
    });
  });
}
```

## Best Practices

### Test Organization

```
test/
├── unit/                    # Unit tests
│   ├── models/
│   ├── services/
│   └── repositories/
├── widget/                  # Widget tests (Flutter)
│   ├── components/
│   └── screens/
├── integration/             # Integration tests
│   └── flows/
└── test_helpers/            # Shared test utilities
    ├── mocks.dart
    └── fixtures.dart
```

### Naming Conventions

- Test files: `*_test.dart` or `*.test.ts`
- Test descriptions: Clear, descriptive statements
- Group related tests with `group()`
- Use `setUp()` and `tearDown()` for initialization

### Coverage Goals

- **Unit Tests**: 80%+ code coverage
- **Critical Paths**: 100% coverage
- **Edge Cases**: Comprehensive coverage
- **Error Handling**: All error paths tested

### What to Test

**Do Test:**
- Business logic
- Data transformations
- Error handling
- Edge cases
- Public APIs

**Don't Test:**
- Framework code
- Third-party libraries
- Trivial getters/setters
- UI layout (unless widget tests)

## Testing Patterns

### Arrange-Act-Assert (AAA)

```dart
test('user login should return auth token', () async {
  // Arrange - Set up test conditions
  final authService = AuthService();
  final credentials = Credentials('user@example.com', 'password123');

  // Act - Execute the code being tested
  final result = await authService.login(credentials);

  // Assert - Verify the results
  expect(result.isSuccess, true);
  expect(result.token, isNotEmpty);
});
```

### Test Fixtures

Create reusable test data:

```dart
// test/fixtures/user_fixtures.dart
class UserFixtures {
  static User createValidUser() => User(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
  );

  static User createAdminUser() => User(
    id: '2',
    name: 'Admin User',
    email: 'admin@example.com',
    role: UserRole.admin,
  );
}
```

### Mock Setup

```dart
// test/mocks/mock_api_client.dart
import 'package:mockito/annotations.dart';
import 'package:your_app/services/api_client.dart';

@GenerateMocks([ApiClient])
void main() {}

// Generate mocks with:
// flutter pub run build_runner build
```

## Testing Different Scenarios

### Testing Async Code

```dart
test('async operation should complete successfully', () async {
  final result = await asyncOperation();
  expect(result, isNotNull);
});
```

### Testing Streams

```dart
test('stream should emit correct values', () {
  final stream = countStream();

  expect(
    stream,
    emitsInOrder([0, 1, 2, emitsDone]),
  );
});
```

### Testing Exceptions

```dart
test('invalid input should throw exception', () {
  expect(
    () => validateInput(''),
    throwsA(isA<ValidationException>()),
  );
});
```

## Configuration

### Flutter Test Configuration

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

### React/Jest Configuration

```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  },
  "devDependencies": {
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0",
    "jest": "^29.0.0"
  }
}
```

## Running Tests

### Flutter/Dart

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/calculator_test.dart

# Run with coverage
flutter test --coverage

# Watch mode
flutter test --watch
```

### React/TypeScript

```bash
# Run all tests
npm test

# Run specific test
npm test calculator.test.ts

# Run with coverage
npm test -- --coverage

# Watch mode
npm test -- --watch
```

## Continuous Integration

Integrate tests into CI/CD pipelines:

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
```

## Troubleshooting

### Common Issues

**Issue: Tests failing intermittently**
- Solution: Check for timing issues, use proper async/await

**Issue: Mocks not working**
- Solution: Verify mock generation, check import paths

**Issue: Low coverage**
- Solution: Identify untested code paths, add missing tests

**Issue: Slow test execution**
- Solution: Optimize test setup, use test doubles, parallelize

## Resources

### Documentation
- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Jest Documentation](https://jestjs.io/)
- [Testing Library](https://testing-library.com/)

### Best Practices
- Test-Driven Development (TDD)
- Behavior-Driven Development (BDD)
- Test pyramid strategy

## Support

For questions or issues with testing templates:
1. Review inline documentation
2. Check framework-specific testing guides
3. Consult [CONTRIBUTING.md](../CONTRIBUTING.md)
4. Contact Vivacity Digital team

---

**Vivacity Digital** - Testing Templates and Best Practices
