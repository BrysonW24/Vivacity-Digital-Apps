 // Intermediate Dart & Flutter Repository - Structured for Deeper Understanding
// This repository contains intermediate-level Dart, Flutter, and Flutter app development concepts.

// Each file will be a separate module covering a key intermediate topic.

// Intermediate Dart
// 01_generics.dart - Understanding generics (List<T>, Map<K, V>)
// 02_extension_methods.dart - Extending built-in types
// 03_higher_order_functions.dart - Functions as first-class objects
// 04_custom_exceptions.dart - Creating and handling custom exceptions
// 05_isolates_and_concurrency.dart - Parallel execution with isolates
// 06_reflection_and_mirrors.dart - Inspecting Dart objects dynamically
// 07_operator_overloading.dart - Overloading operators (+, -, etc.)
// 08_data_classes.dart - Using record and data class patterns

// Intermediate Dart Concepts - One File Covering Key Topics

// 01_generics.dart - Understanding generics (List<T>, Map<K, V>)
class Box<T> {
  T value;
  Box(this.value);
}

void testGenerics() {
  var intBox = Box<int>(42);
  var stringBox = Box<String>('Hello');
}

// 02_extension_methods.dart - Extending built-in types
extension StringExtensions on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

void testExtensions() {
  print("hello".capitalize());
}

// 03_higher_order_functions.dart - Functions as first-class objects
void runFunction(Function fn) => fn();

int multiplyByTwo(int x) => x * 2;

void testHigherOrderFunctions() {
  runFunction(() => print(multiplyByTwo(5)));
}

// 04_custom_exceptions.dart - Creating and handling custom exceptions
class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

void testCustomExceptions() {
  try {
    throw CustomException('Something went wrong!');
  } catch (e) {
    print('Caught exception: $e');
  }
}

// 05_isolates_and_concurrency.dart - Parallel execution with isolates
import 'dart:isolate';

void heavyTask(SendPort sendPort) {
  sendPort.send('Task Complete!');
}

void testIsolates() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(heavyTask, receivePort.sendPort);
  receivePort.listen((message) => print(message));
}

// 06_reflection_and_mirrors.dart - Inspecting Dart objects dynamically
import 'dart:mirrors';

void testReflection() {
  var instance = Box(10);
  var mirror = reflect(instance);
  print(mirror.type.reflectedType);
}

// 07_operator_overloading.dart - Overloading operators (+, -, etc.)
class Vector {
  final int x, y;
  Vector(this.x, this.y);

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);
}

void testOperatorOverloading() {
  var v1 = Vector(2, 3);
  var v2 = Vector(4, 5);
  var result = v1 + v2;
}

// 08_data_classes.dart - Using record and data class patterns
record Person(String name, int age);

void testDataClasses() {
  var p = Person('John', 30);
  print('${p.$1} is ${p.$2} years old');
}

// Main function to run all tests
void main() {
  testGenerics();
  testExtensions();
  testHigherOrderFunctions();
  testCustomExceptions();
  testIsolates();
  testReflection();
  testOperatorOverloading();
  testDataClasses();
}
