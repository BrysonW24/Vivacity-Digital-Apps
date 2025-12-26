# UI Components

Reusable UI component templates designed for consistency, accessibility, and production use.

## Overview

This directory contains pre-built UI component templates that can be copied into your project and customized to match your design system. All components follow accessibility best practices and are optimized for performance.

## Available Components

### Buttons (`buttons.dart`)

Versatile button component with multiple variants:
- Primary, secondary, tertiary styles
- Outlined and text variants
- Loading states
- Disabled states
- Icon support
- Custom sizing

### Text Fields (`textfields.dart`)

Comprehensive text input components:
- Standard text input
- Password input with visibility toggle
- Email and numeric inputs
- Validation states
- Error messaging
- Label and hint text support
- Character counters

## Quick Start

### Copy to Your Project

```bash
# Copy all UI components
cp -r templates/ui_components/ your-project/lib/components/

# Copy specific component
cp templates/ui_components/buttons.dart your-project/lib/components/
```

### Basic Usage

```dart
import 'package:your_app/components/buttons.dart';

// Use in your widget
CustomButton(
  label: 'Submit',
  onPressed: () => handleSubmit(),
  variant: ButtonVariant.primary,
)
```

## Component Details

### Button Component

#### Features
- Multiple style variants
- Loading and disabled states
- Icon positioning (left, right, icon-only)
- Accessible by default
- Responsive sizing
- Customizable colors and typography

#### Usage Examples

**Primary Button:**
```dart
CustomButton(
  label: 'Create Account',
  onPressed: () => createAccount(),
  variant: ButtonVariant.primary,
)
```

**Button with Icon:**
```dart
CustomButton(
  label: 'Save',
  icon: Icons.save,
  iconPosition: IconPosition.left,
  onPressed: () => save(),
)
```

**Loading State:**
```dart
CustomButton(
  label: 'Processing',
  isLoading: true,
  onPressed: () {}, // Disabled during loading
)
```

**Outlined Button:**
```dart
CustomButton(
  label: 'Cancel',
  variant: ButtonVariant.outlined,
  onPressed: () => cancel(),
)
```

#### Customization

```dart
CustomButton(
  label: 'Custom',
  onPressed: () {},
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  borderRadius: 8.0,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
)
```

### Text Field Component

#### Features
- Multiple input types (text, email, password, number)
- Built-in validation
- Error state handling
- Label and hint text
- Character counter
- Clear button
- Password visibility toggle
- Accessible labels

#### Usage Examples

**Basic Text Input:**
```dart
CustomTextField(
  label: 'Full Name',
  hintText: 'Enter your name',
  onChanged: (value) => updateName(value),
)
```

**Email Input with Validation:**
```dart
CustomTextField(
  label: 'Email',
  inputType: TextInputType.email,
  validator: (value) {
    if (!value.contains('@')) return 'Invalid email';
    return null;
  },
  onChanged: (value) => updateEmail(value),
)
```

**Password Field:**
```dart
CustomTextField(
  label: 'Password',
  isPassword: true,
  showPasswordToggle: true,
  validator: (value) {
    if (value.length < 8) return 'Password too short';
    return null;
  },
)
```

**With Character Counter:**
```dart
CustomTextField(
  label: 'Bio',
  maxLength: 200,
  showCounter: true,
  maxLines: 4,
)
```

#### Customization

```dart
CustomTextField(
  label: 'Custom Field',
  borderColor: Colors.blue,
  focusedBorderColor: Colors.blueAccent,
  errorColor: Colors.red,
  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
)
```

## Design System Integration

### Theming

Create a theme configuration for consistent styling:

```dart
// lib/theme/component_theme.dart
class ComponentTheme {
  // Button theme
  static const ButtonColors primaryButton = ButtonColors(
    background: Color(0xFF1976D2),
    foreground: Colors.white,
    border: Color(0xFF1976D2),
  );

  static const ButtonColors secondaryButton = ButtonColors(
    background: Colors.white,
    foreground: Color(0xFF1976D2),
    border: Color(0xFF1976D2),
  );

  // Text field theme
  static const TextFieldColors textFieldColors = TextFieldColors(
    border: Color(0xFFE0E0E0),
    focusedBorder: Color(0xFF1976D2),
    errorBorder: Color(0xFFD32F2F),
    labelColor: Color(0xFF616161),
  );
}
```

