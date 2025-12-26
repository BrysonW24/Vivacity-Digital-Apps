# Sentry Integration Guide for Flutter

## Overview

Sentry is an open-source error tracking and performance monitoring platform that helps developers monitor and fix crashes in real-time.

## Setup

### 1. Create Sentry Account

1. Go to [sentry.io](https://sentry.io)
2. Create account or sign in
3. Create new project → Select **Flutter**
4. Copy your **DSN** (Data Source Name)

### 2. Add Dependencies

```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^7.14.0

dev_dependencies:
  flutter_test:
    sdk: flutter
```

```bash
flutter pub get
```

### 3. Initialize Sentry

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN_HERE';

      // Set trace sample rate (0.0 to 1.0)
      // 1.0 = 100% of transactions for performance monitoring
      options.tracesSampleRate = 1.0;

      // Set environment
      options.environment = 'production';  // or 'development', 'staging'

      // Enable debug mode (only in development)
      options.debug = false;

      // Attach screenshots on errors
      options.attachScreenshot = true;

      // Attach view hierarchy
      options.attachViewHierarchy = true;
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### 4. Environment-Based Configuration

```dart
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN_HERE';

      if (kDebugMode) {
        // Debug mode settings
        options.environment = 'development';
        options.tracesSampleRate = 1.0;  // 100% sampling
        options.debug = true;  // Print debug info
      } else if (kProfileMode) {
        // Profile mode settings
        options.environment = 'staging';
        options.tracesSampleRate = 0.5;  // 50% sampling
      } else {
        // Release mode settings
        options.environment = 'production';
        options.tracesSampleRate = 0.1;  // 10% sampling
        options.debug = false;
      }
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

## Usage

### Capturing Errors

#### 1. Automatic Error Capture

Already configured in `SentryFlutter.init()` - captures unhandled errors automatically.

#### 2. Manual Error Capture

```dart
import 'package:sentry_flutter/sentry_flutter.dart';

try {
  await riskyOperation();
} catch (exception, stackTrace) {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
  );
}
```

#### 3. With Additional Context

```dart
try {
  await processPayment(userId);
} catch (exception, stackTrace) {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
    hint: Hint.withMap({
      'user_id': userId,
      'payment_method': 'credit_card',
      'timestamp': DateTime.now().toIso8601String(),
    }),
  );
}
```

### Capturing Messages

```dart
// Info message
await Sentry.captureMessage(
  'User completed onboarding',
  level: SentryLevel.info,
);

// Warning
await Sentry.captureMessage(
  'API response time exceeded 2 seconds',
  level: SentryLevel.warning,
);

// Error
await Sentry.captureMessage(
  'Payment gateway timeout',
  level: SentryLevel.error,
);
```

### Adding Breadcrumbs

Breadcrumbs are trail of events leading up to an error:

```dart
// Add navigation breadcrumb
Sentry.addBreadcrumb(
  Breadcrumb(
    message: 'Navigated to HomeScreen',
    category: 'navigation',
    level: SentryLevel.info,
  ),
);

// Add user action breadcrumb
Sentry.addBreadcrumb(
  Breadcrumb(
    message: 'User clicked save button',
    category: 'ui.click',
    level: SentryLevel.info,
    data: {'button_id': 'save_entry'},
  ),
);

// Add API call breadcrumb
Sentry.addBreadcrumb(
  Breadcrumb(
    message: 'API request to /api/entries',
    category: 'http',
    level: SentryLevel.info,
    data: {
      'method': 'POST',
      'url': 'https://api.example.com/entries',
      'status_code': 201,
    },
  ),
);
```

### Setting User Context

```dart
// Set user information
await Sentry.configureScope(
  (scope) => scope.setUser(
    SentryUser(
      id: user.id,
      email: user.email,
      username: user.username,
      data: {
        'subscription': user.subscriptionTier,
        'login_count': user.loginCount,
      },
    ),
  ),
);

