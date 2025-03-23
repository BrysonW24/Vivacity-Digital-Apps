import 'package:flutter/material.dart';

/// Notification tile UI for `NotificationsScreen`.

class NotificationItem extends StatelessWidget {
  final String message;
  final DateTime timestamp;

  const NotificationItem({super.key, required this.message, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: Text(message),
      subtitle: Text('${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}'),
    );
  }
}
