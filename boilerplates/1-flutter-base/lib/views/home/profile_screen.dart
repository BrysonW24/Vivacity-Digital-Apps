import 'package:flutter/material.dart';

/// A minimal user profile screen.
///
/// In base tier, this is static. In higher tiers,
/// it can fetch and show user data after authentication.

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 16),
            Text('Name: Jane Doe'),
            Text('Email: jane@example.com'),
            SizedBox(height: 16),
            Text('Account created: Jan 2024'),
          ],
        ),
      ),
    );
  }
}
