# Journal App - Developer Quick Start Guide

**New to the project?** This guide gets you running in 5 minutes.

---

## 1. Prerequisites

```bash
# Check you have these installed:
flutter --version      # Should be 3.19.0+
dart --version        # Should be 3.0.0+
```

If not installed: https://flutter.dev/docs/get-started/install

---

## 2. Clone & Setup (3 minutes)

```bash
# Navigate to the project
cd client-projects/active/journal-app

# Install dependencies
flutter pub get

# Get all dependencies (including dev)
flutter pub get --dev
```

---

## 3. Run the App (2 minutes)

```bash
# List available devices
flutter devices

# Run on Android emulator/device
flutter run

# Run in release mode (faster)
flutter run --release

# Run with verbose output (debug)
flutter run -v
```

---

## 4. Build Commands

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (for Google Play)
flutter build appbundle --release
```

### iOS (⚠️ Not yet configured)

```bash
# Build iOS app (after iOS setup)
flutter build ios --release
```

---

## 5. Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/journal_entry_test.dart

# Integration tests
flutter test integration_test/

# With coverage report
flutter test --coverage
genhtml -o coverage/html coverage/lcov.info
open coverage/html/index.html
```

---

## 6. Code Quality

```bash
# Analyze code
flutter analyze

# Format code
dart format . --line-length 120

# Fix common issues automatically
dart fix --apply
```

---

## 7. Project Structure Explained

```
lib/
├── main.dart                    # App starts here
├── screens/                     # 5 main UI screens
│   ├── home_screen.dart        # Main screen with 4 tabs
│   ├── entry_editor_screen.dart # Create/edit entries
│   ├── entry_detail_screen.dart # View entry details
│   ├── search_screen.dart       # Advanced search
│   └── settings_screen.dart     # Settings & themes
├── providers/                   # State management
│   ├── journal_provider.dart    # Entry management
│   └── theme_provider.dart      # Theme management
├── models/                      # Data models
│   ├── journal_entry.dart       # Entry data
│   ├── category.dart            # Category data
│   ├── tag.dart                 # Tag data
│   └── mood.dart                # Mood enum
├── database/                    # SQLite helper
│   └── database_helper.dart     # Database operations
├── repositories/                # Data layer
│   ├── journal_repository.dart
│   ├── category_repository.dart
│   └── tag_repository.dart
├── constants/                   # Colors, sizes, styles
├── theme/                       # Theme configuration
└── utils/                       # Helper functions
```

---

## 8. Understanding the Architecture

```
User Interface (Screens)
        ↓ (reads data from)
State Management (Providers)
        ↓ (calls methods on)
Repositories (Business Logic)
        ↓ (performs operations on)
Database (SQLite)
        ↑ (returns data)
```

**Data Flow Example:**
1. User creates entry in `EntryEditorScreen`
2. Calls `JournalProvider.createEntry()`
3. Provider calls `JournalRepository.insert()`
4. Repository calls `DatabaseHelper.insertEntry()`
5. Database stores in SQLite
6. Provider notifies UI of change
7. UI rebuilds with new data

---

## 9. Common Tasks

### Adding a New Field to Entries

1. Add field to `JournalEntry` model
2. Update database schema in `DatabaseHelper`
3. Update repository methods
4. Update UI screens to use new field
5. Write tests for new functionality

### Adding a New Screen

1. Create `lib/screens/new_screen.dart`
2. Add route to `main.dart`
3. Connect to providers as needed
4. Test on device

### Fixing a Bug

1. Understand the data flow
2. Add console logs or use DevTools
3. Write test case first
4. Fix the bug
5. Verify test passes
6. Check no other tests break

---

## 10. Debugging Tips

### Enable Logging
```dart
print('Debug: $value');  // Console output
```

