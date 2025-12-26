# Flutter Logging Best Practices

## Overview

Effective logging is crucial for debugging, monitoring, and maintaining Flutter applications. This guide covers logging strategies, tools, and best practices for development and production environments.

## Built-in Dart Logging

### 1. debugPrint()

**Best for:** Development debugging

```dart
import 'package:flutter/foundation.dart';

void example() {
  debugPrint('Simple debug message');
  debugPrint('User ID: $userId');

  // Only runs in debug mode
  if (kDebugMode) {
    debugPrint('This is debug-only logging');
  }
}
```

**Advantages:**
- Automatically throttles output (prevents log overflow)
- Only logs in debug mode by default
- Simple and built-in

**Disadvantages:**
- No log levels
- No structured logging
- Removed in release builds

### 2. print()

**⚠️ Avoid in production code**

```dart
print('Basic print statement'); // ❌ Don't use in production
```

**Why avoid:**
- Can't be disabled in release
- No throttling (can overflow)
- No log levels
- Poor performance

### 3. log() from dart:developer

**Best for:** Detailed debugging with metadata

```dart
import 'dart:developer';

void example() {
  log(
    'User authentication',
    name: 'AuthService',
    time: DateTime.now(),
    sequenceNumber: 42,
    level: 900, // INFO level
    error: someError,
    stackTrace: someStackTrace,
  );
}
```

**Log Levels:**
```dart
import 'dart:developer';

log('Config message', level: Level.CONFIG.value);    // 700
log('Fine message', level: Level.FINE.value);        // 500
log('Info message', level: Level.INFO.value);        // 800
log('Warning message', level: Level.WARNING.value);  // 900
log('Severe error', level: Level.SEVERE.value);      // 1000
```

## Structured Logging with Logger Package

### Installation

```yaml
dependencies:
  logger: ^2.0.0
```

### Basic Setup

```dart
import 'package:logger/logger.dart';

// Create a logger instance
final logger = Logger();

void example() {
  logger.d('Debug message');     // Debug
  logger.i('Info message');      // Info
  logger.w('Warning message');   // Warning
  logger.e('Error message');     // Error
  logger.f('Fatal message');     // Fatal/WTF
}
```

### Advanced Configuration

```dart
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    filter: ProductionFilter(), // Only logs in debug mode by default
    printer: PrettyPrinter(
      methodCount: 2,         // Number of method calls to show
      errorMethodCount: 8,    // Number of method calls for errors
      lineLength: 120,        // Width of output
      colors: true,           // Colorful output
      printEmojis: true,      // Print emojis
      printTime: true,        // Print timestamp
    ),
    output: ConsoleOutput(),  // Output to console
    level: Level.debug,       // Minimum log level
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

// Usage
AppLogger.info('User logged in');
AppLogger.error('Failed to fetch data', error, stackTrace);
```

### Custom Log Output

**File Logging:**

```dart
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class FileOutput extends LogOutput {
  File? _file;

  @override
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _file = File('${directory.path}/app_logs.txt');
  }

  @override
  void output(OutputEvent event) {
    if (_file != null) {
      for (var line in event.lines) {
        _file!.writeAsStringSync('${DateTime.now()}: $line\n', mode: FileMode.append);
      }
    }
  }
}

// Usage
final logger = Logger(
  output: MultiOutput([
    ConsoleOutput(),
    FileOutput(),
  ]),
);
```

## Environment-Based Logging

### Configuration

```dart
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppConfig {
  static Logger getLogger() {
    if (kReleaseMode) {
      // Production: Only warnings and errors, no console output
      return Logger(
        level: Level.warning,
        filter: ProductionFilter(),
        printer: SimplePrinter(printTime: true),
        output: FileOutput(), // Log to file only
      );
    } else if (kProfileMode) {
      // Profile mode: Info and above
      return Logger(
        level: Level.info,
        printer: SimplePrinter(),
      );
    } else {
      // Debug mode: Everything
      return Logger(
        level: Level.debug,
        printer: PrettyPrinter(
          printEmojis: true,
          colors: true,
        ),
      );
    }
  }
}

// Usage
final logger = AppConfig.getLogger();
```

