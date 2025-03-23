import 'package:flutter/material.dart';
import '../../../widgets/navigation/app_bar.dart';
import '../../../widgets/navigation/bottom_nav.dart';
import '../../../widgets/navigation/drawer_item.dart';
import '../../../widgets/navigation/side_drawer.dart';

class NavigationShowcase extends StatelessWidget {
  const NavigationShowcase({super.key});

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(), // assuming this exists
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🧭 Custom App Bar:'),
              const SizedBox(height: 8),
              CustomAppBar(title: 'Demo App Bar'),
              const SizedBox(height: 16),

              const Text('🪟 Drawer Trigger:'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _openDrawer(context),
                child: const Text('Open Side Drawer'),
              ),
              const SizedBox(height: 16),

              const Text('Drawer Item:'),
              SizedBox(height: 8),
              DrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // Example interaction
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings tapped')),
                  );
                },
              ),
              SizedBox(height: 16),

              const Text('📱 Bottom Navigation:'),
              const SizedBox(height: 8),
              CustomBottomNavBar(
                currentIndex: 0,
                onTap: (index) {
                  // Handle bottom nav change
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
