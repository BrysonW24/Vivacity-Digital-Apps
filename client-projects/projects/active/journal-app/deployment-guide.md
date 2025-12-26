# Journal App - Android Deployment Guide

## Prerequisites

- Flutter SDK installed
- Android Studio or Android SDK Command-line Tools
- Java JDK 17+
- Google Play Console account (for store deployment)

## Step 1: Create App Signing Keystore

### Generate Keystore

```bash
keytool -genkey -v -keystore C:\Users\<USERNAME>\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Answer the prompts:
# - Enter keystore password: [CREATE STRONG PASSWORD]
# - Re-enter password: [SAME PASSWORD]
# - What is your first and last name? Vivacity Digital
# - What is the name of your organizational unit? Development
# - What is the name of your organization? Vivacity Digital
# - What is the name of your City or Locality? [Your City]
# - What is the name of your State or Province? [Your State]
# - What is the two-letter country code? US (or your country)
# - Is CN=..., correct? yes
# - Enter key password: [PRESS ENTER to use same password]
```

### Create key.properties File

Create file: `android/key.properties`

```properties
storePassword=<PASSWORD_FROM_KEYSTORE_CREATION>
keyPassword=<PASSWORD_FROM_KEYSTORE_CREATION>
keyAlias=upload
storeFile=C:\\Users\\<USERNAME>\\upload-keystore.jks
```

**IMPORTANT:**
- Add `key.properties` to `.gitignore`
- NEVER commit this file to version control
- Store passwords securely (use password manager)

## Step 2: Configure App Icon

### Option A: Use flutter_launcher_icons Package

1. Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#6366F1"  # Your theme color
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

2. Create app icons:
   - Place your 1024x1024 app icon in `assets/icon/app_icon.png`
   - Create adaptive foreground icon (512x512) for Android

3. Generate icons:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Option B: Manual Icon Creation

Create icons for each density:

- `mipmap-mdpi`: 48x48 px
- `mipmap-hdpi`: 72x72 px
- `mipmap-xhdpi`: 96x96 px
- `mipmap-xxhdpi`: 144x144 px
- `mipmap-xxxhdpi`: 192x192 px

Place in: `android/app/src/main/res/mipmap-<density>/ic_launcher.png`

## Step 3: Update App Configuration

### Update build.gradle.kts

Already configured with:
- Application ID: `com.vivacitydigital.journal_app`
- Version Code: `1`
- Version Name: `1.0.0`
- Min SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)

To increment version for updates:
1. Increase `versionCode` by 1 (e.g., 1 → 2)
2. Update `versionName` (e.g., "1.0.0" → "1.0.1")

### Update AndroidManifest.xml

Already configured with:
- App name: "Journal App"
- Required permissions
- Notification receivers

## Step 4: Build Release APK/AAB

### Build App Bundle (AAB) - Recommended for Play Store

```bash
# Navigate to project directory
cd C:\dev\AiaaS\vivacity-digital-dev\Vivacity-Digital-Apps\client-projects\active\journal-app

# Clean build
flutter clean
flutter pub get

# Build app bundle
flutter build appbundle --release

# Output location:
# build/app/outputs/bundle/release/app-release.aab
```

### Build APK - For Testing or Direct Distribution

```bash
# Build APK
flutter build apk --release

# Build split APKs (smaller, separate for each architecture)
flutter build apk --split-per-abi

# Output locations:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
# build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
# build/app/outputs/flutter-apk/app-x86_64-release.apk
```

## Step 5: Test Release Build

### Install on Physical Device

```bash
# List connected devices
flutter devices

# Install release APK
flutter install --release

# Or use adb directly
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Test Checklist

- [ ] App installs successfully
- [ ] App launches without crashes
- [ ] All features work correctly
- [ ] Database operations function properly
- [ ] Notifications work (if implemented)
- [ ] Export/sharing works
- [ ] No debug artifacts visible
- [ ] Performance is acceptable
- [ ] App size is reasonable

## Step 6: Prepare Play Store Listing

### Required Assets

1. **App Icon** (512x512 PNG)
   - High-res version of your app icon

2. **Feature Graphic** (1024x500 PNG)
   - Banner image for store listing

3. **Screenshots** (Minimum 2, maximum 8)
   - Phone: 16:9 or 9:16 aspect ratio
   - Minimum dimension: 320px
   - Maximum dimension: 3840px
   - Recommended: 1080x1920 or 1080x2340

4. **Privacy Policy URL**
   - Required if app requests permissions or handles user data

### Store Listing Content

**Title** (Max 50 characters):
```
Journal App - Daily Diary & Notes
```

**Short Description** (Max 80 characters):
```
Beautiful journaling app for capturing daily thoughts, moods, and memories
```

**Full Description** (Max 4000 characters):
```
Journal App is a beautiful and intuitive journaling application designed to help you capture your daily thoughts, track your moods, and preserve your memories.

