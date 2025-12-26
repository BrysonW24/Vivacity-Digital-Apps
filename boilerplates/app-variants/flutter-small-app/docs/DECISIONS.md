# Architecture Decision Records (ADRs)

This document records important architectural decisions made for the Flutter Small App boilerplate. Each decision includes the context, reasoning, and implications for developers using this boilerplate.

**Format**: [ADR Template](https://adr.github.io/) adapted for this project

---

## Table of Contents

1. [ADR-001: Clean Architecture Layers](#adr-001-clean-architecture-layers)
2. [ADR-002: Provider Pattern for State Management](#adr-002-provider-pattern-for-state-management)
3. [ADR-003: Service Locator with GetIt](#adr-003-service-locator-with-getit)
4. [ADR-004: Repository Pattern for Data Access](#adr-004-repository-pattern-for-data-access)
5. [ADR-005: Exception Handling Strategy](#adr-005-exception-handling-strategy)
6. [ADR-006: Environment Configuration](#adr-006-environment-configuration)
7. [ADR-007: Structured Logging](#adr-007-structured-logging)
8. [ADR-008: HTTP Client with Dio](#adr-008-http-client-with-dio)

---

## ADR-001: Clean Architecture Layers

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

The boilerplate needs a clear, scalable architecture that:
- Separates concerns
- Makes testing easier
- Facilitates team collaboration
- Reduces coupling between components
- Enables reusability

### Decision

We adopt a **5-layer Clean Architecture** approach:

1. **Presentation Layer** (UI)
   - Screens, Widgets, UI components
   - Responsible for rendering and user interaction
   - No business logic, pure UI code

2. **State Management Layer** (Provider)
   - Providers and ChangeNotifiers
   - Manages component state and business logic
   - Communicates with repositories

3. **Service Layer** (Business Logic)
   - Standalone services (auth, storage, logging)
   - Handles cross-cutting concerns
   - No direct UI knowledge

4. **Repository Layer** (Data Abstraction)
   - Interfaces between services and data sources
   - Abstracts API and local storage
   - Single source of truth for data

5. **Model Layer** (Data)
   - Data models and DTOs
   - API response/request objects
   - Immutable, serializable data classes

### Rationale

- **Maintainability**: Each layer has clear responsibility
- **Testability**: Layers can be tested independently
- **Reusability**: Services and repositories shared across screens
- **Onboarding**: New developers understand structure immediately
- **Scalability**: Layers scale independently as app grows

### Implications

- Developers must place code in correct layer
- No shortcuts across layers (e.g., screens should not call API directly)
- Introduces some boilerplate code
- Better for large/team projects than simple apps

### Example Flow

```
Screen → reads → Provider → calls → Repository
                                        ↓
                                   ApiClient/Service
                                        ↓
                                     Model
```

---

## ADR-002: Provider Pattern for State Management

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

State management is critical for Flutter apps. We need to choose between:
- Provider
- Riverpod
- GetX
- Bloc/Cubit
- MobX

### Decision

We chose **Provider** (with ChangeNotifier) for state management.

### Rationale

1. **Learning Curve**: Low - easy for new Flutter developers
2. **Community**: Large, well-established package
3. **Documentation**: Extensive tutorials and examples
4. **Flexibility**: Works with multiple approaches (ChangeNotifier, Listenable, etc.)
5. **Performance**: Sufficient for most apps, with Consumer widgets for optimization
6. **Testing**: Straightforward to mock providers

### Key Patterns

```dart
// Provider Definition (ChangeNotifier)
class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUser() async {
    _user = await userRepository.getUser();
    notifyListeners();
  }
}

// Usage in Widget
Consumer<UserProvider>(
  builder: (context, userProvider, _) {
    return Text(userProvider.user?.name ?? 'Loading');
  },
)

// Access via context
final provider = context.read<UserProvider>();
final state = context.watch<UserProvider>();
```

### Implications

- All state changes require `.notifyListeners()`
- Unoptimized Consumer rebuilds entire widget tree
- Use `Consumer` or `.select()` for optimization
- No built-in form validation helpers (use mixins instead)

### When NOT to Use Provider

- Simple, stateless UI components
- One-off local widget state (use StatefulWidget)
- Complex form validation (consider Bloc/Cubit)

---

## ADR-003: Service Locator with GetIt

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

The app has many singleton services (Auth, Storage, Connectivity, etc.) that need to be:
- Globally accessible
- Lazily instantiated
- Easily mockable for testing

### Decision

Use **GetIt** service locator for dependency injection and service management.

### Rationale

1. **Simplicity**: Minimal API, easy to understand
2. **Global Access**: `getIt<Service>()` from anywhere
3. **Testing**: Easy to replace with mocks via `.reset()`
4. **Performance**: Lazy initialization, no DI framework overhead
5. **Compatibility**: Works with Provider pattern

### Example

```dart
// Setup (main.dart)
setupServiceLocator() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<StorageService>(StorageService());
}

// Usage
final authService = getIt<AuthService>();
```

### Implications

- Services must be registered before use
- No automatic injection (unlike Hilt, Dagger)
- Global service access can hide dependencies
- Must mock via `.reset()` in tests

### Service Locator vs Provider

| Aspect | GetIt | Provider |
|--------|-------|----------|
| Purpose | Dependency injection | State management |
| Scope | Application-wide | Local/widget tree |
| Mutability | Single instance | Mutable state |
| UI Updates | Manual (no rebuild) | Automatic rebuild |

---

## ADR-004: Repository Pattern for Data Access

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

Data comes from multiple sources:
- Remote API
- Local storage
- Secure storage
- SQLite database

Repositories abstract these details from the rest of the app.

### Decision

Implement **Repository Pattern** with single-responsibility repositories.

### Structure

```
Repository
├── Data Abstraction
├── Error Handling
├── Logging
└── Single Responsibility
```

### Example

```dart
// GOOD: Single responsibility
class AuthRepository {
  Future<AuthResponse> login(String email, String password) async {
    // Only handles auth-related operations
  }
}

class UserRepository {
  Future<User> getUser(String id) async {
    // Only handles user operations
  }
}

// AVOID: God repository
class DataRepository {
  Future<AuthResponse> login() {} // Auth
  Future<User> getUser() {}        // User
  Future<Settings> getSettings() {}  // Settings
}
```

### Data Flow

```
Provider → Repository → ApiClient/StorageService → Model
  ↑            ↓
  └─ notifyListeners() on success/error
```

### Implications

- Multiple repository classes (vs. single DataRepository)
- Providers depend on repositories
- Error handling centralized in repository

---

## ADR-005: Exception Handling Strategy

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

API calls can fail in multiple ways:
- Network errors (no connection, timeout)
- Server errors (500, 503)
- Client errors (400, 401, 404)
- Data parsing errors

### Decision

Create **specific exception types** for different error scenarios.

### Exception Hierarchy

```
ApiException (base)
├── TimeoutException
├── ServerException
├── NoInternetException
├── BadRequestException
├── UnauthorizedException
├── ForbiddenException
├── NotFoundException
└── ConflictException
```

### Usage

```dart
try {
  final data = await repository.fetchData();
} on UnauthorizedException {
  // Handle 401 - redirect to login
} on ServerException {
  // Handle 5xx - show retry dialog
} on NoInternetException {
  // Handle offline - show offline message
} on ApiException catch (e) {
  // Handle other API errors
  LoggerService.error('API Error: ${e.message}');
}
```

### Implications

- Try-catch blocks are specific and clear
- Error UI can respond to exception type
- No generic "Exception" catching

---

## ADR-006: Environment Configuration

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

The app has different configurations for:
- Development (localhost, debug logs, test APIs)
- Staging (staging APIs, some logs)
- Production (production APIs, minimal logs, error reporting)

### Decision

Use **`.env` files** with `flutter_dotenv` for environment-specific configuration.

### File Structure

```
.env.development    # Default for local development
.env.staging        # Staging environment
.env.production     # Production environment
```

### Usage

```dart
// lib/config/env.dart
class Env {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static bool get isProduction => environment == 'production';
}

// Run with environment
flutter run --dart-define=ENVIRONMENT=production
```

### Files NOT to Commit

Never commit these files (add to `.gitignore`):
```
.env.development
.env.production
.env.staging
```

### Implications

- Secrets stay out of version control
- Build flavors not needed (simplifies setup)
- Environment-specific behavior clear
- Team must share `.env` files securely

---

## ADR-007: Structured Logging

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

Logging is essential for:
- Debugging issues
- Monitoring app health
- Understanding user behavior

We need structured, filterable logs.

### Decision

Create **LoggerService** with levels and structured output.

### Log Levels

```dart
enum LogLevel {
  debug,    // Development only
  info,     // Important events
  warning,  // Unexpected conditions
  error,    // Errors to fix
  fatal,    // App-breaking errors
}
```

### Usage

```dart
LoggerService.debug('User profile loaded');
LoggerService.info('Login successful for ${user.email}');
LoggerService.warning('Token refresh failed, will retry');
LoggerService.error('Network timeout', error: exception);
LoggerService.fatal('Database initialization failed', error: error);
```

### Configuration

```dart
// Production: Only info+ logs
if (Env.isProduction) {
  LoggerService.setMinLevel(LogLevel.info);
}

// Development: All logs
if (Env.isDevelopment) {
  LoggerService.setMinLevel(LogLevel.debug);
}
```

### Log Output

```
[INFO] 2025-12-01 10:30:45 | AuthService: Login successful for user@example.com
[ERROR] 2025-12-01 10:31:20 | NetworkService: Connection timeout after 30s
[WARNING] 2025-12-01 10:32:10 | TokenService: Token refresh failed, retrying
```

### Implications

- No print() statements in production code
- Logs help diagnose production issues
- Structured logs enable analytics/monitoring

---

## ADR-008: HTTP Client with Dio

**Status**: ACCEPTED | **Date**: 2025-12-01 | **Version**: 1.0.0

### Context

HTTP communication is critical. We need:
- Automatic request/response logging
- Global error handling
- Request timeout management
- Automatic token injection
- Request retry logic

### Decision

Use **Dio** HTTP client with custom interceptors instead of http package.

### Interceptors

```
Request → [AuthInterceptor] → [LoggingInterceptor] → [RetryInterceptor] → Server
                ↓                    ↓                    ↓
           Add token          Log request/response   Retry on failure

Response ← [AuthInterceptor] ← [LoggingInterceptor] ← [RetryInterceptor] ← Server
                ↓
          Check 401, refresh token
```

### Configuration

```dart
class ApiClient {
  static const baseUrl = 'https://api.example.com';
  static const timeout = Duration(seconds: 30);

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: timeout,
    receiveTimeout: timeout,
    validateStatus: (status) {
      return status != null && status < 500;
    },
  ));

  // Add interceptors
  dio.interceptors.add(AuthInterceptor());
  dio.interceptors.add(LoggingInterceptor());
}
```

### Error Handling in Dio

```dart
try {
  final response = await dio.get('/users');
  return response.data;
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  } else if (e.type == DioExceptionType.connectionTimeout) {
    // Handle timeout
  }
  rethrow;
}
```

### Why Dio Over http Package

| Feature | Dio | http |
|---------|-----|------|
| Interceptors | ✓ | ✗ |
| Automatic retry | ✓ | ✗ |
| Global headers | ✓ | ✗ |
| Timeout | ✓ | ✓ |
| Upload progress | ✓ | ✗ |
| Request cancellation | ✓ | ✗ |

### Implications

- All HTTP calls go through ApiClient
- Interceptors handle cross-cutting concerns
- No raw http calls in repositories
- Testing via mock Dio instance

---

## Future Considerations

### ADR-009: Testing Strategy (Pending)
- Unit testing with Mockito
- Widget testing with WidgetTester
- Integration testing

### ADR-010: Localization (Pending)
- Multi-language support
- flutter_gen_l10n approach
- Date/number formatting

### ADR-011: Analytics & Monitoring (Pending)
- Firebase Analytics
- Crash reporting
- Performance monitoring

### ADR-012: Push Notifications (Pending)
- FCM setup
- Local vs remote notifications
- Notification routing

---

## Updating This Document

When making architectural decisions:

1. **Create new ADR**
   - Use next available number
   - Follow template above
   - Document context and rationale

2. **Update status**
   - PROPOSED: Under discussion
   - ACCEPTED: Approved and implemented
   - DEPRECATED: Still used but not recommended
   - SUPERSEDED: Replaced by new ADR

3. **Include examples**
   - Code samples
   - Diagrams
   - Before/after patterns

4. **Solicit feedback**
   - Share with team
   - Discuss alternatives
   - Get approval before implementation

---

## References

- [Architecture Decision Records (ADR)](https://adr.github.io/)
- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture Samples](https://github.com/flutter/samples)
- [Provider Package Documentation](https://pub.dev/packages/provider)

---

**Last Updated**: 2025-12-01
**Maintainer**: Vivacity Digital Team
**Contact**: architecture@example.com