// Clear user on logout
await Sentry.configureScope(
  (scope) => scope.setUser(null),
);
```

### Setting Tags

```dart
await Sentry.configureScope((scope) {
  scope.setTag('environment', 'production');
  scope.setTag('feature', 'journal_editor');
  scope.setTag('platform', Platform.operatingSystem);
  scope.setTag('app_version', '1.2.3');
});
```

### Setting Custom Context

```dart
await Sentry.configureScope((scope) {
  scope.setContexts('app_state', {
    'current_screen': 'HomeScreen',
    'items_loaded': 42,
    'network_status': 'connected',
  });

  scope.setContexts('device', {
    'battery_level': '75%',
    'storage_free': '2.5GB',
  });
});
```

## Performance Monitoring

### Transaction Tracking

```dart
// Start a transaction
final transaction = Sentry.startTransaction(
  'load_entries',
  'task',
);

try {
  // Create spans for sub-operations
  final fetchSpan = transaction.startChild('fetch_from_db');
  final entries = await database.fetchEntries();
  await fetchSpan.finish(status: SpanStatus.ok());

  final parseSpan = transaction.startChild('parse_entries');
  final parsedEntries = parseEntries(entries);
  await parseSpan.finish(status: SpanStatus.ok());

  await transaction.finish(status: SpanStatus.ok());
} catch (e) {
  await transaction.finish(status: SpanStatus.internalError());
  rethrow;
}
```

### HTTP Performance Tracking

Sentry automatically tracks HTTP calls with `sentry_http` package:

```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^7.14.0
  http: ^1.1.0
```

```dart
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:http/http.dart' as http;

// Create a client with Sentry tracking
final client = SentryHttpClient();

// All requests are automatically tracked
final response = await client.get(Uri.parse('https://api.example.com/data'));

// Don't forget to close the client
client.close();
```

### Navigation Performance

```dart
import 'package:sentry_flutter/sentry_flutter.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        SentryNavigatorObserver(),  // Automatically track navigation
      ],
      home: HomeScreen(),
    );
  }
}
```

## Advanced Features

### Custom Error Handler

```dart
class SentryErrorHandler {
  static Future<void> captureError(
    dynamic exception,
    StackTrace stackTrace, {
    String? feature,
    Map<String, dynamic>? extras,
  }) async {
    await Sentry.configureScope((scope) {
      if (feature != null) {
        scope.setTag('feature', feature);
      }

      if (extras != null) {
        scope.setContexts('extras', extras);
      }
    });

    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}

// Usage
try {
  await saveEntry(entry);
} catch (e, stack) {
  await SentryErrorHandler.captureError(
    e,
    stack,
    feature: 'journal',
    extras: {
      'entry_id': entry.id,
      'entry_length': entry.content.length,
    },
  );
}
```

### Filtered Error Reporting

```dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_DSN';

      // Filter out certain exceptions
      options.beforeSend = (event, hint) {
        // Don't send errors containing "network"
        if (event.message?.formatted?.contains('network') == true) {
          return null;  // Return null to prevent sending
        }

        // Redact sensitive data
        if (event.user != null) {
          event = event.copyWith(
            user: event.user!.copyWith(
              email: 'REDACTED',
            ),
          );
        }

        return event;  // Send the event
      };

      // Filter breadcrumbs
      options.beforeBreadcrumb = (breadcrumb, hint) {
        // Don't log HTTP breadcrumbs
        if (breadcrumb.category == 'http') {
          return null;
        }
        return breadcrumb;
      };
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### Release Tracking

```dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_DSN';

      // Set release version
      options.release = 'my-app@1.2.3+42';

      // Set distribution (optional)
      options.dist = '42';
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### Source Maps for Web

```bash
# Build with source maps
flutter build web --source-maps

# Upload source maps to Sentry
sentry-cli releases files "my-app@1.2.3" upload-sourcemaps build/web
```

## Best Practices

### 1. Add Context to Every Error

```dart
class JournalService {
  final _logger = SentryLogger('journal');

  Future<void> saveEntry(JournalEntry entry) async {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: 'Attempting to save entry',
        category: 'journal',
        data: {'entry_id': entry.id},
      ),
    );

