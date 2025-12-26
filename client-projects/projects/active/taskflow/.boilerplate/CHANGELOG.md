# Flutter Small App Boilerplate - Changelog

All notable changes to this boilerplate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-01

### Added

#### Core Architecture
- Service Locator pattern using GetIt for dependency injection
- Clean Architecture layer separation (UI → State → Service → Repository → Model)
- Provider pattern for state management using flutter_provider
- Comprehensive error handling with ApiException hierarchy
- Structured logging system (LoggerService)

#### Configuration & Setup
- Environment-based configuration (dev/staging/production)
- Asset path constants organized in nested classes
- Material Design 3 theming with light/dark mode support
- App colors, sizing, and spacing constants
- Named routes with RouteGenerator pattern

#### Services (Core)
- ApiClient with Dio HTTP client
- Authentication service with token management
- Secure storage service for credentials
- Local storage service (SharedPreferences)
- Connectivity monitoring service
- Notification service for push & local notifications
- Logger service with structured logging

#### Repositories (Core)
- Authentication repository
- User management repository
- Settings repository
- Notification repository
- Base repository pattern for code reuse

#### State Management
- App state provider
- Authentication provider with role-based access
- Theme provider with light/dark mode switching
- Connectivity provider for network monitoring

#### API & Networking
- Custom Dio HTTP client with error handling
- Request/response interceptors
- Automatic token refresh mechanism
- Retry interceptor with exponential backoff
- Comprehensive exception handling

#### Enums & Constants
- AuthStatus enum with 8 states
- LoadingStatus enum with 7 states
- UserRole enum with 6 roles
- Extension methods for convenient state checking

#### Build Infrastructure
- Code generator script for rapid file scaffolding
- Service locator setup automation
- Dependency injection pattern

#### Documentation
- Complete boilerplate guide with 100+ file specifications
- Implementation status tracking
- Architecture decision records framework
- Version management system

### Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # Root widget setup
├── injection.dart               # Dependency injection
├── config/
│   ├── routes.dart             # Named routes
│   ├── env.dart                # Environment config
│   ├── assets.dart             # Asset constants
│   ├── theme_config.dart       # Theme setup
│   ├── app_colors.dart         # Color palette
│   ├── app_strings.dart        # UI text constants
│   └── app_sizes.dart          # Spacing & sizing
├── enums/
│   ├── auth_status.dart        # Authentication states
│   ├── loading_status.dart     # Loading states
│   └── user_role.dart          # User roles
├── services/
│   ├── api/
│   │   ├── api_client.dart     # HTTP client
│   │   ├── api_exceptions.dart # Exception types
│   │   ├── auth_interceptor.dart
│   │   ├── logging_interceptor.dart
│   │   └── retry_interceptor.dart
│   ├── auth_service.dart
│   ├── storage_service.dart
│   ├── secure_storage_service.dart
│   ├── connectivity_service.dart
│   ├── notification_service.dart
│   ├── permission_service.dart
│   ├── biometric_service.dart
│   └── logger_service.dart
├── repositories/
│   ├── auth_repository.dart
│   ├── user_repository.dart
│   ├── settings_repository.dart
│   └── notification_repository.dart
├── models/
│   ├── user.dart
│   ├── auth_response.dart
│   └── [additional models]
├── providers/
│   ├── app_state_provider.dart
│   ├── auth_provider.dart
│   ├── theme_provider.dart
│   └── connectivity_provider.dart
├── widgets/
│   ├── buttons/
│   ├── inputs/
│   ├── feedback/
│   ├── loading/
│   ├── layout/
│   └── common/
├── screens/
│   ├── splash/
│   ├── auth/
│   ├── home/
│   └── [additional screens]
├── utilities/
│   ├── validators.dart
│   ├── extensions.dart
│   ├── helpers.dart
│   └── constants.dart
└── mixins/
    └── [mixins for shared behavior]

.boilerplate/
├── VERSION                      # Current version
├── CHANGELOG.md                 # This file
├── UPGRADE_GUIDE.md            # Migration guide
└── generators/
    └── flutter/
        └── generate.sh         # Code generator
```

### Dependencies Added

**Core Framework:**
- flutter: ^3.16.0
- flutter_dotenv: ^5.1.0
- sqflite_common_ffi: ^2.2.0

**State Management:**
- provider: ^6.0.0
- get_it: ^7.5.0

**HTTP & Networking:**
- dio: ^5.3.0

**Storage:**
- shared_preferences: ^2.2.0
- flutter_secure_storage: ^9.0.0

**Utilities:**
- intl: ^0.18.0
- connectivity_plus: ^5.0.0

**Notifications:**
- flutter_local_notifications: ^16.0.0

**Permissions:**
- permission_handler: ^11.4.0

**Biometrics:**
- local_auth: ^2.1.0

**Development:**
- build_runner: ^2.4.0
- freezed: ^2.4.0
- json_serializable: ^6.7.0
- mockito: ^5.4.0

### Notes for Contributors

1. **Semantic Versioning**: Follow MAJOR.MINOR.PATCH format
   - MAJOR: Breaking changes
   - MINOR: New features (backward compatible)
   - PATCH: Bug fixes

2. **Update Process**: Follow UPGRADE_GUIDE.md for migration steps

3. **Code Generation**: Run after model changes:
   ```bash
   flutter pub run build_runner build
   ```

4. **Documentation**: Update CHANGELOG.md before releases

---

## Version Scheme

- **1.0.0**: Initial stable release with clean architecture foundation
- Future versions will follow semantic versioning guidelines

### How to Update Changelog

When making changes to the boilerplate:

1. Add your changes under `## [Unreleased]` section
2. Before release, change `## [Unreleased]` to `## [X.Y.Z] - YYYY-MM-DD`
3. Create new `## [Unreleased]` section for future changes

### Categories

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security vulnerability fixes
- **Performance**: Performance improvements
- **Documentation**: Documentation updates

---

**Last Updated**: 2025-12-01
**Current Maintainer**: Vivacity Digital Team
