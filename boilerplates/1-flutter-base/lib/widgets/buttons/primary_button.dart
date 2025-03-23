import 'package:flutter/material.dart';

/// A simple reusable elevated button with consistent styling.
/// You can customize color, size, shape, or elevation here.

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isDisabled;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Theme.of(context).primaryColor,
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }
}
