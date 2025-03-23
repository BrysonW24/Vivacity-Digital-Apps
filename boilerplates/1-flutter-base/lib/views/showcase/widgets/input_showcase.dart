import 'package:flutter/material.dart';

import '../../../widgets/inputs/custom_text_field.dart';
import '../../../widgets/inputs/dropdown_field.dart';
import '../../../widgets/inputs/password_field.dart';
import '../../../widgets/inputs/input_validators.dart';

class InputShowcase extends StatefulWidget {
  const InputShowcase({super.key});

  @override
  State<InputShowcase> createState() => _InputShowcaseState();
}

class _InputShowcaseState extends State<InputShowcase> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedOption = 'Option 1';
  final List<String> _dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Custom TextField:'),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: 'Enter your email',
            controller: _textController,
            validator: InputValidators.email,
          ),
          const SizedBox(height: 16),

          const Text('Password Field:'),
          const SizedBox(height: 8),
          PasswordField(
            controller: _passwordController,
            validator: InputValidators.password,
          ),
          const SizedBox(height: 16),

          const Text('Dropdown Field:'),
          const SizedBox(height: 8),
          DropdownField(
            label: 'Select an option',
            selected: _selectedOption,
            items: _dropdownOptions,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  _selectedOption = value;
                });
              }
            },
          ),
          const SizedBox(height: 24),

          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is valid!')),
                  );
                }
              },
              child: const Text('Validate Form'),
            ),
          ),
        ],
      ),
    );
  }
}