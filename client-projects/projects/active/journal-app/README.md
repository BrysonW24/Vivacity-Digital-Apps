# Journal App - Beautiful Journaling for Everyone

A beautiful, functional, and privacy-focused journaling application built with Flutter. Track your daily thoughts, moods, and experiences with a clean, intuitive interface.

## Features

### 📝 Core Journaling
- **Rich Text Editor** - Write your thoughts with markdown support (bold, italic, strikethrough, lists, code)
- **Mood Tracking** - 5-level mood tracking with emoji indicators (😢 sad to 😄 very happy)
- **Categories & Tags** - Organize entries with custom categories and flexible tagging
- **Favorites** - Mark important entries for quick access
- **Word Count** - Real-time word count and reading time estimation

### 🔍 Search & Filtering
- **Full-Text Search** - Search across entry titles and content
- **Advanced Filters**
  - Filter by mood
  - Filter by category
  - Filter by multiple tags
  - Filter by date range
  - Filter by favorite status
- **Multiple Sort Options** - Sort by date, title, mood, or category
- **Ascending/Descending** - Flexible sorting directions

### 📱 User Interface
- **5 Main Screens**
  - **Home** - Table view with all entries, recent entries, favorites, and calendar view
  - **Editor** - Full-featured entry creation and editing
  - **Detail** - Complete entry view with edit, delete, favorite options
  - **Search** - Advanced search with multiple filters
  - **Settings** - Theme selection, statistics, and app info

### 🎨 Themes
- **Modern Minimalist** - Clean, contemporary design
- **Calming Zen** - Relaxing, peaceful aesthetic
- **Light/Dark/System** - Automatic theme switching based on device settings
- **Persistent** - Theme choice saved across sessions

### 📊 Statistics
- **Mood Statistics** - Visual breakdown of mood distribution
- **Entry Count** - Track total entries and daily averages
- **Writing Insights** - Word count trends and writing patterns

### 🔒 Privacy First
- **Local-Only Storage** - All data stored locally on your device
- **No Cloud Sync** - Complete control of your personal data
- **No Ads or Tracking** - Your thoughts remain private
- **SQLite Database** - Secure local data storage

---

## Installation

### Prerequisites
- Flutter SDK 3.19.0 or later
- Dart SDK (included with Flutter)
- Android: Android SDK 21+ or iOS 12+
- 30MB free storage space

### From Source

```bash
# Clone the repository
git clone https://github.com/vivacity-digital/journal-app.git
cd journal-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Download from Stores

- **Android** - Google Play Store (coming soon)
- **iOS** - Apple App Store (coming soon)

---

## Quick Start

### Creating Your First Entry

1. **Tap the FAB** (floating action button) on the home screen
2. **Add a Title** - Give your entry a name (min 3 characters)
3. **Write Content** - Express your thoughts (min 10 characters)
4. **Select Mood** - Choose how you're feeling (optional)
5. **Add Category** - Organize your entry (optional)
6. **Add Tags** - Tag related topics (optional)
7. **Save** - Tap "Save Entry" to store

### Searching Your Entries

1. **Tap Search** icon in the top bar
2. **Search Box** - Type to search titles and content
3. **Use Filters** - Apply category, mood, tag, or date filters
4. **View Results** - See matching entries in real-time
5. **Clear Filters** - Tap "Clear" to reset

### Managing Themes

1. **Open Settings** - Tap gear icon
2. **Theme Section** - Select your preferred theme
3. **Light/Dark Mode** - Choose from Light, Dark, or System
4. **Your Preference** - Settings saved automatically

---

## Technology Stack

### Frontend
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Provider** - State management
- **Material Design 3** - Modern UI design system

### Backend & Storage
- **SQLite** - Local database
- **Shared Preferences** - User preferences
- **File System** - Document storage

### Development
- **VS Code** or **Android Studio** - IDE
- **Dart DevTools** - Debugging
- **Flutter Inspector** - UI debugging

---

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   ├── app_colors.dart      # Color definitions
│   ├── app_constants.dart   # App-wide constants
│   └── text_styles.dart     # Typography styles
├── models/
│   ├── journal_entry.dart   # Entry data model
│   ├── category.dart        # Category model
│   ├── tag.dart            # Tag model
│   └── mood.dart           # Mood enumeration
├── database/
│   └── database_helper.dart # SQLite helper
├── providers/
│   ├── journal_provider.dart # Journal state management
│   └── theme_provider.dart  # Theme state management
├── repositories/
│   ├── journal_repository.dart
│   ├── category_repository.dart
│   └── tag_repository.dart
├── screens/
│   ├── home_screen.dart     # Main screen
│   ├── entry_editor_screen.dart
│   ├── entry_detail_screen.dart
│   ├── search_screen.dart
│   └── settings_screen.dart
├── theme/
│   ├── app_theme.dart       # Theme configuration
│   └── theme_presets.dart   # Theme definitions
└── utils/
    └── date_formatter.dart  # Date formatting utilities

test/                        # Unit & widget tests
integration_test/           # Integration tests
```

