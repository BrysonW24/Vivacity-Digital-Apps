import 'package:flutter/material.dart';

/// A reusable app bar with optional actions.

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required String title})
      : super(
          title: Text(title),
          elevation: 2,
        );
}