    try {
      await _repository.save(entry);

      Sentry.addBreadcrumb(
        Breadcrumb(
          message: 'Entry saved successfully',
          category: 'journal',
          level: SentryLevel.info,
        ),
      );
    } catch (e, stack) {
      await Sentry.captureException(
        e,
        stackTrace: stack,
        hint: Hint.withMap({
          'feature': 'journal',
          'action': 'save_entry',
          'entry_id': entry.id,
          'entry_size': entry.content.length,
        }),
      );
      rethrow;
    }
  }
}
```

### 2. Don't Report PII (Personally Identifiable Information)

```dart
// ❌ BAD
await Sentry.configureScope((scope) {
  scope.setUser(SentryUser(
    email: 'user@example.com',  // Don't send actual email
    username: 'john_doe',        // Don't send actual username
  ));
});

// ✅ GOOD
await Sentry.configureScope((scope) {
  scope.setUser(SentryUser(
    id: hashUserId(user.id),  // Hash the ID
    data: {
      'subscription_tier': user.tier,
      'signup_date': user.signupDate.year.toString(),  // Year only
    },
  ));
});
```

### 3. Use Appropriate Sample Rates

```dart
await SentryFlutter.init(
  (options) {
    options.dsn = 'YOUR_DSN';

    // Production: Low sample rate
    if (kReleaseMode) {
      options.tracesSampleRate = 0.1;  // 10% of transactions
    }
    // Development: High sample rate
    else {
      options.tracesSampleRate = 1.0;  // 100% of transactions
    }
  },
  appRunner: () => runApp(MyApp()),
);
```

### 4. Group Errors with Fingerprints

```dart
try {
  await apiCall();
} catch (e, stack) {
  await Sentry.captureException(
    e,
    stackTrace: stack,
    hint: Hint.withMap({
      'fingerprint': ['api-error', endpoint],  // Group by endpoint
    }),
  );
}
```

## Testing Sentry Integration

```dart
// Add test button in debug mode
if (kDebugMode) {
  ElevatedButton(
    onPressed: () async {
      try {
        throw Exception('Test Sentry exception');
      } catch (e, stack) {
        await Sentry.captureException(e, stackTrace: stack);
      }
    },
    child: Text('Test Sentry'),
  );
}
```

## Viewing Issues in Sentry

1. Go to [sentry.io](https://sentry.io)
2. Select your project
3. View:
   - **Issues**: All errors grouped
   - **Performance**: Transaction traces
   - **Releases**: Version-specific issues
   - **Discover**: Custom queries

### Key Metrics

- **Event Volume**: Number of errors over time
- **Users Affected**: Unique users experiencing errors
- **Crash-Free Sessions**: Percentage of sessions without crashes
- **Apdex Score**: Performance satisfaction metric

## Troubleshooting

### Events Not Appearing

1. **Check DSN is correct**
2. **Enable debug mode:**
   ```dart
   options.debug = true;
   ```
3. **Check console for Sentry logs**
4. **Verify network connection**
5. **Wait a few moments** (processing delay)

### Too Many Events

**Set sample rate:**
```dart
options.sampleRate = 0.5;  // Send 50% of errors
options.tracesSampleRate = 0.1;  // Send 10% of transactions
```

### Duplicate Events

**Use fingerprints to group:**
```dart
hint: Hint.withMap({
  'fingerprint': ['my-unique-error-group'],
})
```

## Quick Reference

```dart
// Capture exception
Sentry.captureException(exception, stackTrace: stackTrace);

// Capture message
Sentry.captureMessage('Message', level: SentryLevel.warning);

// Add breadcrumb
Sentry.addBreadcrumb(Breadcrumb(message: 'Event', category: 'action'));

// Set user
Sentry.configureScope((scope) => scope.setUser(SentryUser(id: '123')));

// Set tag
Sentry.configureScope((scope) => scope.setTag('key', 'value'));

// Start transaction
final transaction = Sentry.startTransaction('name', 'operation');
// ... do work
await transaction.finish();

// Clear scope
Sentry.configureScope((scope) => scope.clear());
```

---

**Resources:**
- [Sentry Documentation](https://docs.sentry.io/)
- [Sentry Flutter SDK](https://docs.sentry.io/platforms/flutter/)
- [Sentry Console](https://sentry.io/)
- [Performance Monitoring Guide](https://docs.sentry.io/product/performance/)
