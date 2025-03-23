import 'package:flutter/material.dart';

/// A fullscreen loading dialog to block UI while an action is happening.

Future<void> showLoadingDialog(BuildContext context, {String? message}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message ?? 'Loading...'),
          ],
        ),
      ),
    ),
  );
}
