import 'package:flutter/material.dart';

/// A simple contact screen that shows a form or contact info.
///
/// Later this can send messages via Firebase, EmailJS, or APIs.

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Need help? Reach out to us below:'),
            SizedBox(height: 16),
            Text('📧 support@vivacitydigital.app'),
            Text('🌐 www.vivacitydigital.app'),
          ],
        ),
      ),
    );
  }
}
