import 'package:flutter/material.dart';

/// Tap-to-expand list section (used in FAQ, menus, etc.)

class ExpandableList extends StatefulWidget {
  final String title;
  final List<String> items;

  const ExpandableList({super.key, required this.title, required this.items});

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      initiallyExpanded: _expanded,
      onExpansionChanged: (val) => setState(() => _expanded = val),
      children: widget.items.map((e) => ListTile(title: Text(e))).toList(),
    );
  }
}
