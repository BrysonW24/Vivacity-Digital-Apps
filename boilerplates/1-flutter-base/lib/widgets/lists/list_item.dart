import 'package:flutter/material.dart';

/// A generic tappable list item for reuse.

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}
