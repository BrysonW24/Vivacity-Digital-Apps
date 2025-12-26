import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// Contact Us Screen
///
/// Provides multiple ways for users to contact support.
/// Includes contact form, email, phone, and social media links.
class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    LoggerService.info('ContactScreen: Initialized');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      LoggerService.info('ContactScreen: Submitting message');
      // TODO: Submit contact form to backend
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully')),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        LoggerService.error('ContactScreen: Submit failed', error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacing8),
            Text(
              'Have a question? We\'d love to hear from you.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: AppSizes.spacing32),

            // Contact methods
            Text(
              'Contact Methods',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacing16),

            // Email
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('support@example.com'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                LoggerService.info('ContactScreen: Opening email');
                // TODO: Open email client
              },
            ),

            // Phone
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+1 (555) 123-4567'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                LoggerService.info('ContactScreen: Opening phone');
                // TODO: Open phone dialer
              },
            ),

            // Website
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Website'),
              subtitle: const Text('www.example.com'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                LoggerService.info('ContactScreen: Opening website');
                // TODO: Open website
              },
            ),

            const SizedBox(height: AppSizes.spacing32),

            // Contact Form
            Text(
              'Send us a Message',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacing16),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Name field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing16),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value!)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing16),

                  // Message field
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.message),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Message is required';
                      }
                      if (value!.length < 10) {
                        return 'Message must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing24),

                  // Submit button
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Send Message'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacing32),

            // Business hours
            Container(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Hours',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Text(
                    'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday - Sunday: Closed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
