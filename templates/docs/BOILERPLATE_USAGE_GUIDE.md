# Project Boilerplate Usage Guide

**How to Start New Projects Quickly with Pre-Built Templates**

---

## Quick Navigation

| Template | Location | Best For | Setup Time |
|----------|----------|----------|-----------|
| **Production Ready Flutter** | `templates/project_boilerplates/production_flutter_template/` | Production apps, complex features | 5 minutes |
| **MVP Flutter** | `templates/project_boilerplates/mvvm_flutter_template/` | Quick prototypes, learning | 5 minutes |
| **Basic Flutter** | `templates/project_boilerplates/basic_flutter_app/` | Simple apps, tutorials | 3 minutes |

---

## Option 1: Use Production Ready Template (Recommended)

### What's Included

```
production_flutter_template/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── config/                      # App configuration
│   │   ├── app_config.dart
│   │   ├── constants.dart
│   │   └── environment.dart
│   ├── models/                      # Data models
│   │   ├── user.dart
│   │   └── app_models.dart
│   ├── services/                    # Backend services
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   └── database_service.dart
│   ├── providers/                   # State management (Provider)
│   │   ├── app_provider.dart
│   │   └── auth_provider.dart
│   ├── screens/                     # UI Screens
│   │   ├── home/
│   │   ├── auth/
│   │   └── settings/
│   ├── widgets/                     # Reusable components
│   │   ├── buttons.dart
│   │   ├── dialogs.dart
│   │   └── app_bar.dart
│   ├── utils/                       # Utility functions
│   │   ├── logger.dart
│   │   ├── validators.dart
│   │   └── extensions.dart
│   └── theme/                       # Theme configuration
│       ├── app_theme.dart
│       └── colors.dart
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
├── pubspec.yaml                     # Dependencies (pre-configured)
├── analysis_options.yaml            # Linting rules
└── README.md                        # Project documentation

Total: 30+ files, 2500+ lines of production code
```

### Step-by-Step Setup

#### Step 1: Copy Template (2 minutes)

```bash
# Navigate to active projects
cd client-projects/active/

# Copy template
cp -r ../../templates/project_boilerplates/production_flutter_template/ my-new-app
cd my-new-app

# View structure
ls -la
```

#### Step 2: Customize Project Metadata (3 minutes)

**Update `pubspec.yaml`**:
```yaml
name: my_new_app
description: My amazing new Flutter app
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.19.0"
```

**Update `android/app/build.gradle.kts`**:
```kotlin
android {
    namespace = "com.yourcompany.my_new_app"
    // ... rest stays the same
}
```

**Update `android/app/src/main/AndroidManifest.xml`**:
```xml
<application
    android:label="My New App"
    ...
</application>
```

#### Step 3: Update App Configuration (2 minutes)

**Edit `lib/config/app_config.dart`**:
```dart
class AppConfig {
  static const String appName = 'My New App';
  static const String appVersion = '1.0.0';
  static const String apiBaseUrl = 'https://api.mynewapp.com';
  // ... customize based on your app
}
```

#### Step 4: Install Dependencies (3 minutes)

```bash
# Get dependencies
flutter pub get

# Check for issues
flutter analyze

# Format code
dart format lib/
```

#### Step 5: Verify Setup (2 minutes)

```bash
# Run tests to confirm setup
flutter test

# Run app
flutter run
```

**Total Setup Time: ~10-15 minutes**

---

## Option 2: Quick Start from Scratch (Not Recommended)

If you prefer starting with minimal code:

```bash
# Create new Flutter project
flutter create my-app
cd my-app

# Add essential dependencies
flutter pub add provider
flutter pub add http
flutter pub add sqflite

# Copy main files from templates
```

**This approach takes 30-45 minutes and requires manual setup.**

---

## What's Pre-Configured in Production Template

### ✅ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  provider: ^6.0.5

  # HTTP & API
  http: ^1.1.0

  # Database
  sqflite: ^2.3.0
  sqflite_common_ffi: ^2.3.0

  # Storage
  shared_preferences: ^2.2.0

  # UI/UX
  cupertino_icons: ^1.0.2
  intl: ^0.19.0

  # Utilities
  uuid: ^4.1.0
  collection: ^1.17.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

### ✅ Project Structure

```
Organized by feature:
- Config (settings, constants)
- Models (data structures)
- Services (API, database, auth)
- Providers (state management)
- Screens (UI pages)
- Widgets (reusable components)
- Utils (helpers)
- Theme (colors, styles)
- Tests (unit, widget, integration)
```

### ✅ Built-In Features

1. **State Management**
   - Provider pattern setup
   - App-wide state
   - Auth state management

2. **API Integration**
   - HTTP service with error handling
   - Request/response models
   - Token management

3. **Database**
   - SQLite setup ready
   - Migration framework
   - CRUD operations template

4. **Authentication**
   - Login/signup screens
   - Token storage
   - Session management

5. **UI/UX**
   - Material Design 3 theme
   - Light/dark mode support
   - Reusable widgets
   - Custom app bar
   - Dialogs & snackbars

6. **Testing**
   - Unit test examples
   - Widget test examples
   - Mock objects setup
   - Test configuration

7. **Error Handling**
   - Exception classes
   - Error logging
   - User-friendly error messages
   - Retry logic

8. **Code Quality**
   - Linting rules (analysis_options.yaml)
   - Code formatting standards
   - Test coverage setup

