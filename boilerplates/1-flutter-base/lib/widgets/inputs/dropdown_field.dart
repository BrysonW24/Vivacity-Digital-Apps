import 'package:flutter/material.dart';

/// Reusable dropdown with a list of options.

class DropdownField extends StatelessWidget {
  final String label;
  final String? selected;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