### Build Configuration

```dart
// Define environment in main.dart
const bool isProduction = bool.fromEnvironment('PRODUCTION', defaultValue: false);

void main() {
  if (isProduction) {
    Logger.level = Level.warning;
  } else {
    Logger.level = Level.debug;
  }

  runApp(MyApp());
}
```

**Run with environment flag:**
```bash
flutter run --dart-define=PRODUCTION=true
flutter build apk --dart-define=PRODUCTION=true
```

## Feature-Based Logging

### Create Logger for Each Feature

```dart
// lib/core/logging/app_logger.dart
import 'package:logger/logger.dart';

class FeatureLogger {
  final String feature;
  final Logger _logger;

  FeatureLogger(this.feature)
      : _logger = Logger(
          printer: PrefixPrinter(
            PrettyPrinter(methodCount: 0),
            prefix: '[$feature]',
          ),
        );

  void debug(String message) => _logger.d(message);
  void info(String message) => _logger.i(message);
  void warning(String message) => _logger.w(message);
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

// Usage in different features
class AuthService {
  final _logger = FeatureLogger('AUTH');

  Future<void> login(String email) async {
    _logger.info('Login attempt for: $email');
    try {
      // Login logic
      _logger.info('Login successful');
    } catch (e, stackTrace) {
      _logger.error('Login failed', e, stackTrace);
      rethrow;
    }
  }
}

class DatabaseService {
  final _logger = FeatureLogger('DATABASE');

  Future<void> saveEntry(Entry entry) async {
    _logger.debug('Saving entry: ${entry.id}');
    try {
      // Save logic
      _logger.info('Entry saved successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to save entry', e, stackTrace);
      rethrow;
    }
  }
}
```

## Performance Monitoring

### Timing Operations

```dart
import 'dart:developer';

class PerformanceLogger {
  static Future<T> measure<T>(
    String operation,
    Future<T> Function() function,
  ) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await function();
      stopwatch.stop();

      final duration = stopwatch.elapsedMilliseconds;
      log(
        'Operation completed',
        name: operation,
        time: DateTime.now(),
        level: 800,
        error: 'Duration: ${duration}ms',
      );

      if (duration > 1000) {
        log(
          '⚠️ Slow operation detected',
          name: operation,
          level: 900,
          error: 'Took ${duration}ms',
        );
      }

      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      log(
        'Operation failed',
        name: operation,
        level: 1000,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

// Usage
Future<void> fetchData() async {
  await PerformanceLogger.measure('fetchData', () async {
    final response = await http.get(url);
    return response.data;
  });
}
```

### Timeline Events

```dart
import 'dart:developer';

void expensiveOperation() {
  Timeline.startSync('Expensive Operation');

  // Do expensive work
  for (int i = 0; i < 1000000; i++) {
    // Work...
  }

  Timeline.finishSync();
}

Future<void> asyncOperation() async {
  Timeline.startSync('Async Operation');

  await Future.delayed(Duration(seconds: 2));

  Timeline.finishSync();
}
```

View timeline in **Flutter DevTools > Performance** tab.

## Error Tracking

### Capturing Unhandled Errors

```dart
import 'package:flutter/foundation.dart';
import 'dart:developer';

void main() {
  // Capture Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    log(
      'Flutter framework error',
      name: 'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
      level: 1000,
    );

    if (kReleaseMode) {
      // Send to crash reporting service
      // FirebaseCrashlytics.instance.recordFlutterError(details);
    } else {
      // Show in console during development
      FlutterError.presentError(details);
    }
  };

  // Capture Dart errors outside Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    log(
      'Unhandled Dart error',
      name: 'PlatformError',
      error: error,
      stackTrace: stack,
      level: 1000,
    );

    if (kReleaseMode) {
      // Send to crash reporting service
    }

    return true;
  };

  runApp(MyApp());
}
```

### Try-Catch Logging

