# Code Patterns

Architectural patterns and implementation templates for common development scenarios.

## Overview

This directory contains proven code patterns and architectural implementations that solve common development challenges. These patterns promote maintainability, testability, and scalability.

## Directory Structure

```
code-patterns/
├── api-patterns/          # API client implementations
│   ├── http_client.dart   # Basic HTTP client
│   ├── dio_setup.dart     # Dio configuration
│   └── graphql_setup.dart # GraphQL client
└── state-patterns/        # State management
    ├── provider_example.dart   # Provider pattern
    └── riverpod_example.dart   # Riverpod pattern
```

## API Patterns

### HTTP Client (`http_client.dart`)

Basic HTTP client implementation with:
- Request/response handling
- Error management
- Timeout configuration
- Header management
- Base URL configuration

**Use Cases:**
- Simple REST API integration
- Lightweight HTTP operations
- Basic CRUD operations

**Example:**
```dart
final client = HttpClientService(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
);

final response = await client.get('/users/123');
final user = User.fromJson(response.data);
```

### Dio Client (`dio_setup.dart`)

Advanced HTTP client with Dio featuring:
- Interceptors for auth and logging
- Retry logic
- Request/response transformation
- File upload/download
- Advanced error handling

**Use Cases:**
- Complex API integrations
- File handling requirements
- Advanced request manipulation
- Custom interceptor logic

**Example:**
```dart
final dio = DioClient.getInstance(
  baseUrl: 'https://api.example.com',
  interceptors: [
    AuthInterceptor(),
    LoggingInterceptor(),
    RetryInterceptor(),
  ],
);

final response = await dio.get('/users');
```

### GraphQL Client (`graphql_setup.dart`)

GraphQL client configuration with:
- Query and mutation support
- Caching strategies
- Error handling
- Subscription support
- Fragment management

**Use Cases:**
- GraphQL API integration
- Complex data requirements
- Real-time data updates
- Optimized data fetching

**Example:**
```dart
final client = GraphQLClient(
  link: HttpLink('https://api.example.com/graphql'),
  cache: GraphQLCache(),
);

final result = await client.query(
  QueryOptions(document: gql(getUserQuery)),
);
```

## State Management Patterns

### Provider (`provider_example.dart`)

Provider-based state management:
- Simple state sharing
- Change notification
- Dependency injection
- Widget rebuilding optimization

**Use Cases:**
- Small to medium applications
- Simple state requirements
- Learning state management
- Quick prototypes

**Example:**
```dart
class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> loadUser(String id) async {
    _user = await userRepository.getUser(id);
    notifyListeners();
  }
}

// Usage in widget
final user = context.watch<UserProvider>().user;
```

### Riverpod (`riverpod_example.dart`)

Modern state management with Riverpod:
- Compile-time safety
- No context dependency
- Testing friendly
- Auto-dispose
- Provider composition

**Use Cases:**
- Medium to large applications
- Complex state requirements
- Strong typing needs
- Scalable architecture

**Example:**
```dart
final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  return UserNotifier(ref.read(userRepositoryProvider));
});

// Usage in widget
final user = ref.watch(userProvider);
```

## Quick Start

### Copy Patterns

```bash
# Copy specific pattern
cp templates/code-patterns/api-patterns/dio_setup.dart your-project/lib/services/

# Copy all API patterns
cp -r templates/code-patterns/api-patterns/ your-project/lib/services/

# Copy state management pattern
cp templates/code-patterns/state-patterns/riverpod_example.dart your-project/lib/providers/
```

### Integration Steps

1. **Copy the pattern file** to your project
2. **Update imports** to match your project structure
3. **Configure base URLs** and endpoints
4. **Add dependencies** to pubspec.yaml
5. **Customize** for your specific needs

## Detailed Pattern Guides

### API Client Pattern

#### Setup Dependencies

```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0        # For http_client
  dio: ^5.4.0         # For dio_setup
  graphql_flutter: ^5.1.0  # For graphql_setup
```

#### Basic Implementation

```dart
// lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        )) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path) => _dio.get(path);
  Future<Response> post(String path, dynamic data) => _dio.post(path, data: data);
}
```

#### Error Handling

```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

Future<T> handleApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      throw ApiException('Unauthorized', 401);
    } else if (e.response?.statusCode == 404) {
      throw ApiException('Not found', 404);
    } else {
      throw ApiException('Network error: ${e.message}');
    }
  } catch (e) {
    throw ApiException('Unexpected error: $e');
  }
}
```

