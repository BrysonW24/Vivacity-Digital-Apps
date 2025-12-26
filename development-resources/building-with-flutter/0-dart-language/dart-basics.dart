// Introduction to Dart
// Author: Bryson Walter
// Date: 11-03-2025

/// This page provides a brief introduction to the Dart language through samples of its main features.
/// To learn more about the Dart language, visit the in-depth, individual topic pages listed under Language in the left side menu.
/// For coverage of Dart's core libraries, check out the core library documentation. You can also check out the Dart cheatsheet, for a more interactive introduction.

// 01_hello_world.dart - Basic Dart syntax and structure
// 02_variables_and_data_types.dart - Variables, constants (final, const), and type inference
// 03_control_flow.dart - If-else statements, loops (for, while, do-while), and switch-case
// 04_imports.dart - Importing core and external libraries
// 05_classes_and_objects.dart - Object-oriented programming in Dart, constructors, and methods
// 06_enums_and_mixins.dart - Enums, mixins, and their applications
// 07_inheritance.dart - Extending classes and creating subclass relationships
// 08_interfaces_and_abstract_classes.dart - Abstract classes and interfaces in Dart
// 09_asynchronous_programming.dart - async, await, Future, and Stream
// 10_exception_handling.dart - Error handling with try-catch, throw, and finally
// 11_important_dart_concepts.dart - Key features of Dart's type system and null safety

//==========================================//

// This is a normal, one-line comment.

/// This is a documentation comment, used to document libraries,
/// classes, and their members. Tools like IDEs and dartdoc treat
/// doc comments specially.

/* Comments like these are also supported. */

//==========================================//

//======== Hello World ========
void main() {
  print('Hello, World!');
}

//======== Variables ========
var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7;
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
  'tags': ['saturn'],
  'url': '//path/to/saturn.jpg',
};
// Read more about variables in Dart, including:
//   default values, the final and const keywords, and static types.


//======== Control Flow Statements ========
if (year >= 2001) {
  print('21st century');
} else if (year >= 1901) {
  print('20th century');
}

for (final object in flybyObjects) {
  print(object);
}

for (int month = 1; month <= 12; month++) {
  print(month);
}

while (year < 2016) {
  year += 1;
}

// Read more about control flow statements in Dart, including:
//    break and continue, switch and case, and assert.

//======== Imports ========
import 'dart:math';
import 'package:test/test.dart';


//======== Classes ========
class Spacecraft {
  String name;
  DateTime? launchDate;

  int? get launchYear => launchDate?.year;

  Spacecraft(this.name, this.launchDate);
  Spacecraft.unlaunched(String name) : this(name, null);

  void describe() {
    print('Spacecraft: $name');
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//======== Enums ========
enum PlanetType { terrestrial, gas, ice }

enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  earth(planetType: PlanetType.terrestrial, moons: 1, hasRings: false);

  const Planet({required this.planetType, required this.moons, required this.hasRings});
  final PlanetType planetType;
  final int moons;
  final bool hasRings;
  bool get isGiant => planetType == PlanetType.gas || planetType == PlanetType.ice;
}

//======== Inheritance ========
class Orbiter extends Spacecraft {
  double altitude;
  Orbiter(super.name, super.launchDate, this.altitude);
}

//======== Mixins ========
mixin Piloted {
  int astronauts = 1;
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {}

//======== Interfaces and Abstract Classes ========
abstract class Describable {
  void describe();
  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

//======== Async and Await ========
const oneSecond = Duration(seconds: 1);
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

//======== Stream Example ========
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

//======== Exception Handling ========
Future<void> describeFlybyObjects(List<String> flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}

//======== Important Dart Concepts ========
void dartConcepts() {
  Object? nullableObject;
  nullableObject = 'This is an object';
  print(nullableObject);
}

//======== Main function ========
void main() {
  print('Dart 3.7 Overview');
  controlFlowExamples();
  print(fibonacci(10));
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();
  dartConcepts();
}

