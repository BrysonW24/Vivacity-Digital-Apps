import 'package:flutter/material.dart';

/// Simple dialog that lets user choose between camera or gallery upload.
/// Returns the selected source as a string: 'camera' or 'gallery'

Future<void> showImagePickerDialog({
  required BuildContext context,
  required Function(String source) onSelected,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Choose Image Source'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              onSelected('camera');
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              onSelected('gallery');
            },
          ),
        ],
      ),
    ),
  );
}