### State Management Pattern

#### Provider Setup

```dart
// lib/providers/app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read(apiServiceProvider));
});

// State notifier
class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository _repository;

  UserNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadUser();
  }

  Future<void> loadUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getCurrentUser());
  }

  Future<void> updateUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.updateUser(user));
  }
}

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  return UserNotifier(ref.read(userRepositoryProvider));
});
```

#### Usage in Widgets

```dart
class UserProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return userState.when(
      data: (user) => UserProfileView(user: user),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorView(error: error.toString()),
    );
  }
}
```

## Architecture Patterns

### Repository Pattern

```dart
abstract class UserRepository {
  Future<User> getUserById(String id);
  Future<List<User>> getAllUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}

class UserRepositoryImpl implements UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<User> getUserById(String id) async {
    final response = await _apiService.get('/users/$id');
    return User.fromJson(response.data);
  }

  // Additional implementations...
}
```

### Service Layer Pattern

```dart
class AuthService {
  final ApiService _apiService;
  final SecureStorage _storage;

  AuthService(this._apiService, this._storage);

  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      await _storage.saveToken(token);

      return AuthResult.success(token);
    } catch (e) {
      return AuthResult.failure(e.toString());
    }
  }
}
```

## Best Practices

### API Client
- Use environment variables for base URLs
- Implement proper error handling
- Add request/response logging in development
- Use interceptors for cross-cutting concerns
- Implement retry logic for transient failures
- Cache responses when appropriate

### State Management
- Keep state providers focused and single-purpose
- Use immutable state objects
- Implement proper error states
- Clean up resources in dispose
- Test state logic independently
- Document state transitions

### Code Organization
```
lib/
├── models/           # Data models
├── repositories/     # Data access layer
├── services/         # Business logic
├── providers/        # State management
└── ui/              # User interface
```

## Testing Patterns

### Mock API Client

```dart
class MockApiService extends Mock implements ApiService {}

void main() {
  group('UserRepository', () {
    late MockApiService mockApi;
    late UserRepository repository;

    setUp(() {
      mockApi = MockApiService();
      repository = UserRepositoryImpl(mockApi);
    });

    test('getUserById returns user', () async {
      when(mockApi.get('/users/1'))
          .thenAnswer((_) async => Response(
            data: {'id': '1', 'name': 'Test'},
            statusCode: 200,
          ));

      final user = await repository.getUserById('1');
      expect(user.name, 'Test');
    });
  });
}
```

### State Testing

```dart
void main() {
  group('UserNotifier', () {
    test('initial state is loading', () {
      final container = ProviderContainer();
      final notifier = container.read(userProvider.notifier);

      expect(
        container.read(userProvider),
        const AsyncValue<User>.loading(),
      );
    });
  });
}
```

## Performance Optimization

### Caching Strategy

```dart
class CachedApiService {
  final ApiService _apiService;
  final Map<String, CacheEntry> _cache = {};

  Future<Response> get(String path, {Duration? cacheDuration}) async {
    final cached = _cache[path];
    if (cached != null && !cached.isExpired) {
      return cached.response;
    }

    final response = await _apiService.get(path);
    _cache[path] = CacheEntry(response, cacheDuration ?? Duration(minutes: 5));
    return response;
  }
}
```

### Debouncing

```dart
class DebouncedSearch {
  Timer? _debounce;

  void search(String query, Function(String) onSearch) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      onSearch(query);
    });
  }

  void dispose() {
    _debounce?.cancel();
  }
}
```

## Security Considerations

### Token Management

```dart
class SecureTokenStorage {
  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
```

### Input Validation

```dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }
}
```

## Resources

### Documentation
- [Dio Documentation](https://pub.dev/packages/dio)
- [Riverpod Documentation](https://riverpod.dev/)
- [Provider Documentation](https://pub.dev/packages/provider)
- [GraphQL Flutter](https://pub.dev/packages/graphql_flutter)

### Architecture
- Clean Architecture
- SOLID Principles
- Repository Pattern
- Service Layer Pattern

## Support

For pattern implementation questions:
1. Review pattern inline documentation
2. Check usage examples
3. Consult architecture guides
4. Contact Vivacity Digital team

---

**Vivacity Digital** - Proven Architectural Patterns
