import 'package:flutter/material.dart';

/// Linear progress bar without specific value.
/// Use for unknown duration processes.

class IndeterminateLinearProgress extends StatelessWidget {
  const IndeterminateLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator();
  }
}
