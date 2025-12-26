import 'package:flutter/material.dart';
import '../../services/logger_service.dart';

/// Help/FAQ Screen
class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerService.info('HelpScreen: Opened');
    return Scaffold(
      appBar: AppBar(title: const Text('Help & FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            title: const Text('How do I reset my password?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Click "Forgot Password" on login screen and follow the instructions.', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I contact support?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Email us at support@example.com', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I delete my account?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Go to Settings and select "Delete Account".', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