---

## Development

### Setup Development Environment

```bash
# Get dependencies
flutter pub get

# Run analyzer
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Generate code coverage
flutter test --coverage
```

### Running the App

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Run on specific device
flutter run -d <device-id>

# Run with logs
flutter run -v
```

### Building for Production

#### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release
```

#### iOS
```bash
# Build iOS app
flutter build ios --release
```

See [deployment-guide.md](deployment-guide.md) for detailed instructions.

---

## Testing

### Run Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/models/journal_entry_test.dart

# Integration tests
flutter test integration_test/

# With coverage
flutter test --coverage
```

### Test Coverage

```bash
# Generate coverage report
flutter test --coverage

# View HTML report
genhtml -o coverage/html coverage/lcov.info
open coverage/html/index.html
```

**Current Coverage:** ~82.8% (targeting 85%+)

---

## Architecture

### Clean Architecture Layers

```
Presentation Layer (UI)
    ↓ (Consumer)
State Management (Provider)
    ↓ (Uses)
Business Logic (Repositories)
    ↓ (Uses)
Data Layer (Database)
```

### Data Flow

1. **UI Layer** - Screens display data and handle user input
2. **Provider** - Manages state and notifies listeners of changes
3. **Repository** - Abstracts data source operations
4. **Database** - Handles SQLite operations

---

## Known Limitations

- **No Cloud Sync** - Data stored locally only (intentional privacy feature)
- **No Multi-Device Sync** - Each device has separate data
- **No Account System** - No authentication (privacy first)
- **No Image Support** - Text-only entries (planned)
- **No Reminders** - No notification system (planned)

---

## Roadmap

### Planned Features
- ✅ Core journaling (complete)
- ✅ Search & filtering (complete)
- ✅ Theme system (complete)
- 🔄 Image support (in progress)
- 🔄 PDF export (in progress)
- 🔄 Backup/restore (in progress)
- ⏳ Reminders & notifications
- ⏳ Journaling prompts
- ⏳ Statistics dashboard
- ⏳ Web version

### Platform Support
- ✅ Android 5.0+ (complete)
- 🔄 iOS 12+ (in progress)
- ⚠️ Windows (experimental)
- ⏳ macOS (planned)
- ⏳ Linux (planned)
- ⏳ Web (planned)

---

## Troubleshooting

### App Won't Start
- Clear app cache: Settings → Apps → Journal → Clear Cache
- Uninstall and reinstall
- Check Flutter version: `flutter --version`

### Can't Find Entries
- Use the Search function
- Check the Table View on Home screen
- Verify date filters aren't active

### Data Lost
- Check if entry was actually saved (look for save success message)
- Manually backup: Export database file
- Contact support with device logs

### Theme Not Changing
- Restart app
- Check Light/Dark/System mode setting
- Try switching themes manually

---

## Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests for new features
5. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## Support

### Getting Help
- **Documentation** - See [PRODUCTION_CHECKLIST.md](PRODUCTION_CHECKLIST.md)
- **Issues** - Report bugs on GitHub
- **Email** - support@vivacitydigital.com
- **FAQ** - Check the settings screen

### Reporting Bugs
When reporting bugs, please include:
- Device model and OS version
- Flutter version
- App version
- Steps to reproduce
- Screenshots or videos
- Error logs

---

## Privacy & Security

- **No Data Collection** - We don't collect any user data
- **No Analytics** - No tracking of app usage
- **No Ads** - Ad-free experience
- **Local Storage** - All data stays on your device
- **Open Source** - Source code available for review

See [SECURITY.md](../../../SECURITY.md) for security policies.

---

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

---

## Credits

**Built with:**
- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [sqflite](https://pub.dev/packages/sqflite)
- [Material Design 3](https://m3.material.io/)

**Team:** Vivacity Digital

---

## Changelog

### Version 1.0.0 (Beta)
- ✅ Initial release
- ✅ Core journaling features
- ✅ Search and filtering
- ✅ Theme system
- ✅ Local SQLite storage
- 🔄 iOS support (in progress)
- 🔄 Test coverage (in progress)

See full changelog in [deployment-guide.md](deployment-guide.md).

---

## Contact

- **Website:** https://vivacitydigital.com
- **Email:** hello@vivacitydigital.com
- **Twitter:** @VivacityDigital
- **Support:** support@vivacitydigital.com

---

**Version:** 1.0.0
**Last Updated:** November 30, 2025
**Status:** Beta (Ready for Testing)
