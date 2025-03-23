import 'package:flutter/material.dart';

/// A simple confirmation dialog used to prompt users before proceeding.
///
/// You can call this from anywhere:
/// `await showConfirmationDialog(context, "Delete item?", onConfirm: () {});`

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String message,
  VoidCallback? onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.pop(context);
            if (onConfirm != null) onConfirm();
          },
        ),
      ],
    ),
  );
}