```dart
class DataService {
  final logger = FeatureLogger('DATA_SERVICE');

  Future<List<Item>> fetchItems() async {
    logger.info('Fetching items from API');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        logger.info('Successfully fetched ${items.length} items');
        return items;
      } else {
        logger.warning('API returned status: ${response.statusCode}');
        throw ApiException('Unexpected status code');
      }
    } on SocketException catch (e, stackTrace) {
      logger.error('Network error', e, stackTrace);
      throw NetworkException('No internet connection');
    } on FormatException catch (e, stackTrace) {
      logger.error('Invalid data format', e, stackTrace);
      throw DataException('Invalid response format');
    } catch (e, stackTrace) {
      logger.error('Unknown error while fetching items', e, stackTrace);
      rethrow;
    }
  }
}
```

## Production Logging Best Practices

### 1. Never Log Sensitive Information

```dart
// ❌ BAD: Logging sensitive data
logger.d('User password: $password');
logger.d('Credit card: $cardNumber');
logger.d('API key: $apiKey');

// ✅ GOOD: Redact or omit sensitive data
logger.d('User authenticated successfully');
logger.d('Payment processed');
logger.d('API call authenticated');
```

### 2. Use Appropriate Log Levels

```dart
// ❌ BAD: Everything is an error
logger.e('User clicked button');
logger.e('Data loaded successfully');

// ✅ GOOD: Use correct levels
logger.d('User clicked button');          // Debug
logger.i('Data loaded successfully');     // Info
logger.w('Slow network detected');        // Warning
logger.e('Failed to save', error, stack); // Error
```

### 3. Include Context

```dart
// ❌ BAD: Vague messages
logger.e('Error occurred');
logger.w('Invalid value');

// ✅ GOOD: Detailed context
logger.e('Failed to save journal entry', error: e, userId: userId);
logger.w('Invalid email format provided: $email');
```

### 4. Disable Debug Logs in Release

```dart
import 'package:flutter/foundation.dart';

void logDebug(String message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}

// Or use logger package with ProductionFilter
final logger = Logger(
  filter: ProductionFilter(), // Only logs warning and above in release
);
```

## Log Rotation and Management

### Limit Log File Size

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RotatingFileOutput extends LogOutput {
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const int maxFiles = 5;

  File? _currentFile;
  int _fileIndex = 0;

  @override
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _currentFile = File('${directory.path}/app_log_$_fileIndex.txt');
  }

  @override
  void output(OutputEvent event) async {
    if (_currentFile != null) {
      // Check file size
      if (await _currentFile!.length() > maxFileSize) {
        _fileIndex = (_fileIndex + 1) % maxFiles;
        final directory = await getApplicationDocumentsDirectory();
        _currentFile = File('${directory.path}/app_log_$_fileIndex.txt');
        await _currentFile!.writeAsString(''); // Clear file
      }

      for (var line in event.lines) {
        await _currentFile!.writeAsString(
          '${DateTime.now()}: $line\n',
          mode: FileMode.append,
        );
      }
    }
  }
}
```

## Quick Reference

### Log Level Guide

| Level | When to Use | Example |
|-------|-------------|---------|
| Debug | Development details | `logger.d('Widget rebuilt with value: $value')` |
| Info | Normal operations | `logger.i('User logged in successfully')` |
| Warning | Potential issues | `logger.w('API response slower than 2s')` |
| Error | Recoverable errors | `logger.e('Failed to save, retrying...', error)` |
| Fatal | Critical failures | `logger.f('Database corrupted', error, stack)` |

### Common Patterns

```dart
// Logging function entry/exit
void myFunction(String param) {
  logger.d('myFunction called with param: $param');
  // Function logic
  logger.d('myFunction completed');
}

// Logging API calls
try {
  logger.i('Calling API: $endpoint');
  final response = await http.get(endpoint);
  logger.i('API response: ${response.statusCode}');
} catch (e, stack) {
  logger.e('API call failed', e, stack);
}

// Logging state changes
void updateState(newValue) {
  logger.d('State changing from $_value to $newValue');
  setState(() {
    _value = newValue;
  });
}
```

---

**Resources:**
- [Logger Package Documentation](https://pub.dev/packages/logger)
- [Dart Logging Best Practices](https://dart.dev/guides/libraries/library-tour#dartdeveloper)
- [Flutter Debugging Tools](https://docs.flutter.dev/testing/debugging)
