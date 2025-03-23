import 'package:flutter/material.dart';

/// A static FAQ page with common questions and answers.

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Q: What is this app?', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('A: A base Flutter boilerplate to start any new project.'),
          SizedBox(height: 16),
          Text('Q: Can I use it for production?'),
          Text('A: Yes, just add auth, backend, and polish.'),
        ],
      ),
    );
  }
}
