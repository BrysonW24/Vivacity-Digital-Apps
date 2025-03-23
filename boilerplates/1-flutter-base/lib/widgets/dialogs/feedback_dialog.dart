import 'package:flutter/material.dart';

/// Dialog to collect user feedback (short form).
///
/// Returns the submitted text if confirmed.

Future<void> showFeedbackDialog({
  required BuildContext context,
  required Function(String feedback) onSubmit,
}) {
  final TextEditingController controller = TextEditingController();

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('We value your feedback'),
      content: TextField(
        controller: controller,
        maxLines: 4,
        decoration: const InputDecoration(
          hintText: 'Enter your thoughts here...',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            Navigator.pop(context);
            onSubmit(controller.text);
          },
        ),
      ],
    ),
  );
}
