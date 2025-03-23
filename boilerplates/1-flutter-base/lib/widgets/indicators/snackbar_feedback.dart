import 'package:flutter/material.dart';

/// Standard snackbar alert with custom message.
/// Call from anywhere in UI using `ScaffoldMessenger`.

void showFeedbackSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
