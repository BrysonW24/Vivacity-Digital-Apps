import 'package:flutter/material.dart';

/// Body text used for paragraphs and general content.

class BodyText extends StatelessWidget {
  final String text;

  const BodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium, // was bodyText1
    );
  }
}
