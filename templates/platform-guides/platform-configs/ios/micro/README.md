# iOS Micro Template Configuration

**Platform:** iOS (Native Configuration for Flutter)
**Tier:** Micro-Budget
**Min iOS Version:** 12.0
**Target iOS Version:** Latest

## Overview

Complete iOS configuration from the Journal App template. This folder contains all necessary files to build and deploy a Flutter app to iOS devices and the App Store.

## What's Included

### Project Files
- `Runner.xcodeproj/` - Xcode project configuration
- `Runner.xcworkspace/` - Workspace with CocoaPods integration
- `Runner/` - Main app target
  - `Info.plist` - App metadata and permissions
  - `AppDelegate.swift` - App lifecycle management
  - `Assets.xcassets/` - App icons and launch images
  - `Base.lproj/` - Storyboards and localized resources
- `Podfile` - CocoaPods dependencies
- `RunnerTests/` - Unit test target

### Current Configuration
- **Bundle Identifier:** `com.vivacitydigital.journalApp`
- **Display Name:** journal_app
- **iOS Deployment Target:** 12.0
- **Swift Version:** 5.0

## Usage

### For Flutter Projects
Copy this ios folder to your Flutter project root:
```
your_flutter_app/
├── ios/           ← This folder
├── android/
├── lib/
└── pubspec.yaml
```

## Customization

### 1. Update Bundle Identifier

**In Xcode (Recommended):**
1. Open `Runner.xcworkspace` in Xcode
2. Select Runner project in sidebar
3. Select Runner target
4. General tab → Bundle Identifier
5. Change to: `com.yourclient.appname`

**Or manually in project.pbxproj:**
Search and replace:
- `com.vivacitydigital.journalApp` → `com.yourclient.appname`

### 2. Update App Display Name

```xml
<!-- Runner/Info.plist -->
<key>CFBundleDisplayName</key>
<string>Your App Name</string>

<key>CFBundleName</key>
<string>Your App Name</string>
```

### 3. Set Version Numbers

```xml
<!-- Runner/Info.plist -->
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>

<key>CFBundleVersion</key>
<string>1</string>
```

Or via Xcode:
- General tab → Version: 1.0.0
- General tab → Build: 1

### 4. Configure App Icons

Replace icons in `Runner/Assets.xcassets/AppIcon.appiconset/`:

Required sizes:
- 1024x1024 (App Store)
- 180x180 (iPhone @3x)
- 167x167 (iPad Pro)
- 152x152 (iPad @2x)
- 120x120 (iPhone @2x/@3x)
- 87x87 (iPhone @3x notification)
- 80x80 (iPad @2x spotlight)
- 76x76 (iPad @1x)
- 60x60 (iPhone @1x)
- 58x58 (iPhone @2x settings)
- 40x40 (iPhone/iPad spotlight)
- 29x29 (iPhone/iPad settings)
- 20x20 (iPhone/iPad notification)

**Or use flutter_launcher_icons:**
```yaml
# pubspec.yaml
flutter_launcher_icons:
  ios: true
  image_path: "assets/images/app_icon.png"
```

```bash
flutter pub run flutter_launcher_icons:main
```

### 5. Update Launch Screen

Edit `Runner/Base.lproj/LaunchScreen.storyboard` in Xcode or use:
```yaml
# pubspec.yaml
flutter_native_splash:
  color: "#ffffff"
  image: assets/images/splash.png
  ios: true
```

### 6. Add Permissions

If your app needs permissions, add to `Info.plist`:

```xml
<!-- Camera -->
<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos for your journal</string>

<!-- Photo Library -->
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to save and load photos</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to save photos to your library</string>

<!-- Location -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>We use your location to tag journal entries</string>

<!-- Notifications -->
<key>NSUserNotificationsUsageDescription</key>
<string>We'll send reminders for daily journaling</string>

<!-- Microphone (if needed) -->
<key>NSMicrophoneUsageDescription</key>
<string>Record voice notes for your journal</string>

<!-- Contacts (if needed) -->
<key>NSContactsUsageDescription</key>
<string>Access contacts to share journal entries</string>
```

## CocoaPods Setup

### Install CocoaPods
```bash
sudo gem install cocoapods
pod setup
```

### Install Dependencies
```bash
cd ios
pod install
cd ..
```

### Update Pods
```bash
cd ios
pod update
cd ..
```

### Troubleshooting Pods
```bash
cd ios
pod deintegrate
rm Podfile.lock
pod install
cd ..
```

## Building

### Requirements
- **macOS** - iOS development requires a Mac
- **Xcode 14.0+** - Download from Mac App Store
- **CocoaPods** - Dependency manager
- **Apple Developer Account** - For device testing & App Store ($99/year)

### Development Build
```bash
# List available iOS devices/simulators
flutter devices

# Run on simulator
flutter run -d "iPhone 15 Pro"

# Run on connected device
flutter run -d <device-id>
```

### Debug Build
```bash
flutter build ios --debug
```

### Release Build
```bash
flutter build ios --release
```

### Build for App Store
```bash
flutter build ipa
```

Output: `build/ios/ipa/journal_app.ipa`

## Xcode Configuration

### Open in Xcode
```bash
open ios/Runner.xcworkspace
```

**Important:** Always open `.xcworkspace`, not `.xcodeproj`

