import 'package:flutter/material.dart';
import '../../../widgets/typography/body_text.dart';
import '../../../widgets/typography/heading_text.dart';
import '../../../widgets/typography/label_text.dart';
import '../../../widgets/typography/text_styles.dart';

class TypographyShowcase extends StatelessWidget {
  const TypographyShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Headings:'),
        const SizedBox(height: 8),
        const HeadingText('Heading Large'),
        const HeadingText('Heading Medium'),
        const SizedBox(height: 16),

        const Text('Body Text:'),
        const SizedBox(height: 8),
        const BodyText('This is standard body text for paragraphs and descriptions.'),
        const SizedBox(height: 16),

        const Text('Label Text:'),
        const SizedBox(height: 8),
        const LabelText('Label or form field heading'),
        const SizedBox(height: 16),

        const Text('Custom Style Preview:'),
        const SizedBox(height: 8),
        const Text(
          'Styled with app TextTheme headlineSmall',
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Styled with app TextTheme bodyMedium',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}