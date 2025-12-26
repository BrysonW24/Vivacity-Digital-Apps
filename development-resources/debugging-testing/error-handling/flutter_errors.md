# Common Flutter Errors and Solutions

## Build Errors

### 1. "Waiting for another flutter command to release the startup lock"

**Error:**
```
Waiting for another flutter command to release the startup lock...
```

**Cause:** Another Flutter process is running or didn't terminate properly.

**Solutions:**

```bash
# Windows
taskkill /F /IM dart.exe
taskkill /F /IM flutter.exe

# macOS/Linux
killall -9 dart
killall -9 flutter

# Or delete the lock file
# Windows
del %LOCALAPPDATA%\Pub\Cache\.lock
# macOS/Linux
rm ~/.pub-cache/.lock
```

### 2. "Error: Cannot run with sound null safety"

**Error:**
```
Error: Cannot run with sound null safety, because the following dependencies
don't support null safety:
```

**Solutions:**

```bash
# Option 1: Run without null safety (temporary)
flutter run --no-sound-null-safety

# Option 2: Migrate your app to null safety
flutter pub outdated --mode=null-safety
dart migrate

# Option 3: Update dependencies
flutter pub upgrade --major-versions
```

### 3. "Gradle build failed with exit code 1"

**Common Causes:**

**A. Minimum SDK version mismatch**

```gradle
// android/app/build.gradle
android {
    defaultConfig {
        minSdkVersion 21  // Change from 16 to 21
        targetSdkVersion 33
    }
}
```

**B. Missing Java/Kotlin version**

