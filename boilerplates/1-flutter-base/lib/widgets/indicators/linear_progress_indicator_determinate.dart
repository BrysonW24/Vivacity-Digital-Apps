import 'package:flutter/material.dart';

/// Linear progress bar with a defined completion percentage.

class DeterminateLinearProgress extends StatelessWidget {
  final double value;

  const DeterminateLinearProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: Colors.grey.shade300,
      color: Theme.of(context).primaryColor,
    );
  }
}
