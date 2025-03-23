import 'package:flutter/material.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/text_button.dart';
import '../../../widgets/buttons/icon_button.dart';
import '../../../widgets/buttons/outlined_button.dart';
import '../../../widgets/buttons/floating_action_button.dart';
import '../../../widgets/buttons/social_media_button.dart';

class ButtonShowcase extends StatelessWidget {
  const ButtonShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Primary Button:'),
        const SizedBox(height: 8),
        PrimaryButton(label: 'Primary', onPressed: () {}),
        const SizedBox(height: 16),

        const Text('Text Button:'),
        const SizedBox(height: 8),
        CustomTextButton(text: 'Text', onPressed: () {}),
        const SizedBox(height: 16),

        const Text('Icon Button:'),
        const SizedBox(height: 8),
        CustomIconButton(icon: Icons.thumb_up, onPressed: () {}),
        const SizedBox(height: 16),

        const Text('Outlined Button:'),
        const SizedBox(height: 8),
        CustomOutlinedButton(text: 'Outlined', onPressed: () {}),
        const SizedBox(height: 16),

        const Text('Floating Action Button:'),
        const SizedBox(height: 8),
        CustomFAB(icon: Icons.add, onPressed: () {}),
        const SizedBox(height: 16),

        const Text('Social Media Buttons:'),
        const SizedBox(height: 8),
        Row(
          children: [
            SocialMediaButton(
              text: 'Facebook',
              iconPath: 'assets/icons/facebook.png',
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            SocialMediaButton(
              text: 'Google',
              iconPath: 'assets/icons/google.png',
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            SocialMediaButton(
              text: 'Apple',
              iconPath: 'assets/icons/apple.png',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}