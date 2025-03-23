import 'package:flutter/material.dart';

/// Heading text used for titles, section headers, etc.

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge, // was headline6
    );
  }
}
