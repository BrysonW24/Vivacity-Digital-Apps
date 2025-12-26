import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// Notifications Screen
///
/// Displays list of notifications with ability to mark as read and delete.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    LoggerService.info('NotificationsScreen: Initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              LoggerService.info('NotificationsScreen: Clear all');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'No notifications',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
