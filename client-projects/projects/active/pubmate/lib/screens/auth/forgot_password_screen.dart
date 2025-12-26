import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_sizes.dart';
import '../../enums/loading_status.dart';
import '../../providers/auth_provider.dart';
import '../../services/logger_service.dart';

/// Forgot Password Screen
///
/// Allows users to request a password reset by entering their email address.
/// Triggers sending a reset link to their registered email.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    LoggerService.info('ForgotPasswordScreen: Initialized');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleRequestReset() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      LoggerService.info('ForgotPasswordScreen: Requesting password reset');
      final authProvider = context.read<AuthProvider>();

      await authProvider.forgotPassword(
        email: _emailController.text.trim(),
      );

      if (mounted) {
        setState(() => _emailSent = true);
        LoggerService.info('ForgotPasswordScreen: Reset email sent');
      }
    } catch (e) {
      if (mounted) {
        LoggerService.error('ForgotPasswordScreen: Reset request failed', error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.spacing24),
              child: _emailSent
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSizes.spacing32),
                  Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green[400],
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  Text(
                    'Check Your Email',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  Text(
                    'We\'ve sent password reset instructions to ${_emailController.text}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spacing32),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to Login'),
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  TextButton(
                    onPressed: () {
                      setState(() => _emailSent = false);
                      _emailController.clear();
                    },
                    child: const Text('Try Another Email'),
                  ),
                ],
              )
                  : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing8),
                    Text(
                      'Enter your email address and we\'ll send you a link to reset your password',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing32),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                    const SizedBox(height: AppSizes.spacing32),

                    // Send button
                    ElevatedButton(
                      onPressed: authProvider.loadingStatus == LoadingStatus.loading
                          ? null
                          : _handleRequestReset,
                      child: authProvider.loadingStatus == LoadingStatus.loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Send Reset Link'),
                    ),
                    const SizedBox(height: AppSizes.spacing24),

                    // Back to login
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back to Login'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