```gradle
// android/build.gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

**C. MultiDex required**

```gradle
// android/app/build.gradle
defaultConfig {
    multiDexEnabled true
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

### 4. "CocoaPods not installed" (iOS)

**Error:**
```
Error: CocoaPods not installed or not in valid state.
```

**Solution:**

```bash
# Install CocoaPods
sudo gem install cocoapods

# Or using Homebrew
brew install cocoapods

# Update CocoaPods repo
pod repo update

# Install pods
cd ios
pod install
cd ..

# If still failing, try:
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
```

## Runtime Errors

### 5. "RenderBox was not laid out"

**Error:**
```
RenderBox was not laid out: RenderRepaintBoundary#a8b3d relayoutBoundary=up1 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
```

**Cause:** Widget has unbounded constraints (infinite width/height).

**Solutions:**

```dart
// ❌ WRONG: Unbounded ListView in Column
Column(
  children: [
    ListView(  // Error: ListView has infinite height
      children: [...],
    ),
  ],
)

// ✅ SOLUTION 1: Wrap in Expanded
Column(
  children: [
    Expanded(
      child: ListView(
        children: [...],
      ),
    ),
  ],
)

// ✅ SOLUTION 2: Set shrinkWrap
Column(
  children: [
    ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [...],
    ),
  ],
)

// ✅ SOLUTION 3: Use SizedBox with fixed height
Column(
  children: [
    SizedBox(
      height: 300,
      child: ListView(
        children: [...],
      ),
    ),
  ],
)
```

### 6. "setState() called after dispose()"

**Error:**
```
setState() called after dispose(): _MyWidgetState#123abc (lifecycle state: defunct)
```

**Cause:** Async operation completes after widget is disposed.

**Solution:**

```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  void dispose() {
    // Cancel any pending operations
    super.dispose();
  }

  Future<void> fetchData() async {
    final data = await api.getData();

    // ✅ SOLUTION: Check if still mounted before calling setState
    if (mounted) {
      setState(() {
        _data = data;
      });
    }
  }
}

// ✅ BETTER: Use StatefulWidget lifecycle properly
class _MyWidgetState extends State<MyWidget> {
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    fetchData();
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await api.getData(cancelToken: _cancelToken);
      if (mounted) {
        setState(() => _data = data);
      }
    } on CancelledException {
      // Request was cancelled
    }
  }
}
```

### 7. "A RenderFlex overflowed"

**Error:**
```
A RenderFlex overflowed by 42 pixels on the right.
```

**Visual Indicator:** Yellow and black striped error area in app.

**Solutions:**

```dart
// ❌ WRONG: Fixed-width children in Row
Row(
  children: [
    Container(width: 200, child: Text('Item 1')),
    Container(width: 200, child: Text('Item 2')),
    Container(width: 200, child: Text('Item 3')),  // Overflow!
  ],
)

// ✅ SOLUTION 1: Use Expanded
Row(
  children: [
    Expanded(child: Text('Item 1')),
    Expanded(child: Text('Item 2')),
    Expanded(child: Text('Item 3')),
  ],
)

// ✅ SOLUTION 2: Use Flexible
Row(
  children: [
    Flexible(flex: 2, child: Text('Wide item')),
    Flexible(flex: 1, child: Text('Narrow')),
  ],
)

// ✅ SOLUTION 3: Make scrollable
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      Container(width: 200, child: Text('Item 1')),
      Container(width: 200, child: Text('Item 2')),
      Container(width: 200, child: Text('Item 3')),
    ],
  ),
)

// ✅ SOLUTION 4: Wrap text
Row(
  children: [
    Expanded(
      child: Text(
        'Very long text that might overflow',
        overflow: TextOverflow.ellipsis,  // or .clip, .fade
        maxLines: 1,
      ),
    ),
  ],
)
```

### 8. "Null check operator used on a null value"

**Error:**
```
Null check operator used on a null value
```

**Cause:** Using `!` operator on null value.

**Solutions:**

```dart
// ❌ WRONG: Forcing non-null
String name = user!.name;  // Crashes if user is null

// ✅ SOLUTION 1: Null check
if (user != null) {
  String name = user.name;
}

// ✅ SOLUTION 2: Null-aware operator
String name = user?.name ?? 'Unknown';

// ✅ SOLUTION 3: Late initialization with check
late String name;

@override
void initState() {
  super.initState();
  if (widget.user != null) {
    name = widget.user!.name;
  }
}
```

### 9. "Bad state: Stream has already been listened to"

**Error:**
```
Bad state: Stream has already been listened to
```

**Cause:** Multiple listeners on a single-subscription stream.

**Solutions:**

```dart
// ❌ WRONG: Multiple listeners on single stream
Stream<int> stream = getDataStream();
stream.listen((data) => print(data));
stream.listen((data) => print(data));  // Error!

// ✅ SOLUTION 1: Use broadcast stream
Stream<int> stream = getDataStream().asBroadcastStream();
stream.listen((data) => print('Listener 1: $data'));
stream.listen((data) => print('Listener 2: $data'));

// ✅ SOLUTION 2: Use StreamController
final controller = StreamController<int>.broadcast();
controller.stream.listen((data) => print('Listener 1: $data'));
controller.stream.listen((data) => print('Listener 2: $data'));
```

### 10. "Navigator operation requested with a context that does not include a Navigator"

**Error:**
```
Navigator operation requested with a context that does not include a Navigator
```

**Cause:** Using BuildContext before MaterialApp/Navigator is built.

**Solutions:**

```dart
// ❌ WRONG: Navigator in build method of MaterialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Navigator.push(context, ...);  // Error: No Navigator yet!

    return MaterialApp(
      home: HomePage(),
    );
  }
}

// ✅ SOLUTION 1: Use Builder widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          // Now context includes Navigator
          return HomePage();
        },
      ),
    );
  }
}

// ✅ SOLUTION 2: Move navigation to separate widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),  // Navigation happens in HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, ...);  // Works!
      },
      child: Text('Navigate'),
    );
  }
}

// ✅ SOLUTION 3: Use GlobalKey
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: HomePage(),
    );
  }

  void navigateAnywhere() {
    navigatorKey.currentState?.push(...);
  }
}
```

## Database Errors

### 11. "DatabaseException: no such table"

**Cause:** Table not created or migration failed.

**Solutions:**

```dart
// ✅ SOLUTION 1: Increase database version
Future<Database> _initDatabase() async {
  return openDatabase(
    path,
    version: 2,  // Increment version
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE entries(
          id TEXT PRIMARY KEY,
          title TEXT,
          content TEXT
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Add missing table or columns
        await db.execute('CREATE TABLE IF NOT EXISTS entries(...)');
      }
    },
  );
}

// ✅ SOLUTION 2: Delete and recreate database
await deleteDatabase(path);  // Caution: Deletes all data!
final db = await _initDatabase();
```

### 12. "Bad state: databaseFactory not initialized" (Windows/Linux/macOS)

**Cause:** sqflite doesn't work on desktop without FFI initialization.

**Solution:**

```dart
// pubspec.yaml
dependencies:
  sqflite: ^2.3.0
  sqflite_common_ffi: ^2.3.0

// main.dart
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MyApp());
}
```

## Network Errors

### 13. "SocketException: OS Error: Connection refused"

**Cause:** Cannot connect to server.

**Solutions:**

```dart
try {
  final response = await http.get(url);
} on SocketException catch (e) {
  // No internet connection
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Connection Error'),
      content: Text('Please check your internet connection.'),
    ),
  );
} on TimeoutException catch (e) {
  // Request timed out
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Timeout'),
      content: Text('The server is taking too long to respond.'),
    ),
  );
} catch (e) {
  // Other errors
  print('Error: $e');
}
```

### 14. "HandshakeException: Connection terminated during handshake"

**Cause:** SSL certificate issues.

**Solutions:**

```dart
// ⚠️ TEMPORARY FIX (development only):
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();  // ⚠️ INSECURE - dev only!
  runApp(MyApp());
}

// ✅ PRODUCTION FIX: Use valid SSL certificate on server
```

## Quick Reference

| Error | Quick Fix |
|-------|-----------|
| Lock file exists | Delete `.lock` file or kill Flutter processes |
| Null safety error | Update dependencies or use `--no-sound-null-safety` |
| Gradle build failed | Update Gradle, check SDK versions |
| Widget overflow | Use `Expanded`, `Flexible`, or scroll |
| setState after dispose | Check `if (mounted)` before setState |
| No Navigator | Use context after MaterialApp built |
| Database not found | Increase version number, run onCreate again |
| SQLite on desktop | Add `sqflite_common_ffi` and initialize |
| Network error | Handle exceptions, check connectivity |

---

**Resources:**
- [Flutter Error Handling](https://docs.flutter.dev/testing/errors)
- [Common Flutter Errors](https://docs.flutter.dev/testing/common-errors)
- [Stack Overflow - Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)
