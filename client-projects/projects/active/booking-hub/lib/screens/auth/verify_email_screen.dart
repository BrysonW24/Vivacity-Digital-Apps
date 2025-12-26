import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_sizes.dart';
import '../../enums/loading_status.dart';
import '../../providers/auth_provider.dart';
import '../../services/logger_service.dart';

/// Verify Email Screen
///
/// Prompts user to verify their email address by entering a code sent to their email.
/// Includes resend code functionality and countdown timer.
class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late TextEditingController _codeController;
  final _formKey = GlobalKey<FormState>();
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initInit();
    _codeController = TextEditingController();
    LoggerService.info('VerifyEmailScreen: Initialized for ${widget.email}');
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyEmail() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      LoggerService.info('VerifyEmailScreen: Verifying email');
      final authProvider = context.read<AuthProvider>();

      await authProvider.verifyEmail(
        email: widget.email,
        code: _codeController.text.trim(),
      );

      if (mounted) {
        LoggerService.info('VerifyEmailScreen: Email verified successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verified successfully')),
        );
        // Navigate to login or home
      }
    } catch (e) {
      if (mounted) {
        LoggerService.error('VerifyEmailScreen: Verification failed', error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _handleResendCode() async {
    try {
      LoggerService.info('VerifyEmailScreen: Resending code');
      final authProvider = context.read<AuthProvider>();

      await authProvider.resendVerificationCode(email: widget.email);

      if (mounted) {
        setState(() => _resendCountdown = 60);
        LoggerService.info('VerifyEmailScreen: Code resent');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification code sent')),
        );
      }
    } catch (e) {
      if (mounted) {
        LoggerService.error('VerifyEmailScreen: Resend failed', error: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.spacing24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSizes.spacing32),

                    // Icon
                    Icon(
                      Icons.mark_email_unread,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: AppSizes.spacing24),

                    // Header
                    Text(
                      'Verify Your Email',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spacing16),
                    Text(
                      'We\'ve sent a verification code to ${widget.email}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spacing32),

                    // Code field
                    TextFormField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        labelText: 'Verification Code',
                        hintText: 'Enter 6-digit code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.numbers),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Code is required';
                        }
                        if (value!.length != 6) {
                          return 'Code must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSizes.spacing32),

                    // Verify button
                    ElevatedButton(
                      onPressed: authProvider.loadingStatus == LoadingStatus.loading
                          ? null
                          : _handleVerifyEmail,
                      child: authProvider.loadingStatus == LoadingStatus.loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Verify Email'),
                    ),
                    const SizedBox(height: AppSizes.spacing24),

                    // Resend code
                    Center(
                      child: Column(
                        children: [
                          const Text("Didn't receive the code? "),
                          TextButton(
                            onPressed: _resendCountdown > 0 ? null : _handleResendCode,
                            child: Text(
                              _resendCountdown > 0
                                  ? 'Resend in $_resendCountdown seconds'
                                  : 'Resend Code',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            );
          },
        ),
      ),
    );
  }
}
