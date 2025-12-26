// Flutter Basics Repository - Structured for App & Web App Development
// This repository contains fundamental Flutter concepts for UI development.

// Each file will be a separate module covering a key Flutter topic.

//==========================================//

// Flutter Basics - Table of Contents
// 11_flutter_setup.md - Instructions to install Flutter and set up the environment
// 12_hello_flutter.dart - Creating a simple Flutter app (main.dart, runApp())
// 13_stateless_widget.dart - Basics of StatelessWidget and UI components
// 14_stateful_widget.dart - Handling state using StatefulWidget
// 15_layouts_and_widgets.dart - Row, Column, Stack, Container, ListView
// 16_navigation.dart - Navigation between screens using Navigator
// 17_forms_and_inputs.dart - Handling user inputs, TextField, Form validation
// 18_buttons_and_interactions.dart - Buttons, gestures, and interactions
// 19_theming_and_styling.dart - Themes, colors, fonts, ThemeData
// 20_images_and_icons.dart - Displaying local/network images and icons

//==========================================//

// 11_flutter_setup.md - Instructions to install Flutter and set up the environment
// 12_hello_flutter.dart - Creating a simple Flutter app (main.dart, runApp())
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello Flutter!')),
        body: const Center(child: Text('Welcome to Flutter!')),
      ),
    );
  }
}

// 13_stateless_widget.dart - Basics of StatelessWidget and UI components
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('I am a stateless widget!'),
    );
  }
}

// 14_stateful_widget.dart - Handling state using StatefulWidget
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter: \$counter'),
        ElevatedButton(onPressed: _incrementCounter, child: const Text('Increment')),
      ],
    );
  }
}

// 15_layouts_and_widgets.dart - Row, Column, Stack, Container, ListView
class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [Text('Row Item 1'), Text('Row Item 2')],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.blueAccent,
          child: const Text('Container Example'),
        ),
      ],
    );
  }
}

// 16_navigation.dart - Navigation between screens using Navigator
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}

// 17_forms_and_inputs.dart - Handling user inputs, TextField, Form validation
class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Enter text'),
        ),
        ElevatedButton(
          onPressed: () {
            print('User entered: \${_controller.text}');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// 18_buttons_and_interactions.dart - Buttons, gestures, and interactions
class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => print('Button Pressed!'),
      child: const Text('Click Me'),
    );
  }
}

// 19_theming_and_styling.dart - Themes, colors, fonts, ThemeData
class ThemedApp extends StatelessWidget {
  const ThemedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 20)),
      ),
      home: const ThemedScreen(),
    );
  }
}

class ThemedScreen extends StatelessWidget {
  const ThemedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Themed App')),
      body: const Center(child: Text('Styled Text')),
    );
  }
}

// 20_images_and_icons.dart - Displaying local/network images and icons
class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network('https://via.placeholder.com/150'),
        const Icon(Icons.star, size: 50, color: Colors.orange),
      ],
    );
  }
}

// Main function to test components
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Basics')), 
        body: const Center(child: Text('Welcome to Flutter!')),
      ),
    );
  }
}

