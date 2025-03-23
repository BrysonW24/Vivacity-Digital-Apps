import 'package:flutter/material.dart';

/// Floating toast-style message.
/// Typically used for lightweight feedback (copy, saved, etc.).

void showToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(message, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
}
