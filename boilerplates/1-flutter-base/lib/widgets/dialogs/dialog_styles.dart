import 'package:flutter/material.dart';

/// Centralizes styling for all app dialogs — padding, radius, etc.
/// Keeps consistency across all modal UIs.

class DialogStyles {
  static RoundedRectangleBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  static const EdgeInsets contentPadding = EdgeInsets.all(20);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
