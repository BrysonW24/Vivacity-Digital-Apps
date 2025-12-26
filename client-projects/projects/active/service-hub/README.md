# Small App Boilerplate

A production-ready Flutter boilerplate for small business applications with clean architecture, best practices, and comprehensive features.

## ✨ Features

- ✅ **28 Pre-built Screens** - Authentication, home, settings, profile, notifications, and more
- ✅ **Clean Architecture** - 5-layer architecture pattern with separation of concerns
- ✅ **State Management** - Provider pattern with proper state segregation
- ✅ **Complete Auth Flow** - Login, signup, password reset, email verification, biometrics
- ✅ **API Client** - Dio with logging and retry interceptors
- ✅ **Secure Storage** - Token management and sensitive data storage
- ✅ **Form Validation** - Comprehensive validation with custom exceptions
- ✅ **Error Handling** - Structured exception hierarchy
- ✅ **Dark/Light Theme** - Theme provider with easy switching
- ✅ **Push Notifications** - Firebase Cloud Messaging integration
- ✅ **Analytics Ready** - Event tracking infrastructure
- ✅ **Localization** - Multi-language support (10 languages)
- ✅ **Offline Support** - Local storage and caching
- ✅ **Testing Ready** - Dependency injection for easy mocking

## 📋 Requirements

- Flutter SDK >= 3.2.0
- Dart >= 3.2.0
- iOS 11.0+ / Android 5.0+ (API 21+)

## 🚀 Quick Start

### 1. Installation

```bash
# Clone or copy the boilerplate
cp -r small-app my-app
cd my-app

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization
flutter gen-l10n

# Run the app
flutter run
```

### 2. Environment Setup

```bash
# Copy development environment
cp .env.development .env

# Or for production
cp .env.production .env
```

### 3. Configure Your App

Update the following files with your app details:
- `lib/config/app_config.dart` - App name, version, etc.
- `lib/config/api_endpoints.dart` - API base URLs
- `lib/config/app_colors.dart` - Brand colors
- `pubspec.yaml` - Package name, version

## 📁 Project Structure

```
lib/
├── app.dart                   # Root app widget
├── main.dart                  # Entry point
├── injection.dart             # Dependency injection
│
├── config/                    # App configuration (10 files)
│   ├── api_endpoints.dart
│   ├── app_colors.dart
│   ├── app_config.dart
│   ├── app_sizes.dart
│   ├── app_strings.dart
│   ├── assets.dart
│   ├── env.dart
│   ├── routes.dart
│   ├── storage_keys.dart
│   └── theme_config.dart
│
├── constants/                 # Constants and enums
│   ├── app_constants.dart
│   └── app_enums.dart
│
├── database/                  # Local database
│   └── database_helper.dart
│
├── enums/                     # Type-safe enumerations
│   ├── auth_status.dart
│   ├── loading_status.dart
│   ├── user_role.dart
│   └── app_environment.dart
│
├── exceptions/                # Custom exceptions
│   ├── app_exception.dart
│   ├── auth_exception.dart
│   ├── network_exception.dart
│   └── validation_exception.dart
│
├── l10n/                      # Localization strings
│   ├── app_en.arb
│   └── [other languages].arb
│
├── mixins/                    # Reusable mixins
│   ├── validation_mixin.dart
│   └── loading_mixin.dart
│
├── models/                    # Data models
│   ├── user_model.dart
│   ├── api_response_model.dart
│   ├── auth_response_model.dart
│   ├── app_settings_model.dart
│   └── notification_model.dart
│
├── providers/                 # State management
│   ├── app_state_provider.dart
│   ├── auth_provider.dart
│   ├── user_provider.dart
│   ├── theme_provider.dart
│   ├── connectivity_provider.dart
│   └── notification_provider.dart
│
├── repositories/              # Data access layer
│   ├── base_repository.dart
│   ├── auth_repository.dart
│   ├── user_repository.dart
│   ├── notification_repository.dart
│   └── settings_repository.dart
│
├── screens/                   # UI screens (28 total)
│   ├── auth/                  # Authentication screens
│   ├── home/                  # Home screen
│   ├── profile/               # Profile screens
│   ├── settings/              # Settings screens
│   ├── notifications/         # Notification screens
│   ├── search/                # Search screen
│   ├── info/                  # Information screens
│   ├── onboarding/            # Onboarding flow
│   ├── splash/                # Splash screen
│   └── common/                # Error, maintenance, etc.
│
├── services/                  # Business logic layer
│   ├── api/
│   │   ├── api_exceptions.dart
│   │   ├── auth_interceptor.dart
│   │   ├── logging_interceptor.dart
│   │   └── retry_interceptor.dart
│   ├── api_client.dart
│   ├── logger_service.dart
│   ├── local_storage_service.dart
│   ├── auth_service.dart
│   ├── secure_storage_service.dart
│   ├── navigation_service.dart
│   ├── connectivity_service.dart
│   ├── notification_service.dart
│   ├── analytics_service.dart
│   └── permission_service.dart
│
├── utils/                     # Utility functions
│   ├── app_utils.dart
│   ├── error_handler.dart
│   ├── extensions.dart
│   ├── validators.dart
│   ├── formatters.dart
│   └── debouncer.dart
│
└── widgets/                   # Reusable widgets
    ├── buttons/
    ├── inputs/
    ├── cards/
    ├── feedback/
    ├── loading/
    ├── layout/
    └── common/
```