### Using Theme

```dart
CustomButton(
  label: 'Themed Button',
  onPressed: () {},
  colors: ComponentTheme.primaryButton,
)
```

## Accessibility

All components follow WCAG 2.1 Level AA guidelines:

### Semantic Labels
```dart
CustomButton(
  label: 'Submit',
  semanticLabel: 'Submit form and continue',
  onPressed: () => submit(),
)
```

### Keyboard Navigation
- Tab through interactive elements
- Enter/Space to activate buttons
- Escape to clear text fields

### Screen Reader Support
- Descriptive labels
- Error announcements
- State changes announced

### Color Contrast
- Minimum 4.5:1 for normal text
- Minimum 3:1 for large text
- Focus indicators visible

## Responsive Design

Components adapt to different screen sizes:

```dart
CustomButton(
  label: 'Responsive',
  onPressed: () {},
  responsive: true, // Adjusts based on screen width
)

CustomTextField(
  label: 'Responsive Input',
  responsive: true, // Full width on mobile, constrained on desktop
)
```

## Component Composition

Build complex components from basic ones:

```dart
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Email',
          inputType: TextInputType.email,
          icon: Icons.email,
        ),
        SizedBox(height: 16),
        CustomTextField(
          label: 'Password',
          isPassword: true,
          icon: Icons.lock,
        ),
        SizedBox(height: 24),
        CustomButton(
          label: 'Log In',
          variant: ButtonVariant.primary,
          onPressed: () => handleLogin(),
        ),
      ],
    );
  }
}
```

## Testing Components

### Widget Tests

```dart
testWidgets('Button should trigger callback on tap', (tester) async {
  bool pressed = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CustomButton(
          label: 'Test',
          onPressed: () => pressed = true,
        ),
      ),
    ),
  );

  await tester.tap(find.text('Test'));
  await tester.pump();

  expect(pressed, true);
});
```

### Accessibility Tests

```dart
testWidgets('Button should have semantic label', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CustomButton(
          label: 'Submit',
          semanticLabel: 'Submit the form',
          onPressed: () {},
        ),
      ),
    ),
  );

  expect(
    tester.getSemantics(find.text('Submit')),
    matchesSemantics(label: 'Submit the form'),
  );
});
```

## Best Practices

### Component Design
- Single responsibility per component
- Composition over inheritance
- Customizable via props/parameters
- Sensible default values
- Clear prop names

### Performance
- Use `const` constructors where possible
- Avoid rebuilding unnecessarily
- Optimize image assets
- Lazy load when appropriate

### Maintenance
- Document props and usage
- Version control breaking changes
- Maintain backward compatibility
- Regular accessibility audits

## Customization Examples

### Brand Colors

```dart
class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BrandButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      backgroundColor: BrandColors.primary,
      textColor: Colors.white,
      borderRadius: 12.0,
    );
  }
}
```

### Custom Validation

```dart
class EmailTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const EmailTextField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Email Address',
      inputType: TextInputType.email,
      validator: EmailValidator.validate,
      onChanged: onChanged,
      icon: Icons.email_outlined,
    );
  }
}
```

## Platform-Specific Styling

### Material Design (Android)
```dart
CustomButton(
  label: 'Material Button',
  elevation: 2.0,
  borderRadius: 4.0,
)
```

### Cupertino (iOS)
```dart
CustomButton(
  label: 'iOS Button',
  borderRadius: 8.0,
  useCupertinoStyle: true,
)
```

## Resources

### Design Systems
- [Material Design 3](https://m3.material.io/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/)
- [Web Content Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

### Component Libraries
- Flutter Material Components
- Flutter Cupertino Widgets
- React Material-UI
- Ant Design

## Support

For questions or customization help:
1. Review component inline documentation
2. Check usage examples above
3. Consult design system documentation
4. Contact Vivacity Digital team

---

**Vivacity Digital** - Production-Ready UI Components
