# Android Studio Debugging Guide for Flutter

## Prerequisites

- Android Studio (latest stable version recommended)
- Flutter plugin installed
- Dart plugin installed

## Initial Setup

### 1. Install Required Plugins

1. Open Android Studio
2. Go to `File > Settings` (Windows/Linux) or `Android Studio > Preferences` (macOS)
3. Navigate to `Plugins`
4. Search and install:
   - **Flutter** plugin
   - **Dart** plugin (usually installs with Flutter)

### 2. Configure Flutter SDK

1. `File > Settings > Languages & Frameworks > Flutter`
2. Set Flutter SDK path (e.g., `C:\src\flutter` or `/Users/username/flutter`)
3. Click "Apply"

### 3. Import Flutter Project

```
File > Open > [Select your Flutter project root folder]
```

## Starting a Debug Session

### Method 1: Using the Play Button

1. Select target device from dropdown (top toolbar)
2. Click green "Debug" button (bug icon) or press `Shift+F9`
3. Wait for build and app launch

### Method 2: Using Run Configurations

1. `Run > Edit Configurations`
2. Click `+` > `Flutter`
3. Configure:
   - **Name**: "Flutter Debug (Windows)"
   - **Dart entrypoint**: `lib/main.dart`
   - **Build flavor**: (optional)
   - **Additional args**: `--dart-define=ENV=dev`
4. Click "OK"
5. Select configuration and press `Shift+F9`

## Using Breakpoints

### Setting Breakpoints

**Standard Breakpoint:**
- Click in gutter (left margin) next to line number
- Red circle appears
- Or: Place cursor on line and press `Ctrl+F8`

**Conditional Breakpoint:**
1. Right-click on breakpoint
2. Select "More" or click gear icon
3. Enter condition: `_counter > 5`
4. Click "Done"

**Temporary Breakpoint:**
- Right-click in gutter > "Temporary Breakpoint"
- Removes itself after first hit

**Method Breakpoint:**
- Click on method name line
- Breaks whenever method is called

### Breakpoint Window

View all breakpoints: `Run > View Breakpoints` or `Ctrl+Shift+F8`

Features:
- Enable/disable breakpoints
- Set conditions
- Add log messages
- Group by file

## Debug Toolbar

When debugging starts, toolbar appears:

| Icon | Action | Shortcut | Description |
|------|--------|----------|-------------|
| ![Resume](▶️) | Resume | `F9` | Continue execution |
| ![Pause](⏸️) | Pause | - | Pause execution |
| ![Stop](⏹️) | Stop | `Ctrl+F2` | Stop debug session |
| ![Step Over](⤵️) | Step Over | `F8` | Execute line, skip function internals |
| ![Step Into](⬇️) | Step Into | `F7` | Enter function call |
| ![Force Step Into](⬇️⬇️) | Force Step Into | `Alt+Shift+F7` | Step into even library code |
| ![Step Out](⬆️) | Step Out | `Shift+F8` | Exit current function |
| ![Run to Cursor](➡️) | Run to Cursor | `Alt+F9` | Run until cursor position |

## Debug Windows

### 1. Debug Tool Window

Access: `View > Tool Windows > Debug` or `Alt+5`

**Tabs:**
- **Debugger**: Shows current execution point
- **Console**: Flutter output and logs
- **Threads & Variables**: Inspect state

### 2. Variables View

Shows all variables in current scope:

```dart
void _incrementCounter() {
  int localVar = 5; // ← Visible when breakpoint hit
  setState(() {
    _counter++; // ← _counter shown here
  });
}
```

**Features:**
- Expand objects to see properties
- Right-click > "Set Value" to change during debug
- Right-click > "Add to Watches"

### 3. Watches

Monitor specific expressions:

1. Click `+` in Watches panel
2. Enter expression: `_counter * 2`
3. Updates as you step through code

**Useful watches:**
```dart
widget.title
context.size
MediaQuery.of(context).size.width
Theme.of(context).primaryColor
```

### 4. Call Stack (Frames)

Shows execution path:

```
_MyHomePageState._incrementCounter (main.dart:45)
_InkResponseState._handleTap (ink_well.dart:1005)
GestureRecognizer.invokeCallback (recognizer.dart:193)
```

Click on any frame to inspect that scope's variables.

### 5. Console Output

