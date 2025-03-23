import 'package:flutter/material.dart';
import 'drawer_item.dart';

/// The left-side drawer UI (profile, settings, etc.)

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Welcome!')),
          DrawerItem(icon: Icons.person, title: 'Profile', onTap: () {}),
          DrawerItem(icon: Icons.settings, title: 'Settings', onTap: () {}),
          DrawerItem(icon: Icons.logout, title: 'Logout', onTap: () {}),
        ],
      ),
    );
  }
}
