import 'package:flutter/material.dart';

/// Standard circular loading spinner with optional size control.

class AppCircularLoader extends StatelessWidget {
  final double size;

  const AppCircularLoader({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}
