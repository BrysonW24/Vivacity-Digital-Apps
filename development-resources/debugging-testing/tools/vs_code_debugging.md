# VS Code Debugging Guide for Flutter

## Prerequisites

### Required Extensions
1. **Dart** (required)
   - Publisher: Dart Code
   - ID: `Dart-Code.dart-code`

2. **Flutter** (required)
   - Publisher: Dart Code
   - ID: `Dart-Code.flutter`

3. **Error Lens** (recommended)
   - Shows errors inline in the editor
   - ID: `usernamehw.errorlens`

## Setting Up VS Code for Debugging

### 1. Install Extensions
```bash
# Open VS Code
# Press Ctrl+Shift+X (Windows/Linux) or Cmd+Shift+X (macOS)
# Search for "Dart" and "Flutter" and install both
```

### 2. Configure launch.json

Create `.vscode/launch.json` in your project root:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Debug)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "debug"
    },
    {
      "name": "Flutter (Profile)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "profile"
    },
    {
      "name": "Flutter (Release)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "release"
    },
    {
      "name": "Flutter (Chrome)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": [
        "-d",
        "chrome"
      ]
    },
    {
      "name": "Flutter (Windows)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": [
        "-d",
        "windows"
      ]
    }
  ]
}
```

### 3. Configure settings.json

Create/edit `.vscode/settings.json`:

```json
{
  "dart.debugExternalPackageLibraries": true,
  "dart.debugSdkLibraries": false,
  "dart.previewFlutterUiGuides": true,
  "dart.previewFlutterUiGuidesCustomTracking": true,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.rulers": [80],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": "off"
  }
}
```

## Using Breakpoints

### Setting Breakpoints
1. Click in the gutter (left of line numbers)
2. Red dot appears = breakpoint set
3. Or press `F9` on any line

### Types of Breakpoints

**Standard Breakpoint**
```dart
void _incrementCounter() {
  setState(() {
    _counter++; // ← Click here to set breakpoint
  });
}
```

**Conditional Breakpoint**
- Right-click in gutter > "Add Conditional Breakpoint"
- Enter condition: `_counter > 5`
- Only breaks when condition is true

**Logpoint**
- Right-click > "Add Logpoint"
- Enter message: `Counter value: {_counter}`
- Logs without stopping execution

## Debug Controls

### Toolbar Buttons
| Icon | Action | Shortcut | Description |
|------|--------|----------|-------------|
| ▶️ | Continue | `F5` | Resume execution |
| ⏸️ | Pause | `F6` | Pause execution |
| ⤵️ | Step Over | `F10` | Execute current line, don't step into functions |
| ⤴️ | Step Into | `F11` | Step into function calls |
| ⤴️ | Step Out | `Shift+F11` | Step out of current function |
| 🔄 | Restart | `Ctrl+Shift+F5` | Restart debug session |
| ⏹️ | Stop | `Shift+F5` | Stop debugging |

### Hot Reload & Hot Restart

**Hot Reload (r)**: Updates code without losing state
```bash
# In Debug Console, type: r
# Or click the lightning bolt icon
# Or press Ctrl+F5 (Windows) / Cmd+F5 (macOS)
```

**Hot Restart (R)**: Resets app state
```bash
# In Debug Console, type: R
# Or click the restart icon
```

## Debug Views

### 1. Variables View
Shows all variables in current scope:
```dart
void example() {
  int count = 5;        // ← Visible in Variables view
  String name = "Test"; // ← Visible in Variables view
  debugger(); // Breakpoint here
}
```

### 2. Watch Expressions
Add expressions to monitor:
- Click `+` in WATCH panel
- Enter: `_counter * 2`
- Value updates as you step through code

### 3. Call Stack
Shows function call hierarchy:
```
#0  _MyHomePageState._incrementCounter (package:app/main.dart:45)
#1  _InkResponseState._handleTap (package:flutter/material/ink_well.dart:1005)
#2  GestureRecognizer.invokeCallback (package:flutter/gestures/recognizer.dart:193)
```

### 4. Debug Console
Interactive Dart REPL:
```dart
// Type expressions to evaluate:
_counter
_counter + 10
widget.title

// Call functions:
_incrementCounter()
setState(() => _counter = 0)
```

## Advanced Debugging Techniques

### 1. Exception Breakpoints

**Break on All Exceptions**
```json
// In launch.json
{
  "configurations": [{
    "exceptionPauseMode": "All" // Breaks on every exception
  }]
}
```

**Break on Uncaught Exceptions Only**
```json
{
  "exceptionPauseMode": "Unhandled"
}
```

### 2. Debugging Async Code

```dart
Future<void> fetchData() async {
  print('Start fetch'); // Breakpoint here

  final response = await http.get(url); // Breakpoint here

  print('Got response'); // Breakpoint here

  return response;
}
```

### 3. Debugging Build Methods

```dart
@override
Widget build(BuildContext context) {
  debugPrint('Building MyWidget'); // Logs every rebuild

  // Set breakpoint here to inspect context
  return Container(
    child: Text('Value: $_value'),
  );
}
```

### 4. Using debugger() Statement

```dart
import 'dart:developer';

