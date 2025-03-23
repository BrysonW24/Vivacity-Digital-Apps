import 'package:flutter/material.dart';

/// Static "About" screen describing the app or company.
///
/// In base tier, this helps test routing and layout.
/// Can be extended with images, team bios, or app version.

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Vivacity Digital App is built to serve as a clean Flutter boilerplate.\n\n'
          'It is modular, scalable, and structured for production readiness from Day 1.',
        ),
      ),
    );
  }
}