### Use Flutter DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
# Opens: http://localhost:9100
```

### Check State Values
```bash
# In any Provider:
print('Current entries: ${provider.entries}');
```

### Test Locally
```bash
flutter run --debug
# Set breakpoints in VS Code (click line number)
# Use "View > Debug Console" to inspect variables
```

---

## 11. Frequently Used Commands

| Command | Purpose |
|---------|---------|
| `flutter run` | Run app in debug mode |
| `flutter test` | Run all tests |
| `flutter analyze` | Check code quality |
| `dart format .` | Format all code |
| `flutter clean` | Clean build files |
| `flutter pub upgrade` | Update dependencies |
| `flutter devices` | List devices |
| `flutter logs` | View device logs |

---

## 12. Key Files to Edit

### When You Want To...

**Add a feature:**
- Start in `lib/providers/journal_provider.dart`
- Add method to handle the feature
- Update UI screens to call it

**Change the UI:**
- Edit the relevant file in `lib/screens/`
- Preview changes with `flutter run`

**Fix a bug:**
- Find the source in `lib/` files
- Write a test case first
- Fix the bug
- Verify test passes

**Change the database:**
- Edit `lib/database/database_helper.dart`
- Update repository methods
- Migration will run automatically

---

## 13. Before Committing Code

```bash
# 1. Format code
dart format . --line-length 120

# 2. Run analyzer
flutter analyze

# 3. Run tests
flutter test

# 4. Check test coverage doesn't decrease
flutter test --coverage

# 5. Git commit with clear message
git add .
git commit -m "feat: Add new feature description"
```

---

## 14. Important Notes

### Database
- ✅ Data persisted in SQLite
- ✅ Automatic migrations handled
- ⚠️ No cloud backup yet
- ⚠️ Data lost if app uninstalled

### State Management
- Uses `Provider` pattern
- All state in `JournalProvider` and `ThemeProvider`
- UI rebuilds when provider notifies listeners
- Always dispose controllers in `StatefulWidget`

### Testing
- Tests in `test/` directory
- Use mocking for database tests
- Test coverage: ~82.8% target is 75%+

---

## 15. Getting Help

| Issue | Solution |
|-------|----------|
| App won't build | Run `flutter clean && flutter pub get` |
| Can't find method | Check import statements |
| Test failures | Run `flutter test -v` for details |
| Memory leak | Check dispose methods |
| Theme not changing | Restart app and clear cache |

---

## 16. Next Steps

1. **Get the app running** - `flutter run`
2. **Review the code** - Start with `main.dart`
3. **Run the tests** - `flutter test`
4. **Read documentation** - See [README.md](README.md)
5. **Check the checklist** - See [PRODUCTION_CHECKLIST.md](PRODUCTION_CHECKLIST.md)

---

## 17. Quick Reference: Important Classes

### Models (`lib/models/`)
```dart
JournalEntry   // Main data model
Category       // Category for organizing
Tag            // Tag for flexible categorization
Mood           // Mood enum with 5 levels
```

### Providers (`lib/providers/`)
```dart
JournalProvider   // Manages entries, CRUD, search
ThemeProvider     // Manages theme and preferences
```

### Repositories (`lib/repositories/`)
```dart
JournalRepository   // Entry data access
CategoryRepository  // Category data access
TagRepository       // Tag data access
```

### Database (`lib/database/`)
```dart
DatabaseHelper   // SQLite operations
```

---

## 18. Development Workflow

```
1. Make code changes
        ↓
2. Run: flutter run
        ↓
3. Test on emulator/device
        ↓
4. Run: flutter test
        ↓
5. Run: flutter analyze
        ↓
6. Run: dart format .
        ↓
7. Commit with git
```

---

## 19. Performance Tips

- Build in release mode for testing: `flutter run --release`
- Check app size: `flutter build appbundle --analyze-size`
- Profile memory: Use DevTools Memory tab
- Optimize images: Use appropriate sizes
- Cache expensive computations: Use Provider selectors

---

## 20. Common Issues & Solutions

### "Device not found"
```bash
flutter devices          # List available devices
flutter emulators      # List available emulators
flutter run -d <id>    # Specify device ID
```

### "Port already in use"
```bash
flutter run --verbose
# Kill the process using the port
# On Linux/Mac: lsof -i :8888 | kill -9
```

### "Plugin not found"
```bash
flutter pub get
flutter pub upgrade
```

### "Build fails"
```bash
flutter clean
flutter pub get
flutter run
```

---

**Questions?** Check:
- [README.md](README.md) - Full documentation
- [PRODUCTION_CHECKLIST.md](PRODUCTION_CHECKLIST.md) - Detailed checklist
- [COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md) - Project status

**Ready to code?** Run `flutter run` and start exploring! 🚀
