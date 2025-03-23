import 'package:flutter/material.dart';

// Dialog functions (these return Future<void>, not widgets)
import '../../../widgets/dialogs/confirmation_dialog.dart';
import '../../../widgets/dialogs/loading_dialog.dart';
import '../../../widgets/dialogs/feedback_dialog.dart';
import '../../../widgets/dialogs/image_picker_dialog.dart';
import '../../../widgets/dialogs/rating_dialog.dart';

class DialogShowcase extends StatelessWidget {
  const DialogShowcase({super.key});

  // Show Confirmation Dialog
  void _showConfirmationDialog(BuildContext context) {
    showConfirmationDialog(
      context: context,
      message: 'This action cannot be undone.',
      onConfirm: () => Navigator.pop(context),
    );
  }

  // Show Loading Dialog
  void _showLoadingDialog(BuildContext context) {
    showLoadingDialog(context, message: 'Please wait...');
    Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
  }

  // Show Feedback Dialog
  void _showFeedbackDialog(BuildContext context) {
    showFeedbackDialog(
      context: context,
      onSubmit: (feedback) {
        // handle feedback here if needed
        debugPrint('Feedback submitted: $feedback');
      },
    );
  }

  // Show Image Picker Dialog
  void _showImagePickerDialog(BuildContext context) {
    showImagePickerDialog(
      context: context,
      onSelected: (source) {
        debugPrint('Image source selected: $source');
      },
    );
  }

  // Show Rating Dialog
  void _showRatingDialog(BuildContext context) {
    showRatingDialog(
      context: context,
      onSubmit: (rating) {
        debugPrint('Rating selected: $rating');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _showConfirmationDialog(context),
          child: const Text('Show Confirmation Dialog'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showLoadingDialog(context),
          child: const Text('Show Loading Dialog'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showFeedbackDialog(context),
          child: const Text('Show Feedback Dialog'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showImagePickerDialog(context),
          child: const Text('Show Image Picker Dialog'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showRatingDialog(context),
          child: const Text('Show Rating Dialog'),
        ),
      ],
    );
  }
}
