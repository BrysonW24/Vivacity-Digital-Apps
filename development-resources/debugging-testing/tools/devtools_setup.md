# Flutter DevTools Setup Guide

## Overview
Flutter DevTools is a suite of performance and debugging tools for Flutter and Dart applications. It provides insights into UI performance, memory usage, network calls, and more.

## Installation

DevTools comes bundled with Flutter SDK (version 1.9.1+). No separate installation required.

## Launching DevTools

### Method 1: From Command Line
```bash
# Start your Flutter app first
flutter run

# In another terminal, launch DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

### Method 2: From VS Code
1. Install the **Dart** and **Flutter** extensions
2. Run your app with F5 or "Run > Start Debugging"
3. Click the "Open DevTools" button in the debug toolbar
4. Or use Command Palette: `Dart: Open DevTools`

### Method 3: From Android Studio
1. Run your Flutter app
2. Click the **Flutter DevTools** icon in the toolbar
3. Or go to `View > Tool Windows > Flutter Performance`

### Method 4: From Browser
```bash
flutter run
# Look for the line: "The Flutter DevTools debugger and profiler on <device> is available at: http://127.0.0.1:9100?uri=..."
# Open that URL in Chrome/Edge
```

## Key Features

### 1. Flutter Inspector
- **Widget Tree**: Visualize widget hierarchy
- **Layout Explorer**: Debug layout issues
- **Details Tree**: Inspect widget properties
- **Select Widget Mode**: Click on app UI to select widget

**Common Use Cases:**
- Finding why widgets overflow
- Understanding widget rebuild behavior
- Verifying widget properties

### 2. Performance View
- **Frame Rendering**: Identify jank and dropped frames
- **Timeline Events**: See what's taking time
- **CPU Profiler**: Find performance bottlenecks
- **Shader Compilation**: Track shader warmup

**Thresholds:**
- Green bar (< 16ms): 60 FPS ✅
- Red bar (> 16ms): Jank detected ⚠️

### 3. Memory View
- **Memory Usage Graph**: Track heap usage over time
- **Allocation Tracking**: See what's consuming memory
- **Snapshot Comparison**: Find memory leaks
- **GC Events**: Monitor garbage collection

**Warning Signs:**
- Continuously growing memory usage
- Memory not released after navigation
- Large object allocations

### 4. Network View
- **HTTP/HTTPS Traffic**: Monitor API calls
- **Request/Response Details**: Inspect headers and body
- **Timing Information**: See network latency
- **WebSocket Monitoring**: Track real-time connections

### 5. Logging View
- **Print Statements**: See all `debugPrint()` output
- **Error Messages**: View exceptions and stack traces
- **Custom Logs**: Filter by severity level
- **Search & Filter**: Find specific log entries

### 6. App Size Tool
- **APK/IPA Analysis**: Break down app size
- **Package Dependencies**: See what's taking space
- **Tree Map View**: Visualize size distribution

## Best Practices

### During Development
```dart
import 'package:flutter/foundation.dart';

// Use debugPrint instead of print
debugPrint('User logged in: $userId');

// Add performance timing
Stopwatch stopwatch = Stopwatch()..start();
// ... expensive operation
debugPrint('Operation took: ${stopwatch.elapsedMilliseconds}ms');

// Check for debug mode
if (kDebugMode) {
  debugPrint('This only runs in debug mode');
}
```

### Performance Profiling
1. **Always profile in release mode** for accurate results:
   ```bash
   flutter run --release --profile
   ```
2. Use the Performance view to identify slow frames
3. Look for expensive `build()` methods
4. Check for unnecessary widget rebuilds

### Memory Profiling
1. Take a memory snapshot before and after an action
2. Compare snapshots to find leaks
3. Look for:
   - Listeners not disposed
   - Streams not closed
   - Large images in memory
   - Cached data not cleared

### Network Debugging
1. Monitor all API calls in the Network tab
2. Check for:
   - Slow response times
   - Large payload sizes
   - Failed requests
   - Unnecessary repeated calls

## Keyboard Shortcuts

| Action | Windows/Linux | macOS |
|--------|--------------|-------|
| Open DevTools | `Ctrl+Shift+P` then type "devtools" | `Cmd+Shift+P` |
| Toggle Inspector | `Ctrl+Shift+I` | `Cmd+Shift+I` |
| Hot Reload | `r` in terminal | `r` in terminal |
| Hot Restart | `R` in terminal | `R` in terminal |

## Troubleshooting

### DevTools won't connect
```bash
# Ensure Flutter is up to date
flutter upgrade

# Clear DevTools cache
flutter pub cache repair

# Restart with verbose logging
flutter run --verbose
```

### Performance view shows no data
- Make sure you're running in profile or debug mode
- Click "Record" button to start profiling
- Perform actions in your app
- Click "Stop" to analyze

### Memory view is empty
- Click "Snapshot" to capture current heap
- Perform actions that might leak memory
- Take another snapshot
- Use "Diff" to compare

## Resources

- [Official DevTools Documentation](https://docs.flutter.dev/tools/devtools)
- [Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Debugging Flutter Apps](https://docs.flutter.dev/testing/debugging)

## Quick Checklist

- [ ] DevTools opens successfully
- [ ] Can connect to running app
- [ ] Flutter Inspector shows widget tree
- [ ] Performance view records frames
- [ ] Memory view shows heap usage
- [ ] Network view captures HTTP calls
- [ ] Logging view displays print statements

---

**Need Help?** Check the [Flutter DevTools Issues](https://github.com/flutter/devtools/issues) or contact the development team.
