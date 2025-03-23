import 'package:flutter/material.dart';

/// A top-pinned persistent banner used for showing network issues,
/// feature deprecation notices, or global errors.

class BannerPersistentAlert extends StatelessWidget {
  final String message;
  final Color color;

  const BannerPersistentAlert({
    super.key,
    required this.message,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      backgroundColor: color,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      actions: const [SizedBox()], // You can add dismiss later if needed
    );
  }
}
