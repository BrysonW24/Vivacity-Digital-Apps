import 'package:flutter/material.dart';

/// A basic settings screen with a theme toggle.
///
/// In higher tiers, this can also manage language, notifications, etc.

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false; // Simulated theme state (use provider in real setup)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SwitchListTile(
        title: const Text('Dark Mode'),
        value: isDarkMode,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
          });

          // TODO: Integrate AppProvider to toggle theme
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Dark Mode: ${value ? "Enabled" : "Disabled"}')),
          );
        },
      ),
    );
  }
}
