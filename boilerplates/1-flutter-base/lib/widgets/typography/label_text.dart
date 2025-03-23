import 'package:flutter/material.dart';

/// Small label or caption text — good for footnotes, meta data, etc.

class LabelText extends StatelessWidget {
  final String text;

  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall, // was caption
    );
  }
}