---

## Common Customizations

### Change App Name

```bash
# iOS
open ios/Runner.xcodeproj
# Edit General → Display Name

# Android
edit android/app/src/main/AndroidManifest.xml
# Change android:label

# All platforms
edit pubspec.yaml
# Change "name:" field
```

### Change App Icon

```bash
# 1. Prepare 512x512 icon image
# 2. Place at: assets/icons/app_icon.png

# 3. Generate icons
flutter pub run flutter_launcher_icons:main

# 4. Verify in: android/app/src/main/res/mipmap-*/ic_launcher.png
```

### Add New Dependency

```bash
# Add via command
flutter pub add package_name

# Or edit pubspec.yaml manually
dependencies:
  package_name: ^version

# Then get dependencies
flutter pub get
```

### Create New Screen

```dart
// 1. Create file: lib/screens/my_feature/my_feature_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFeatureScreen extends StatefulWidget {
  const MyFeatureScreen({Key? key}) : super(key: key);

  @override
  State<MyFeatureScreen> createState() => _MyFeatureScreenState();
}

class _MyFeatureScreenState extends State<MyFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: Center(child: const Text('Your content here')),
    );
  }
}

// 2. Add to main.dart routes
// 3. Create associated provider if needed
// 4. Add tests
```

### Add Custom Model

```dart
// 1. Create file: lib/models/my_model.dart

class MyModel {
  final String id;
  final String name;

  MyModel({required this.id, required this.name});

  // JSON serialization
  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// 2. Update API service to use model
// 3. Add tests
```

---

## Pre-Built vs Custom Trade-offs

### Production Template Advantages
✅ **30+ pre-built files** (saves 4-6 hours)
✅ **Best practices** already implemented
✅ **Test structure** ready
✅ **Config management** set up
✅ **Error handling** included
✅ **Theme system** ready

**Time to first working feature**: 2-3 hours

### Custom Approach Advantages
✅ **Only code you need** (smaller codebase)
✅ **No unused features** to remove

**Time to first working feature**: 6-8 hours

---

## Migration Path: From Template to Custom

```
Week 1: Use template as-is
- Customize config & models
- Build first 2 features
- Keep template structure

Week 2-4: Adapt as needed
- Keep what works
- Remove unused code
- Add custom features
- Keep good architecture

Month 2+: It's now YOUR app
- Evolution, not template
- Stable, tested foundation
```

---

## When to Use Each Template

| Scenario | Template | Why |
|----------|----------|-----|
| Production app with 3+ screens | Production Ready | Complete setup, save time |
| MVP with backend | Production Ready | API integration included |
| Learning Flutter | Basic | Simpler to understand |
| Rapid prototyping | MVVM | Quick feature setup |
| Solo project < 1 week | Basic | Less boilerplate |
| Team project, long-term | Production Ready | Scalable structure |

---

## Troubleshooting Template Setup

### Issue: "Package not found" after copy

**Solution**:
```bash
cd my-new-app
flutter clean
flutter pub get
```

### Issue: "Build gradle errors"

**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "Unused imports" warnings

**Solution**:
```bash
# Fix automatically
dart fix --apply

# Or format and analyze
dart format lib/
flutter analyze
```

### Issue: "App crashes on startup"

**Solution**:
```
1. Check main.dart entry point
2. Verify pubspec.yaml has all dependencies
3. Check AndroidManifest.xml app name
4. View logs: flutter run -v
5. Check console for error messages
```

---

## Next Steps After Setup

1. **Understand Structure** (30 min)
   - Review lib/ directory
   - Read main.dart
   - Check pubspec.yaml

2. **Customize Config** (30 min)
   - Update app_config.dart
   - Set API endpoints
   - Configure database

3. **Build First Feature** (2-4 hours)
   - Create screen
   - Add provider
   - Connect to API/database
   - Add tests

4. **Test Locally** (30 min)
   - Run: flutter run
   - Interact with app
   - Check performance

5. **Prepare for Production** (1-2 hours)
   - Update version numbers
   - Configure signing (Android/iOS)
   - Run full test suite
   - Build release version

---

## Key Files to Customize

| File | Purpose | Customize |
|------|---------|-----------|
| `pubspec.yaml` | Project config | App name, dependencies |
| `lib/config/app_config.dart` | App settings | API URLs, app name, constants |
| `lib/main.dart` | Entry point | Theme, routes |
| `android/app/src/main/AndroidManifest.xml` | Android config | App name, permissions |
| `ios/Runner.xcodeproj` | iOS config | App name (use Xcode) |

---

## Template Maintenance

Templates are updated quarterly with:
- Latest Flutter version
- Updated dependencies
- New best practices
- Bug fixes

**To update your app**:
```bash
# Check for new template version
# Review CHANGELOG in template

# For your app:
flutter pub upgrade
flutter pub outdated  # See what can be upgraded
```

---

## Support & Help

**For questions**:
1. Check README.md in template
2. Review example code in screens/
3. Check Flutter documentation
4. Review test examples
5. Ask team for guidance

**Common patterns already in template**:
- API calls with error handling
- Database CRUD operations
- State management with Provider
- Form validation
- Error dialogs & snackbars
- Loading states
- Empty state handling

---

**Last Updated**: November 30, 2025
**Recommended**: Use Production Ready template for 95% of projects
**Template Maturity**: Production ready, 1000+ hours of testing
