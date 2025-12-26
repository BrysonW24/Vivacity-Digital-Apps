# Micro Flutter App Template

**Tier:** Micro-Budget
**Platform:** Hybrid (Flutter - Android, iOS, Web)
**Timeline:** 1-2 weeks
**Budget:** $500-2,000

## Description

A production-ready 6-page Flutter app template for simple projects, MVPs, and proof-of-concepts. Based on the Journal App architecture, stripped down to essential features.

## Features

### Core Functionality
- ✅ 6 essential screens (Home, List, Detail, Settings, About, Contact)
- ✅ Bottom navigation
- ✅ Local data storage (SQLite)
- ✅ Light/Dark theme support
- ✅ Search functionality
- ✅ Export to PDF
- ✅ Material Design 3

### Tech Stack
- **Framework:** Flutter 3.19+
- **State Management:** Provider & Riverpod
- **Database:** SQLite (sqflite)
- **Storage:** SharedPreferences
- **Platforms:** Android, iOS, Web

### Dependencies (Minimal)
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  flutter_riverpod: ^2.3.6
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  shared_preferences: ^2.2.0
  intl: ^0.19.0
  pdf: ^3.8.4
  share_plus: ^7.2.2
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
├── providers/                   # State management
├── screens/                     # UI screens
│   ├── home_screen.dart
│   ├── list_screen.dart
│   ├── detail_screen.dart
│   ├── settings_screen.dart
│   ├── about_screen.dart
│   └── contact_screen.dart
├── widgets/                     # Reusable widgets
└── utils/                       # Utilities & helpers

assets/
├── images/                      # App images
└── icons/                       # App icons
```

## Quick Start

### 1. Copy Template
```bash
cp -r templates/platforms/hybrid/micro your-project-name
cd your-project-name
```

### 2. Rebrand the App

**Update pubspec.yaml:**
```yaml
name: your_app_name
description: Your app description
version: 1.0.0+1
```

**Update Android package:**
```kotlin
// android/app/build.gradle.kts
applicationId = "com.yourclient.appname"
namespace = "com.yourclient.appname"
```

**Update iOS bundle:**
```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### 3. Replace Branding

Search and replace across the project:
- `journal_app` → `your_app_name`
- `Journal App` → `Your App Name`
- `com.vivacitydigital.journal_app` → `com.yourclient.appname`

### 4. Update Assets
```bash
# Replace app icon
# Place your icon at: assets/images/app_icon.png

# Generate launcher icons
flutter pub run flutter_launcher_icons:main
```

### 5. Install Dependencies
```bash
flutter pub get
```

### 6. Run the App
```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## Customization Guide

### Adding a New Screen

1. Create screen file:
```dart
// lib/screens/new_screen.dart
import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Screen')),
      body: Center(child: const Text('Your content here')),
    );
  }
}
```

2. Add to navigation (if needed):
```dart
// lib/main.dart - Update bottom nav
final List<Widget> _pages = [
  const HomeScreen(),
  const ListScreen(),
  const NewScreen(),  // Add here
  const SettingsScreen(),
];
```

### Changing Theme Colors

```dart
// lib/main.dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,  // Change this
    brightness: Brightness.light,
  ),
  useMaterial3: true,
),
```

### Modifying Database Schema

```dart
// Update your model in lib/models/
// Then update database creation in providers
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (requires Mac)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## What's Included

### Screens
1. **Home** - Welcome/dashboard with feature overview
2. **List** - Scrollable list with search
3. **Detail** - Detail view with full content
4. **Settings** - App preferences (theme, etc.)
5. **About** - App info and version
6. **Contact** - Feedback/contact form

### Features
- Local database with CRUD operations
- Search/filter functionality
- Export data to PDF
- Share functionality
- Theme persistence
- Form validation
- Error handling

### Pre-configured
- ✅ Android signing setup
- ✅ iOS configuration
- ✅ App icons
- ✅ Splash screens
- ✅ Privacy policy template
- ✅ Analysis options (linting)

## What to Change

### Required Changes
- [ ] App name in `pubspec.yaml`
- [ ] Android `applicationId`
- [ ] iOS `PRODUCT_BUNDLE_IDENTIFIER`
- [ ] App icons
- [ ] Theme colors
- [ ] Privacy policy content
- [ ] About page details

### Optional Changes
- [ ] Add/remove screens
- [ ] Customize database schema
- [ ] Add API integration
- [ ] Add authentication
- [ ] Enhance UI/animations

## Deployment Checklist

### Before Release
- [ ] Test on physical devices (Android & iOS)
- [ ] Update version number
- [ ] Generate signed APK/AAB
- [ ] Create app store assets (screenshots, etc.)
- [ ] Write store listing descriptions
- [ ] Set up app signing certificates
- [ ] Test all features thoroughly

### Store Submission
- [ ] Google Play Store setup
- [ ] Apple App Store setup (requires Mac)
- [ ] Submit for review
- [ ] Monitor for feedback

## Support & Resources

- **Flutter Docs:** https://docs.flutter.dev
- **Material Design:** https://m3.material.io
- **Package Docs:** https://pub.dev

## License

Template provided by Vivacity Digital for client projects.

---

**Based on:** Journal App
**Created:** 2024
**Last Updated:** 2024-11-07
