# Android Micro Template Configuration

**Platform:** Android (Native Configuration for Flutter)
**Tier:** Micro-Budget
**Min SDK:** 21 (Android 5.0 Lollipop)
**Target SDK:** 35 (Android 15)

## Overview

This folder contains the Android-specific configuration from the Journal App template, optimized for micro-budget projects.

## What's Included

### Configuration Files
- `app/build.gradle.kts` - App-level Gradle configuration
- `build.gradle.kts` - Project-level Gradle configuration
- `settings.gradle.kts` - Gradle settings
- `gradle.properties` - Gradle properties
- `key.properties` - Signing key configuration (template)

### Android Manifest
- Configured permissions
- Application name and icon
- Launch configuration
- Internet permissions (if needed)

### Signing Configuration
- Release signing setup
- Debug signing
- ProGuard rules for code obfuscation

### Build Configuration
```kotlin
android {
    compileSdk = 35
    namespace = "com.vivacitydigital.your_app"

    defaultConfig {
        applicationId = "com.vivacitydigital.your_app"
        minSdk = 21
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
    }
}
```

## Usage

### For Hybrid Flutter Apps
This android folder should be placed in the root of your Flutter project:
```
your_flutter_app/
├── android/           ← This folder
├── lib/
├── assets/
└── pubspec.yaml
```

### For Native Android Apps
Copy the configuration structure and adapt for your native Android project.

## Customization

### 1. Update Package Name
```kotlin
// app/build.gradle.kts
applicationId = "com.yourclient.appname"
namespace = "com.yourclient.appname"
```

### 2. Update App Name
```xml
<!-- app/src/main/AndroidManifest.xml -->
<application
    android:label="Your App Name"
    ...>
```

### 3. Configure Signing

Create `key.properties` in android/ folder:
```properties
storePassword=your-keystore-password
keyPassword=your-key-password
keyAlias=upload
storeFile=../upload-keystore.jks
```

Generate keystore:
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 4. Update Version
```kotlin
// app/build.gradle.kts
versionCode = 2
versionName = "1.0.1"
```

## Building

### Debug Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## Key Features

### ProGuard/R8
- Code shrinking enabled
- Resource shrinking enabled
- Obfuscation configured

### Multi-Dex
- Enabled for apps with many dependencies
- Handles 65K method limit

### ABI Filters
Configured for:
- `armeabi-v7a` (32-bit ARM)
- `arm64-v8a` (64-bit ARM)
- `x86_64` (64-bit Intel)

### App Bundle Optimization
- Language splits enabled
- Density splits enabled
- ABI splits enabled

## Permissions

Default permissions included:
- `INTERNET` - For API calls (if needed)
- `READ_EXTERNAL_STORAGE` - For file access (if using)
- `WRITE_EXTERNAL_STORAGE` - For saving files (if using)

## Dependencies

Uses Gradle Kotlin DSL for:
- Better type safety
- IDE support
- Modern syntax

## Troubleshooting

### Build Fails with "Duplicate Class" Error
- Check for dependency conflicts
- Run `./gradlew :app:dependencies`

### Signing Not Working
- Verify `key.properties` path is correct
- Ensure keystore file exists
- Check passwords are correct

### Out of Memory
```gradle
// gradle.properties
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m
```

## Play Store Submission

1. Build signed app bundle: `flutter build appbundle --release`
2. File location: `build/app/outputs/bundle/release/app-release.aab`
3. Upload to Play Console
4. Complete store listing
5. Submit for review

## Notes

- Always use App Bundle (AAB) for Play Store
- APK is good for testing/distribution outside Play Store
- Keep your keystore file secure and backed up
- Never commit `key.properties` or keystore files to git

---

**Template Base:** Journal App Android Configuration
**Last Updated:** 2024-11-07
