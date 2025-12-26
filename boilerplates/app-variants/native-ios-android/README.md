# Native iOS/Android - Maximum Performance Boilerplate

> **Philosophy:** Built for mobile, platform-specific optimization

Production-ready native mobile boilerplates using Swift for iOS and Kotlin for Android, designed for maximum performance and platform-specific features.

## 🎯 Overview

This boilerplate is designed for teams who:
- Need maximum native performance
- Require deep platform integration
- Want platform-specific UI/UX
- Need access to latest platform features
- Build performance-critical applications

## 🚀 Quick Start

### iOS (Swift)
```bash
# Navigate to iOS project
cd boilerplates/app-variants/native-ios-android/ios

# Open in Xcode
open ios/App.xcworkspace

# Or via command line
xcodebuild -workspace App.xcworkspace -scheme App build
```

### Android (Kotlin)
```bash
# Navigate to Android project
cd boilerplates/app-variants/native-ios-android/android

# Build with Gradle
./gradlew build

# Or open in Android Studio
studio android/
```

## 📱 What's Included

### iOS Features (Swift)
- ✅ **SwiftUI** - Modern declarative UI framework
- ✅ **Combine** - Reactive programming
- ✅ **MVVM Architecture** - Clean separation of concerns
- ✅ **Coordinator Pattern** - Navigation management
- ✅ **Keychain** - Secure credential storage
- ✅ **URLSession** - Network layer
- ✅ **Core Data** - Local persistence
- ✅ **Push Notifications** - APNs integration
- ✅ **Sign in with Apple** - Native auth
- ✅ **Swift Package Manager** - Dependency management

### Android Features (Kotlin)
- ✅ **Jetpack Compose** - Modern declarative UI
- ✅ **Coroutines & Flow** - Async programming
- ✅ **MVVM Architecture** - Android Architecture Components
- ✅ **Navigation Component** - Type-safe navigation
- ✅ **Encrypted SharedPreferences** - Secure storage
- ✅ **Retrofit + OkHttp** - Network layer
- ✅ **Room Database** - Local persistence
- ✅ **Firebase Cloud Messaging** - Push notifications
- ✅ **Google Sign-In** - Native auth
- ✅ **Gradle** - Build system

## 🏗️ Project Structure

### iOS Structure
```
ios/
├── App/
│   ├── Core/              # Core app setup
│   ├── Features/          # Feature modules
│   │   ├── Auth/
│   │   ├── Home/
│   │   └── Profile/
│   ├── Shared/            # Shared components
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   ├── Models/
│   │   └── Services/
│   ├── Resources/         # Assets, fonts, etc.
│   └── Utils/             # Utility classes
├── AppTests/              # Unit tests
└── AppUITests/            # UI tests
```

### Android Structure
```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/app/
│   │   │   │   ├── core/       # Core setup
│   │   │   │   ├── features/   # Feature modules
│   │   │   │   │   ├── auth/
│   │   │   │   │   ├── home/
│   │   │   │   │   └── profile/
│   │   │   │   ├── shared/     # Shared code
│   │   │   │   │   ├── ui/
│   │   │   │   │   ├── data/
│   │   │   │   │   └── domain/
│   │   │   │   └── utils/
│   │   │   └── res/            # Resources
│   │   ├── test/               # Unit tests
│   │   └── androidTest/        # Instrumented tests
└── build.gradle
```

## 🎨 Architecture

Both platforms follow Clean Architecture with MVVM:

```
View Layer (SwiftUI/Compose)
    ↓
ViewModel Layer (Observable/StateFlow)
    ↓
Repository Layer (Data abstraction)
    ↓
Service Layer (API/Database)
    ↓
Model Layer (Domain models)
```

## 📦 Key Dependencies

### iOS (Swift)
```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0"),
    .package(url: "https://github.com/realm/SwiftLint", from: "0.50"),
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.0")
]
```

