# Journal App - iOS Setup Guide

This guide provides step-by-step instructions for completing iOS development and deployment setup.

## Prerequisites

- **Mac with Xcode installed** (Xcode 14.0 or later)
- **CocoaPods** (install with `sudo gem install cocoapods`)
- **iOS Deployment Target**: 12.0 or later
- **Flutter SDK**: 3.19.0 or later
- **Dart SDK**: 3.0.0 or later

## Step 1: Install iOS Dependencies

### On your Mac:

```bash
# Navigate to iOS directory
cd ios

# Install CocoaPods dependencies
pod install --repo-update

# Install Flutter-specific pods
cd ..
flutter pub get
```

## Step 2: Configure iOS Build

### Open Xcode Project

```bash
# From project root
open ios/Runner.xcworkspace
```

**Important**: Always open the `.xcworkspace` file, NOT the `.xcodeproj` file.

### Update Bundle Identifier

1. In Xcode, select "Runner" in the project navigator
2. Select "Runner" target
3. Go to "Build Settings" tab
4. Search for "Bundle Identifier"
5. Update to: `com.vivacitydigital.journalapp`

### Configure Signing

1. Select "Runner" target
2. Go to "Signing & Capabilities" tab
3. Select your development team
4. Update the bundle identifier if needed

## Step 3: Configure App Icons

The app icons should be generated using flutter_launcher_icons (already configured in pubspec.yaml).

### Generate Icons (requires this setup on iOS)

```bash
flutter clean
flutter pub get
flutter pub run flutter_launcher_icons:main
```

This will generate icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## Step 4: Update Info.plist

The `Info.plist` file is already created at `ios/Runner/Info.plist`.

### Additional Capabilities (if needed):

For features not yet implemented, you may need to add permissions:

- **Local Notifications**: Add NSUserNotificationsUsageDescription
- **File Access**: Add NSDocumentUsageDescription
- **Calendar**: Add NSCalendarsUsageDescription

Example addition to Info.plist:

```xml
<key>NSUserNotificationsUsageDescription</key>
<string>Journal App uses notifications to send you reminders for your journaling.</string>
```

## Step 5: Build for Simulator

```bash
# Build for iOS simulator
flutter build ios --simulator

# Or run directly on simulator
flutter run -d iphonesimulator
```

## Step 6: Build for Device

### Development Build

```bash
flutter build ios
```

### Release Build

```bash
flutter build ios --release
```

### App Bundle for App Store

```bash
flutter build ios --release
```

## Step 7: Prepare for App Store

### Generate Build Archive

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Runner" scheme at the top
3. Select "Generic iOS Device" as destination
4. Product → Archive
5. Validate and distribute through App Store Connect

### Generate TestFlight Build

1. After archiving, select the archive in Organizer
2. Click "Distribute App"
3. Select "App Store Connect"
4. Follow the distribution workflow
5. Upload to TestFlight for testing

## Step 8: Code Signing for Production

### Create Distribution Certificate

1. Go to [Apple Developer Account](https://developer.apple.com)
2. Create a Distribution Certificate
3. Create an App Store Provisioning Profile
4. Download both files

### Configure in Xcode

1. Xcode → Preferences → Accounts
2. Add your Apple ID
3. Download Provisioning Profiles
4. Select the distribution profile in Signing & Capabilities

## Troubleshooting

### CocoaPods Issues

```bash
# Update CocoaPods repo
pod repo update

# Clean and reinstall
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
```

### Build Failures

```bash
# Clean Flutter build
flutter clean
flutter pub get

# Clean Xcode build
cd ios
xcodebuild clean
cd ..

# Try building again
flutter build ios
```

### Signing Issues

```bash
# Check certificates
security find-identity -v -p codesigning

# Update signing in project
rm -rf ~/Library/Caches/com.apple.dt.Xcode
```

### Architecture Issues

If you see "arm64 architecture" errors in simulator:

1. Edit `ios/Podfile`
2. Add: `config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"`
3. Run `pod install` again

## Next Steps

1. **Test on Device**: Connect iPhone and test all features
2. **TestFlight**: Submit to TestFlight for beta testing
3. **App Store**: Submit to App Store for review
4. **Monitor**: Watch crash reports and user feedback

## Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation)
- [Flutter iOS Documentation](https://flutter.dev/docs/deployment/ios)
- [Xcode Documentation](https://help.apple.com/xcode)
- [TestFlight Documentation](https://help.apple.com/testflight)

## Support

If you encounter issues:

1. Check the [Flutter Issues](https://github.com/flutter/flutter/issues)
2. Review Apple's [Common App Rejection Reasons](https://developer.apple.com/app-store/review/rejections)
3. Consult the troubleshooting section above

---

**Last Updated**: November 30, 2025
**Status**: iOS Platform Configuration Complete (on Windows)
**Next Action**: Complete setup on macOS with Xcode
