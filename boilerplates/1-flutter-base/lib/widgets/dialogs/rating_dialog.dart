import 'package:flutter/material.dart';

/// Dialog to collect a rating from 1 to 5 stars.
///
/// Returns the selected rating as an int via callback.

Future<void> showRatingDialog({
  required BuildContext context,
  required Function(int rating) onSubmit,
}) {
  int selectedRating = 3;

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Rate this app'),
      content: StatefulBuilder(
        builder: (context, setState) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                Icons.star,
                color: index < selectedRating ? Colors.amber : Colors.grey,
              ),
              onPressed: () => setState(() => selectedRating = index + 1),
            );
          }),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Later'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            Navigator.pop(context);
            onSubmit(selectedRating);
          },
        ),
      ],
    ),
  );
}