## 🔧 Key Files

### Configuration
- `lib/config/app_config.dart` - App settings
- `lib/config/routes.dart` - Route definitions
- `lib/config/theme_config.dart` - Theme configuration

### Entry Points
- `lib/main.dart` - Application entry
- `lib/app.dart` - Root widget with providers
- `lib/injection.dart` - Dependency injection setup

### State Management
- `lib/providers/auth_provider.dart` - Authentication state
- `lib/providers/user_provider.dart` - User profile state
- `lib/providers/theme_provider.dart` - Theme state

### API & Data
- `lib/services/api_client.dart` - HTTP client
- `lib/repositories/auth_repository.dart` - Auth data layer
- `lib/models/user_model.dart` - Data models

## 📱 Pre-built Screens

### Authentication (7 screens)
- Splash Screen
- Onboarding
- Login
- Signup
- Forgot Password
- Reset Password
- Change Password
- Delete Account

### Main App (6 screens)
- Home
- Profile
- Edit Profile
- Settings
- Notifications
- Search

### Information (7 screens)
- About
- Contact Us
- Privacy Policy
- Terms & Conditions
- Help/FAQ
- Feedback
- What's New

### Error States (4 screens)
- Error Screen
- 404 Not Found
- No Connection
- Maintenance

## 🔐 Security Features

- Secure token storage (flutter_secure_storage)
- Password validation (strength checking)
- Email verification
- Account deletion (GDPR compliant)
- Token refresh mechanism
- Biometric authentication ready
- Certificate pinning support

## 🌐 Localization

Supports 10 languages by default:
- English
- Spanish
- French
- German
- Italian
- Portuguese
- Japanese
- Chinese
- Korean

Add more languages in `l10n.yaml` and create corresponding `.arb` files.

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/services/api_client_test.dart

# Generate coverage report
flutter test --coverage
```

## 📦 Build

### Development Build
```bash
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build ios --flavor dev -t lib/main_dev.dart
```

### Production Build
```bash
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
```

## 🛠️ Development Scripts

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Clean build
flutter clean && flutter pub get && flutter pub run build_runner build

# Generate splash screen
flutter pub run flutter_native_splash:create

# Generate app icons
flutter pub run flutter_launcher_icons
```

## 🐛 Debugging

### Enable Debug Logging
Set `DEBUG_MODE=true` in `.env` file to see:
- HTTP requests/responses
- State changes
- Error details

### Use Logger Service
```dart
LoggerService.debug('Debug message');
LoggerService.info('Info message');
LoggerService.warning('Warning message');
LoggerService.error('Error message', error: exception);
```

## 📚 Architecture & Patterns

### Clean Architecture
- Presentation Layer (Screens, Widgets)
- State Management Layer (Providers)
- Domain/Business Layer (Services)
- Data Layer (Repositories)
- Infrastructure Layer (APIs, Storage)

### Design Patterns
- Provider Pattern (State Management)
- Repository Pattern (Data Access)
- Service Locator (Dependency Injection)
- Singleton (Services)
- Factory (Model creation)

### Best Practices
- Immutable models with Freezed
- Type-safe enums with extensions
- Custom exceptions for error handling
- Validation mixins for form validation
- Loading state management
- Error boundaries

## 🚀 Performance Tips

1. **Lazy Loading** - Load screens on demand
2. **Image Optimization** - Use cached_network_image
3. **Code Splitting** - Separate features into packages
4. **State Management** - Keep providers focused
5. **Database Indexing** - Index frequently queried fields
6. **API Caching** - Implement smart caching strategy

## 📖 Learn More

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)

## 📄 License

MIT License - See LICENSE file

## 👥 Contributing

Contributions are welcome! Please follow the code style and architecture patterns.

## 🤝 Support

For issues and questions:
1. Check existing documentation
2. Review similar implementations
3. Open an issue with details
4. Provide code examples

## ✅ Checklist for New Projects

- [ ] Update app name in pubspec.yaml
- [ ] Update package name
- [ ] Update API base URLs
- [ ] Configure Firebase (if using)
- [ ] Update app colors and theme
- [ ] Add app icons and splash screen
- [ ] Configure localization languages
- [ ] Set up environment variables
- [ ] Implement custom services
- [ ] Add custom widgets
- [ ] Configure analytics
- [ ] Set up error tracking
- [ ] Add unit and widget tests
- [ ] Configure CI/CD pipeline

---

**Happy coding! 🚀**

Built with ❤️ using Flutter
