import 'package:flutter/material.dart';

/// A placeholder screen for user notifications.
///
/// In future tiers, this will show push or in-app notifications.
/// Here, it demonstrates simple list rendering with dummy content.

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> mockNotifications = [
      '🎉 Welcome to the app!',
      '📦 Your order has shipped.',
      '✅ Profile setup complete.',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: mockNotifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(mockNotifications[index]),
          );
        },
      ),
    );
  }
}