Shows:
- `print()` and `debugPrint()` output
- Build errors
- Hot reload status
- Performance warnings

**Filters:**
- Click filter icon
- Check/uncheck: Info, Warning, Error

## Flutter-Specific Debug Tools

### Flutter Inspector

Access: `View > Tool Windows > Flutter Inspector`

**Features:**
1. **Select Widget Mode**
   - Click eye-dropper icon
   - Click widget in app
   - Corresponding code highlights

2. **Widget Tree**
   - Hierarchical view of all widgets
   - Click to inspect properties

3. **Render Tree**
   - Shows actual render objects
   - Useful for layout debugging

4. **Layout Explorer**
   - Visual representation of constraints
   - See padding, margins, alignment

5. **Debug Paint**
   - Toggle with checkbox
   - Shows widget boundaries
   - Displays padding, alignment, etc.

### Flutter Outline

Access: `View > Tool Windows > Flutter Outline`

Shows:
- Widget structure of current file
- Quick navigation
- Refactoring shortcuts

**Actions:**
- **Wrap with Widget**: Select widget > Alt+Enter > Wrap with
- **Extract Widget**: Select code > Alt+Enter > Extract
- **Move up/down**: Change widget order

### Flutter Performance

Access: `View > Tool Windows > Flutter Performance`

Monitors:
- Frame rendering time
- UI thread performance
- Raster thread performance
- Memory usage

**Target:**
- Green bars (< 16ms): 60 FPS ✅
- Red bars (> 16ms): Jank ⚠️

## Hot Reload & Hot Restart

### Hot Reload
- **Shortcut**: Click lightning bolt or press `Ctrl+\`
- **Effect**: Updates code without losing state
- **Use when**: UI changes, logic updates

```dart
// Before hot reload
Text('Hello World')

// Change to:
Text('Hello Flutter')

// Press Ctrl+\ - Text updates immediately
```

### Hot Restart
- **Shortcut**: Click circular arrow or `Ctrl+Shift+\`
- **Effect**: Restarts app, resets state
- **Use when**: State is corrupted, major changes

### Full Rebuild
- **Action**: Stop (Ctrl+F2) then Debug (Shift+F9)
- **Use when**: Dependencies change, platform code updates

## Debugging Techniques

### 1. Evaluate Expression

While debugging:
1. Right-click in editor or Variables view
2. Select "Evaluate Expression" or press `Alt+F8`
3. Enter expression: `_counter + 100`
4. Click "Evaluate"

**Uses:**
- Test calculations
- Call methods
- Modify state

```dart
// In evaluate dialog:
setState(() => _counter = 0)  // Reset counter
widget.title  // Check title
Navigator.of(context).canPop()  // Test navigation
```

### 2. Modify Variables

While stopped at breakpoint:
1. In Variables view, right-click variable
2. Select "Set Value"
3. Enter new value
4. Continue debugging with new value

### 3. Log Without Stopping

**Logpoint:**
1. Right-click in gutter
2. Select "More" > "Breakpoint Properties"
3. Check "Log evaluated expression"
4. Uncheck "Suspend"
5. Enter: `"Counter value: " + _counter.toString()`

**Result:** Logs to console without pausing execution.

### 4. Exception Breakpoints

`Run > View Breakpoints > [+] > Dart Exception Breakpoints`

Options:
- **All exceptions**: Pauses on every exception
- **Uncaught exceptions**: Only unhandled errors
- **Specific exception**: e.g., `FormatException`

```dart
try {
  int.parse('abc'); // FormatException
} catch (e) {
  print('Caught: $e');
}
```

### 5. Method Breakpoints

Click on method signature line:

```dart
class MyClass {
  void myMethod() {  // ← Click here
    // Breaks when method is called from anywhere
  }
}
```

## Debugging Async Code

```dart
Future<void> fetchData() async {
  debugPrint('1. Start fetch');  // Breakpoint 1

  final response = await http.get(url);  // Breakpoint 2

  debugPrint('2. Response: ${response.statusCode}');  // Breakpoint 3

  final data = jsonDecode(response.body);  // Breakpoint 4

  setState(() {
    _data = data;  // Breakpoint 5
  });
}
```

**Debugging steps:**
1. Set breakpoints at each step
2. Press F9 to move between breakpoints
3. Inspect variables at each stage
4. Use Frames view to see async call stack

## Performance Profiling

### Using Android Studio Profiler

1. Run app in profile mode:
   ```
   flutter run --profile
   ```

2. Open profiler: `View > Tool Windows > Profiler`

3. Select your app process

4. Monitor:
   - **CPU**: Identify hot methods
   - **Memory**: Track heap usage
   - **Network**: Monitor API calls

### Timeline Events

```dart
import 'dart:developer';

