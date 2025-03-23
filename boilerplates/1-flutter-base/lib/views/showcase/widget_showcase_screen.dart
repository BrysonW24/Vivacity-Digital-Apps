import 'package:flutter/material.dart';

// Import individual showcase sections
import 'widgets/button_showcase.dart';
import 'widgets/dialog_showcase.dart';
import 'widgets/input_showcase.dart';
import 'widgets/indicators_showcase.dart';
import 'widgets/lists_showcase.dart';
import 'widgets/navigation_showcase.dart';
import 'widgets/typography_showcase.dart';

class WidgetShowcaseScreen extends StatelessWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧱 Widget Showcase'),
        // Optional: Add theme toggle or refresh button later
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SectionTitle('Buttons'),
          ButtonShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Inputs'),
          InputShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Indicators'),
          IndicatorsShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Dialogs'),
          DialogShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Lists'),
          ListsShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Navigation'),
          NavigationShowcase(),
          Divider(height: 32, thickness: 1),

          SectionTitle('Typography'),
          TypographyShowcase(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
      ),
    );
  }
}