KEY FEATURES:
✨ Beautiful, modern interface
📝 Rich text editor for journal entries
😊 Mood tracking with emoji selection
📅 Calendar view to browse past entries
⭐ Favorite important entries
🔍 Search through all your journals
🌙 Dark mode support
🎨 Multiple theme presets
📤 Export entries to PDF
🔒 Local storage - your data stays private

PERFECT FOR:
• Daily journaling and reflection
• Mood tracking and mental wellness
• Creative writing and ideation
• Travel diary and trip memories
• Gratitude practice
• Dream journal

PRIVACY FIRST:
All your journal entries are stored locally on your device. No cloud sync, no data collection, complete privacy.

Start your journaling journey today!
```

### Content Rating

Complete the content rating questionnaire in Play Console.
For Journal App:
- Select "EVERYONE" or "EVERYONE 10+"
- Answer questions about violence, sexuality, etc. (all "No" for journal app)

### Target Audience

- Target age: All ages
- Appeals to children: No (unless specifically designed for children)

## Step 7: Upload to Google Play Console

### Initial Upload (Closed Testing)

1. **Create App in Play Console**
   - Go to https://play.google.com/console
   - Click "Create app"
   - Fill in app details:
     - App name: Journal App
     - Default language: English (United States)
     - App/Game: App
     - Free/Paid: Free

2. **Set Up Closed Testing Track**
   - Testing > Closed testing > Create new release
   - Upload AAB file
   - Add release notes
   - Save and review

3. **Create Tester List**
   - Add email addresses of testers
   - Testers receive email with opt-in link

4. **Complete Store Listing**
   - Store presence > Main store listing
   - Upload all assets
   - Enter descriptions
   - Set category: Productivity
   - Provide contact details

5. **Complete App Content**
   - Privacy policy (if applicable)
   - App access (is app free to access?)
   - Ads (does app contain ads?)
   - Content ratings
   - Target audience
   - Data safety

6. **Submit for Review**
   - Review everything in dashboard
   - Click "Send for review"
   - Wait for approval (usually 1-3 days)

### Production Release

After testing is successful:

1. **Create Production Release**
   - Production > Create new release
   - Upload same AAB used in testing
   - Add release notes
   - Set rollout percentage (start with 20%, then increase)

2. **Review and Publish**
   - Review all settings
   - Click "Start rollout to Production"

## Step 8: Post-Release

### Monitor

- Check Google Play Console for:
  - Crash reports
  - ANRs (App Not Responding)
  - User reviews
  - Installation statistics

### Update Process

When releasing updates:

1. Increment version in `build.gradle.kts`:
   ```kotlin
   versionCode = 2  // Increment by 1
   versionName = "1.0.1"  // Semantic versioning
   ```

2. Build new AAB
3. Upload to Play Console
4. Add release notes describing changes
5. Submit for review

## Troubleshooting

### Build Fails

```bash
# Clear build cache
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get

# Rebuild
flutter build appbundle --release
```

### Signing Issues

- Verify `key.properties` exists and has correct path
- Check keystore file exists at specified location
- Verify passwords are correct

### Size Too Large

- Use `--split-per-abi` for APKs
- AAB automatically creates optimized APKs
- Review assets and remove unused files
- Enable R8/ProGuard (already configured)

### Upload Rejected

Common reasons:
- App crashes on startup
- Missing required permissions explanation
- Privacy policy required but not provided
- Target SDK too low (must be recent)
- Content rating not completed

## Security Best Practices

1. **Never commit keystore or key.properties**
   - Add to `.gitignore`:
     ```
     **/android/key.properties
     **/*.jks
     **/*.keystore
     ```

2. **Backup keystore securely**
   - Store in password manager
   - Keep offline backup
   - If lost, can't update app on Play Store!

3. **Use Play App Signing**
   - Let Google manage production key
   - You keep upload key
   - Safer and allows key reset if needed

## Useful Commands

```bash
# Check app size
flutter build appbundle --release --analyze-size

# Build with verbose output
flutter build appbundle --release --verbose

# Build for specific flavor/environment
flutter build appbundle --release --dart-define=ENV=production

# Install and run release build
flutter run --release

# Get SHA-1 fingerprint (for Google APIs)
keytool -list -v -keystore C:\Users\<USERNAME>\upload-keystore.jks -alias upload
```

## Resources

- [Flutter Android Deployment](https://docs.flutter.dev/deployment/android)
- [Google Play Console](https://play.google.com/console)
- [Android App Bundle](https://developer.android.com/guide/app-bundle)
- [Play Store Review Guidelines](https://support.google.com/googleplay/android-developer/answer/9898842)

---

**Need Help?**
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow - Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)
- [Google Play Support](https://support.google.com/googleplay/android-developer)