Timeline.startSync('Expensive Operation');
// Your code here
Timeline.finishSync();
```

View in DevTools Performance tab.

## Common Debugging Scenarios

### Scenario 1: Widget Not Rebuilding

```dart
class _MyWidgetState extends State<MyWidget> {
  int _count = 0;

  void _increment() {
    _count++;  // ❌ Won't trigger rebuild
    // Set breakpoint here to verify setState is missing
  }
}
```

**Fix:**
```dart
void _increment() {
  setState(() {
    _count++;  // ✅ Triggers rebuild
  });
}
```

**Debug steps:**
1. Breakpoint in `_increment()`
2. Check if `setState()` called
3. Breakpoint in `build()`
4. Verify rebuild occurs

### Scenario 2: Null Safety Error

```dart
void processUser(User? user) {
  // Breakpoint here
  final name = user!.name;  // Could crash
}
```

**Debug:**
1. Breakpoint before access
2. Inspect `user` variable
3. Check if null
4. Use safe access: `user?.name`

### Scenario 3: State Not Persisting

```dart
class _PageState extends State<Page> {
  late String data;

  @override
  void initState() {
    super.initState();
    loadData();  // Breakpoint here
  }

  void loadData() {
    data = fetchFromAPI();  // Breakpoint here
    // Inspect 'data' value
  }
}
```

## Keyboard Shortcuts Cheat Sheet

| Action | Windows/Linux | macOS |
|--------|--------------|-------|
| Debug | `Shift+F9` | `Ctrl+D` |
| Stop | `Ctrl+F2` | `Cmd+F2` |
| Resume | `F9` | `Cmd+Alt+R` |
| Step Over | `F8` | `F8` |
| Step Into | `F7` | `F7` |
| Step Out | `Shift+F8` | `Shift+F8` |
| Toggle Breakpoint | `Ctrl+F8` | `Cmd+F8` |
| View Breakpoints | `Ctrl+Shift+F8` | `Cmd+Shift+F8` |
| Evaluate Expression | `Alt+F8` | `Alt+F8` |
| Hot Reload | `Ctrl+\` | `Cmd+\` |
| Hot Restart | `Ctrl+Shift+\` | `Cmd+Shift+\` |

## Troubleshooting

### "Waiting for connection from debug service"

**Solutions:**
1. Ensure Flutter is up to date:
   ```bash
   flutter upgrade
   ```
2. Invalidate caches: `File > Invalidate Caches > Invalidate and Restart`
3. Rebuild project: `Build > Rebuild Project`

### Breakpoints Not Hitting

**Check:**
1. App is running in debug mode (not release)
2. Code is reachable (not in dead path)
3. Hot reload was successful
4. No compilation errors

**Solution:**
- Do full restart (`Ctrl+F2` then `Shift+F9`)

### Debug Console Empty

**Check:**
1. Console tab is selected (not Logcat)
2. Appropriate log level is selected
3. `debugPrint()` is being used (not just `print()`)

## Best Practices

1. **Use debug mode for debugging, profile mode for performance testing**
   ```bash
   flutter run              # Debug mode
   flutter run --profile    # Profile mode
   flutter run --release    # Release mode (no debugging)
   ```

2. **Leverage conditional breakpoints for efficiency**
   - Instead of breaking every time, break only when: `userId == "123"`

3. **Use Flutter Inspector frequently**
   - Visual debugging is faster than code inspection
   - Select Widget Mode saves time

4. **Watch key expressions**
   - Monitor complex calculations
   - Track state changes

5. **Keep Console visible**
   - Catch warnings early
   - Monitor rebuild frequency

6. **Profile before optimizing**
   - Use Performance tab to find actual bottlenecks
   - Don't guess where slowness occurs

---

**Resources:**
- [Android Studio Debugging Docs](https://developer.android.com/studio/debug)
- [Flutter Debugging Guide](https://docs.flutter.dev/testing/debugging)
- [Flutter Inspector Guide](https://docs.flutter.dev/tools/devtools/inspector)
