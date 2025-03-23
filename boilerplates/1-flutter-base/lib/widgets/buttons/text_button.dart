import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;

  const CustomTextButton({
    required this.text,
    required this.onPressed,
    this.textColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: textColor ?? Colors.blue)),
    );
  }
}
