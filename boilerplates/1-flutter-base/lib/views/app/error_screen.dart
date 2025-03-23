import 'package:flutter/material.dart';

/// A fallback screen displayed when an unexpected error occurs.
///
/// Can be expanded to include diagnostics or navigation to safe areas.
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Oops! Something went wrong.'),
      ),
    );
  }
}
