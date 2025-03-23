import 'package:flutter/material.dart';

// List components
import '../../../widgets/lists/expandable_list.dart';
import '../../../widgets/lists/list_item.dart';
import '../../../widgets/lists/notification_item.dart';

class ListsShowcase extends StatelessWidget {
  const ListsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📋 Basic List Items:'),
        const SizedBox(height: 8),
        const ListItem(title: 'Item 1', subtitle: 'Subtitle A'),
        const ListItem(title: 'Item 2', subtitle: 'Subtitle B'),
        const SizedBox(height: 16),

        const Text('🔔 Notification Items:'),
        const SizedBox(height: 8),
        NotificationItem(
          message: 'New Message',
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
        NotificationItem(
          message: 'App Update',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        const SizedBox(height: 16),

        const Text('📂 Expandable List:'),
        const SizedBox(height: 8),
        const ExpandableList(
          title: 'More Options',
          items: ['Option 1', 'Option 2', 'Option 3'],
        ),
      ],
    );
  }
}
