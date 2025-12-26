// Advanced Flutter - High-Performance UI and Platform Integrations
// This repository contains advanced Flutter topics for scalable and optimized applications.

//==========================================//

// Advanced Flutter - Table of Contents
// 01_custom_rendering.dart - Drawing custom UI with RenderObjects
// 02_advanced_animations.dart - Building complex animations with TickerProvider
// 03_shaders_and_graphics.dart - Using shaders and 3D graphics in Flutter
// 04_isolate_computing.dart - Running expensive operations in Isolates
// 05_ffi_flutter.dart - Integrating native C/C++ with Dart FFI
// 06_plugin_development.dart - Building custom Flutter plugins
// 07_platform_view.dart - Embedding native Android/iOS views
// 08_flutter_web_advanced.dart - Advanced web optimizations
// 09_performance_profiling.dart - Using DevTools for profiling
// 10_memory_optimization.dart - Reducing memory leaks and improving GC

//==========================================//

// 01_custom_rendering.dart - Drawing custom UI with RenderObjects
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomRenderBox extends RenderBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint paint = Paint()..color = const Color(0xFF00FF00);
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  void performLayout() {
    size = const Size(100, 100);
  }
}

class CustomRenderObjectWidget extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderBox();
  }
}

void main() {
  runApp(const Center(child: CustomRenderObjectWidget()));
}

//==========================================//

// 02_advanced_animations.dart - Building complex animations with TickerProvider
import 'package:flutter/material.dart';

class AdvancedAnimation extends StatefulWidget {
  const AdvancedAnimation({super.key});

  @override
  _AdvancedAnimationState createState() => _AdvancedAnimationState();
}

class _AdvancedAnimationState extends State<AdvancedAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(opacity: _controller, child: Container(color: Colors.blue, width: 200, height: 200)),
      ),
    );
  }
}

//==========================================//

// 03_shaders_and_graphics.dart - Using shaders and 3D graphics in Flutter
import 'package:flutter/material.dart';

void main() {
  runApp(const ShaderExample());
}

class ShaderExample extends StatelessWidget {
  const ShaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shader Example")),
      body: const Center(child: Text('Shaders not natively supported in Flutter yet!')),
    );
  }
}

//==========================================//

// 04_isolate_computing.dart - Running expensive operations in Isolates
import 'dart:isolate';

void computeHeavyTask(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 10000000; i++) {
    sum += i;
  }
  sendPort.send(sum);
}

void main() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(computeHeavyTask, receivePort.sendPort);
  receivePort.listen((message) => print('Computed sum: $message'));
}

//==========================================//

// 05_ffi_flutter.dart - Integrating native C/C++ with Dart FFI
import 'dart:ffi';

typedef CAddFunc = Int32 Function(Int32, Int32);
typedef DartAddFunc = int Function(int, int);

void main() {
  final DynamicLibrary lib = DynamicLibrary.open('libnative.so');
  final DartAddFunc add = lib.lookupFunction<CAddFunc, DartAddFunc>('add');
  print(add(3, 5));
}

//==========================================//

// 06_plugin_development.dart - Building custom Flutter plugins
// Flutter plugins are developed using platform channels in `android/` and `ios/` native directories.

//==========================================//

// 07_platform_view.dart - Embedding native Android/iOS views
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NativeViewExample());
}

class NativeViewExample extends StatelessWidget {
  const NativeViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    const platformView = AndroidView(viewType: 'native_view');
    return Scaffold(
      appBar: AppBar(title: const Text('Native View Example')),
      body: const Center(child: platformView),
    );
  }
}

//==========================================//

// 08_flutter_web_advanced.dart - Advanced web optimizations
// Tips for optimizing Flutter web apps include:
// - Using deferred imports for large libraries
// - Minimizing widget rebuilds
// - Using WebAssembly for computationally expensive tasks

//==========================================//

// 09_performance_profiling.dart - Using DevTools for profiling
// Use `flutter pub global activate devtools` to enable profiling
// Run `flutter run --profile` to profile performance

//==========================================//

// 10_memory_optimization.dart - Reducing memory leaks and improving GC
class LargeObject {
  final List<int> data = List.filled(1000000, 42);
}

void main() {
  List<LargeObject> objects = [];
  for (int i = 0; i < 100; i++) {
    objects.add(LargeObject());
  }
  print('Created 100 large objects');
}