### Android (Kotlin)
```gradle
dependencies {
    // Jetpack
    implementation "androidx.compose.ui:ui:$compose_version"
    implementation "androidx.lifecycle:lifecycle-viewmodel-compose:$lifecycle_version"

    // Networking
    implementation "com.squareup.retrofit2:retrofit:$retrofit_version"

    // Database
    implementation "androidx.room:room-runtime:$room_version"

    // DI
    implementation "com.google.dagger:hilt-android:$hilt_version"
}
```

## 🔧 Configuration

### iOS Configuration
```swift
// Config.swift
enum Config {
    static let apiURL = "https://api.example.com"
    static let apiKey = "your_api_key"

    #if DEBUG
    static let isDebug = true
    #else
    static let isDebug = false
    #endif
}
```

### Android Configuration
```kotlin
// Config.kt
object Config {
    const val API_URL = "https://api.example.com"
    const val API_KEY = BuildConfig.API_KEY

    val isDebug = BuildConfig.DEBUG
}
```

## 📱 Platform-Specific Features

### iOS Exclusive
- Face ID / Touch ID
- Apple Pay
- HealthKit integration
- ARKit support
- Handoff & Continuity
- iCloud sync

### Android Exclusive
- Material You dynamic theming
- Google Pay
- Google Fit integration
- ML Kit
- Android Auto
- Multi-window support

## 🧪 Testing

### iOS Testing
```bash
# Unit tests
xcodebuild test -workspace App.xcworkspace -scheme App -destination 'platform=iOS Simulator,name=iPhone 14'

# UI tests
xcodebuild test -workspace App.xcworkspace -scheme AppUITests
```

### Android Testing
```bash
# Unit tests
./gradlew test

# Instrumented tests
./gradlew connectedAndroidTest

# UI tests
./gradlew connectedCheck
```

## 🚢 Building for Production

### iOS Release
```bash
# Archive
xcodebuild archive -workspace App.xcworkspace -scheme App -archivePath build/App.xcarchive

# Export IPA
xcodebuild -exportArchive -archivePath build/App.xcarchive -exportPath build/ -exportOptionsPlist exportOptions.plist

# Upload to App Store
xcrun altool --upload-app -f build/App.ipa -u username -p password
```

### Android Release
```bash
# Build release APK
./gradlew assembleRelease

# Build App Bundle (for Play Store)
./gradlew bundleRelease

# Sign and align
zipalign -v -p 4 app-release-unsigned.apk app-release-aligned.apk
apksigner sign --ks keystore.jks app-release-aligned.apk
```

## 🎯 Use Cases

**Best for:**
- Performance-critical applications (games, AR/VR)
- Apps requiring latest platform features
- Platform-specific user experiences
- Apps with complex native integrations
- Large-scale enterprise applications

**Not ideal for:**
- Quick prototypes
- Small teams
- Cross-platform code sharing priority
- Limited native development experience

## 📊 Performance Comparison

| Metric | Native | Flutter | React Native |
|--------|--------|---------|--------------|
| Startup Time | ⚡⚡⚡ | ⚡⚡ | ⚡⚡ |
| Frame Rate | 60+ FPS | 60 FPS | 50-60 FPS |
| Memory Usage | Optimal | Good | Higher |
| Battery Impact | Minimal | Low | Moderate |
| App Size | Small | Medium | Large |

## 📚 Documentation

### iOS Resources
- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### Android Resources
- [Kotlin](https://kotlinlang.org/docs/)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Material Design](https://m3.material.io/)
- [Android Developers](https://developer.android.com/)

## 🔄 Code Sharing

While native apps are platform-specific, you can share:
- **Business logic** - Using Kotlin Multiplatform Mobile (KMM)
- **Data models** - JSON schema to Swift/Kotlin converters
- **API contracts** - OpenAPI/Swagger definitions
- **Design system** - Shared design tokens

## 🤝 Contributing

Contributions welcome! Please follow platform-specific guidelines:
- iOS: Follow Apple's Swift API Design Guidelines
- Android: Follow Kotlin style guide and Material Design

---

**Part of Vivacity Digital Boilerplates**
*Built for Mobile, Maximum Performance*
