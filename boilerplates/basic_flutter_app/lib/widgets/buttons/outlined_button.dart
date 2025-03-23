import 'package:flutter/material.dart';

class OutlinedCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? borderColor;

  const OutlinedCustomButton({
    required this.text,
    required this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