void problematicFunction() {
  // Code execution will pause here
  debugger(when: someCondition, message: 'Check this state');

  // Continue with logic
}
```

## Debugging Widgets

### Flutter Inspector Integration

1. **Select Widget Mode**
   - Click inspector icon in debug toolbar
   - Click on widget in app
   - VS Code highlights corresponding code

2. **Show/Hide Debug Paint**
   ```dart
   // In VS Code command palette:
   > Flutter: Toggle Debug Painting
   ```

3. **Show Performance Overlay**
   ```dart
   // In MaterialApp:
   MaterialApp(
     showPerformanceOverlay: true,
     debugShowCheckedModeBanner: false,
   )
   ```

## Common Debugging Scenarios

### Scenario 1: Widget Not Rebuilding

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;

  void _increment() {
    // ❌ WRONG: No setState
    _counter++;

    // ✅ CORRECT: Wrap in setState
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building with counter: $_counter'); // Add breakpoint
    return Text('$_counter');
  }
}
```

**Debug Steps:**
1. Set breakpoint in `_increment()`
2. Check if `setState()` is called
3. Set breakpoint in `build()`
4. Verify it's called after state change

### Scenario 2: Null Reference Error

```dart
void processUser(User? user) {
  // Set breakpoint here
  debugger(when: user == null, message: 'User is null!');

  // Safe access
  final name = user?.name ?? 'Unknown';
  print('Name: $name');
}
```

### Scenario 3: Async Operation Not Completing

```dart
Future<void> loadData() async {
  print('1. Start loading'); // Breakpoint

  try {
    final data = await repository.fetchData(); // Breakpoint
    print('2. Data loaded: $data'); // Breakpoint

    setState(() {
      _data = data; // Breakpoint
    });
  } catch (e) {
    print('3. Error: $e'); // Breakpoint
  }
}
```

## Performance Debugging

### Finding Slow Operations

```dart
import 'dart:developer';

void expensiveOperation() {
  Timeline.startSync('Expensive Operation');

  // Your code here

  Timeline.finishSync();
}
```

View in DevTools Performance tab.

### Identifying Widget Rebuilds

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('⚠️ MyWidget rebuilt at ${DateTime.now()}');
    return Container();
  }
}
```

## Keyboard Shortcuts Cheat Sheet

| Action | Windows/Linux | macOS |
|--------|--------------|-------|
| Start Debugging | `F5` | `F5` |
| Start Without Debugging | `Ctrl+F5` | `Cmd+F5` |
| Toggle Breakpoint | `F9` | `F9` |
| Step Over | `F10` | `F10` |
| Step Into | `F11` | `F11` |
| Step Out | `Shift+F11` | `Shift+F11` |
| Continue | `F5` | `F5` |
| Stop | `Shift+F5` | `Shift+F5` |
| Restart | `Ctrl+Shift+F5` | `Cmd+Shift+F5` |
| Open Debug Console | `Ctrl+Shift+Y` | `Cmd+Shift+Y` |
| Command Palette | `Ctrl+Shift+P` | `Cmd+Shift+P` |

## Troubleshooting

### Breakpoints Not Hitting

**Check:**
1. Code is actually being executed
2. Hot reload was successful
3. No syntax errors preventing compilation
4. Breakpoint is in reachable code path

**Solution:**
```bash
# Do a full hot restart
# Press Shift+F5 to stop
# Press F5 to start fresh
```

### Debug Console Not Showing Output

**Check settings.json:**
```json
{
  "dart.flutterRunLogFile": "${workspaceFolder}/logs/flutter-run.log"
}
```

### Can't See Variable Values

Enable in settings:
```json
{
  "dart.debugExternalPackageLibraries": true,
  "dart.debugSdkLibraries": true
}
```

## Best Practices

1. **Use descriptive breakpoint conditions**
   ```dart
   // Condition: userId == "123" && isLoggedIn
   ```

2. **Leverage logpoints for quick debugging**
   - Faster than adding print statements
   - No need to modify code

3. **Use hot reload efficiently**
   - Most UI changes: Hot reload (`r`)
   - State reset needed: Hot restart (`R`)
   - Major changes: Full restart (`Shift+F5` → `F5`)

4. **Watch key expressions**
   - Add state variables to WATCH panel
   - Monitor complex expressions

5. **Keep Debug Console open**
   - Shows build errors
   - Displays print statements
   - Interactive REPL available

---

**Resources:**
- [VS Code Dart Extension Docs](https://dartcode.org/)
- [Flutter Debugging Guide](https://docs.flutter.dev/testing/debugging)
- [Dart DevTools](https://dart.dev/tools/dart-devtools)
