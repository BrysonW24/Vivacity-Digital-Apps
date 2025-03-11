// Advanced Dart - High-Performance Programming in Dart
// This repository contains advanced Dart programming concepts for scalable applications.

//==========================================//

// Advanced Dart - Table of Contents
// 01_functional_programming.dart - Higher-order functions, closures, and functional constructs
// 02_concurrency_with_isolates.dart - Multi-threading with Isolates
// 03_extension_methods.dart - Extending built-in types
// 04_operator_overloading.dart - Overloading operators (+, -, etc.)
// 05_reflection_and_mirrors.dart - Inspecting Dart objects dynamically
// 06_metaprogramming.dart - Code generation and annotations
// 07_custom_iterators.dart - Implementing custom iterators
// 08_patterns_and_records.dart - Using patterns and record types
// 09_advanced_generics.dart - Generics and type constraints
// 10_dart_foreign_function_interface.dart - Interfacing with C/C++ using FFI

//==========================================//

// 01_functional_programming.dart - Higher-order functions, closures, and functional constructs
void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  var doubled = numbers.map((n) => n * 2).toList();
  print(doubled); // [2, 4, 6, 8, 10]
}

//==========================================//

// 02_concurrency_with_isolates.dart - Multi-threading with Isolates
import 'dart:isolate';

void longRunningTask(SendPort sendPort) {
  int result = 0;
  for (int i = 0; i < 1000000000; i++) {
    result += i;
  }
  sendPort.send(result);
}

void main() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(longRunningTask, receivePort.sendPort);
  receivePort.listen((message) {
    print('Result: $message');
  });
}

//==========================================//

// 03_extension_methods.dart - Extending built-in types
extension StringExtensions on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

void main() {
  print('dart'.capitalize()); // Dart
}

//==========================================//

// 04_operator_overloading.dart - Overloading operators
class Vector {
  final int x, y;
  Vector(this.x, this.y);
  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);
}

void main() {
  var v1 = Vector(1, 2);
  var v2 = Vector(3, 4);
  var sum = v1 + v2;
  print('Vector: (${sum.x}, ${sum.y})');
}

//==========================================//

// 05_reflection_and_mirrors.dart - Inspecting Dart objects dynamically
import 'dart:mirrors';

void main() {
  var person = Person('John', 30);
  InstanceMirror mirror = reflect(person);
  mirror.type.declarations.forEach((key, value) {
    print('$key: $value');
  });
}

class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}

//==========================================//

// 06_metaprogramming.dart - Code generation and annotations
class MyAnnotation {
  final String message;
  const MyAnnotation(this.message);
}

@MyAnnotation('Hello, Dart!')
class MyClass {}

void main() {
  print(MyClass);
}

//==========================================//

// 07_custom_iterators.dart - Implementing custom iterators
class NumberIterable extends Iterable<int> {
  final int max;
  NumberIterable(this.max);

  @override
  Iterator<int> get iterator => _NumberIterator(max);
}

class _NumberIterator extends Iterator<int> {
  final int max;
  int _current = -1;

  _NumberIterator(this.max);

  @override
  int get current => _current;

  @override
  bool moveNext() {
    if (_current < max) {
      _current++;
      return true;
    }
    return false;
  }
}

void main() {
  for (var num in NumberIterable(5)) {
    print(num);
  }
}

//==========================================//

// 08_patterns_and_records.dart - Using patterns and record types
(int, int) swap(int a, int b) => (b, a);

void main() {
  var swapped = swap(3, 7);
  print(swapped); // (7, 3)
}

//==========================================//

// 09_advanced_generics.dart - Generics and type constraints
class Box<T extends num> {
  final T value;
  Box(this.value);
}

void main() {
  var box = Box<int>(10);
  print(box.value);
}

//==========================================//

// 10_dart_foreign_function_interface.dart - Interfacing with C/C++ using FFI
import 'dart:ffi';

typedef CAddFunc = Int32 Function(Int32, Int32);
typedef DartAddFunc = int Function(int, int);

void main() {
  final DynamicLibrary dylib = DynamicLibrary.open('libexample.so');
  final DartAddFunc add = dylib.lookupFunction<CAddFunc, DartAddFunc>('add');
  print(add(3, 5));
}
 