### Build Settings

**Deployment Target:**
- Runner → Build Settings → iOS Deployment Target: 12.0

**Swift Version:**
- Runner → Build Settings → Swift Language Version: 5.0

**Architectures:**
- Standard architectures (arm64)

## Signing & Certificates

### Automatic Signing (Recommended for Development)
1. Open `Runner.xcworkspace` in Xcode
2. Select Runner target
3. Signing & Capabilities tab
4. Check "Automatically manage signing"
5. Select your Team

### Manual Signing (For Distribution)
1. Create App ID in Apple Developer Portal
2. Create Distribution Certificate
3. Create Provisioning Profile
4. In Xcode: Signing → Uncheck automatic
5. Select certificate and profile

### Code Signing Identity
- **Development:** Apple Development
- **Distribution:** Apple Distribution (for App Store)
- **Ad Hoc:** Apple Distribution (for TestFlight)

## App Store Submission

### Prepare for Submission

1. **Update Version**
```xml
<!-- Info.plist -->
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
```

2. **Build IPA**
```bash
flutter build ipa --release
```

3. **Archive in Xcode**
   - Open Runner.xcworkspace
   - Product → Destination → Any iOS Device
   - Product → Archive
   - Wait for archive to complete

4. **Upload to App Store Connect**
   - Window → Organizer
   - Select archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Upload

### Required Assets

**Screenshots (All Sizes):**
- 6.7" Display (iPhone 15 Pro Max): 1290 x 2796
- 6.5" Display (iPhone 11 Pro Max): 1242 x 2688
- 5.5" Display (iPhone 8 Plus): 1242 x 2208
- iPad Pro (12.9"): 2048 x 2732

**App Icon:**
- 1024 x 1024 PNG (no transparency, no rounded corners)

**App Preview Videos (Optional):**
- Up to 3 videos per device size

### App Metadata Checklist
- [ ] App name (30 characters max)
- [ ] Subtitle (30 characters max)
- [ ] Description (4000 characters max)
- [ ] Keywords (100 characters max)
- [ ] Screenshots (all required sizes)
- [ ] App icon (1024x1024)
- [ ] Privacy policy URL
- [ ] Support URL
- [ ] App category
- [ ] Content rating
- [ ] Copyright
- [ ] Contact information

## Testing

### Simulator Testing
```bash
# List simulators
flutter emulators

# Run on specific simulator
flutter run -d "iPhone-15-Pro"
```

### Device Testing
1. Connect iPhone/iPad via USB
2. Trust computer on device
3. Run: `flutter run`
4. Accept developer certificate on device (Settings → General → Device Management)

### TestFlight (Beta Testing)
1. Upload build to App Store Connect
2. Wait for processing (~10-30 mins)
3. Add internal testers (up to 100)
4. Add external testers (up to 10,000)
5. Submit external testing for review
6. Testers receive invite email
7. They download TestFlight app
8. Install your beta build

## Common Configuration

### Supported Orientations

```xml
<!-- Info.plist - Portrait only -->
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>

<!-- All orientations -->
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

### Dark Mode

```xml
<!-- Support dark mode -->
<key>UIUserInterfaceStyle</key>
<string>Automatic</string>

<!-- Force light mode -->
<key>UIUserInterfaceStyle</key>
<string>Light</string>
```

### Status Bar

```xml
<key>UIStatusBarStyle</key>
<string>UIStatusBarStyleDefault</string>
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
```

## Troubleshooting

### Build Fails
```bash
# Clean Flutter
flutter clean

# Clean iOS
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Clean Xcode
# In Xcode: Product → Clean Build Folder
# Delete DerivedData: rm -rf ~/Library/Developer/Xcode/DerivedData

# Rebuild
flutter build ios
```

### CocoaPods Issues
```bash
cd ios
sudo gem install cocoapods
pod repo update
pod deintegrate
pod install
cd ..
```

### Provisioning Profile Errors
- Verify bundle ID matches in all places
- Check certificate is valid
- Ensure provisioning profile includes device UDID
- Try automatic signing first

### Simulator Not Working
```bash
# List simulators
xcrun simctl list

# Reset simulator
xcrun simctl erase all

# Reinstall app
flutter clean
flutter run
```

## Best Practices

### Version Management
- Increment build number for each upload
- Update version for feature releases
- Semantic versioning: MAJOR.MINOR.PATCH

### Testing
- Test on multiple device sizes
- Test on oldest supported iOS version
- Test all permissions/features
- Use TestFlight for beta testing

### Security
- Enable App Transport Security
- Use HTTPS for all network calls
- Validate SSL certificates
- Never commit certificates/keys to git

### Performance
- Optimize images (use WebP)
- Lazy load content
- Test on older devices (iPhone 8)
- Monitor memory usage

## Resources

- **Xcode:** https://developer.apple.com/xcode/
- **App Store Connect:** https://appstoreconnect.apple.com
- **Developer Portal:** https://developer.apple.com/account/
- **Guidelines:** https://developer.apple.com/app-store/review/guidelines/
- **HIG:** https://developer.apple.com/design/human-interface-guidelines/
- **Flutter iOS:** https://docs.flutter.dev/deployment/ios

---

**Template Base:** Journal App iOS Configuration
**Generated:** 2024-11-07
**Last Updated:** 2024-11-07
