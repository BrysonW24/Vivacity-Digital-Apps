import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_sizes.dart';
import '../../enums/loading_status.dart';
import '../../providers/auth_provider.dart';
import '../../services/logger_service.dart';

/// Delete Account Screen
///
/// Allows users to permanently delete their account.
/// Shows warnings about data deletion and requires confirmation.
/// Follows GDPR requirements for account deletion.
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  late TextEditingController _passwordController;
  bool _confirmDeletion = false;
  bool _confirmDataLoss = false;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    LoggerService.warning('DeleteAccountScreen: Initialized');
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteAccount() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_confirmDeletion || !_confirmDataLoss) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm both statements to proceed'),
        ),
      );
      return;
    }

    try {
      LoggerService.warning('DeleteAccountScreen: Attempting account deletion');
      final authProvider = context.read<AuthProvider>();

      await authProvider.deleteAccount(
        password: _passwordController.text,
      );

      if (mounted) {
        LoggerService.warning('DeleteAccountScreen: Account deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
        // Navigate to login/welcome screen
        // Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        LoggerService.error('DeleteAccountScreen: Deletion failed', error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
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
                    // Warning icon
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 64,
                      color: Colors.red[400],
                    ),
                    const SizedBox(height: AppSizes.spacing24),

                    // Title
                    Text(
                      'Delete Your Account',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spacing16),

                    // Warning message
                    Container(
                      padding: const EdgeInsets.all(AppSizes.spacing16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        border: Border.all(color: Colors.red[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'This action cannot be undone. All your data will be permanently deleted.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing32),

                    // What will be deleted
                    Text(
                      'This will delete:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing12),
                    _buildDeleteItem('Your profile and personal information'),
                    _buildDeleteItem('All your data and activity history'),
                    _buildDeleteItem('Subscriptions and payments'),
                    _buildDeleteItem('Saved preferences and settings'),
                    const SizedBox(height: AppSizes.spacing32),

                    // Password confirmation
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Your Password',
                        hintText: 'Enter your password to confirm',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Password is required to confirm deletion';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSizes.spacing24),

                    // Confirmation checkboxes
                    CheckboxListTile(
                      value: _confirmDeletion,
                      onChanged: (value) {
                        setState(() => _confirmDeletion = value ?? false);
                      },
                      title: const Text('I want to delete my account'),
                      subtitle: const Text('This is permanent'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      value: _confirmDataLoss,
                      onChanged: (value) {
                        setState(() => _confirmDataLoss = value ?? false);
                      },
                      title: const Text('I understand all data will be lost'),
                      subtitle: const Text('And cannot be recovered'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: AppSizes.spacing32),

                    // Delete button
                    ElevatedButton(
                      onPressed:
                          authProvider.loadingStatus == LoadingStatus.loading
                              ? null
                              : (_confirmDeletion && _confirmDataLoss
                              ? _handleDeleteAccount
                              : null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: authProvider.loadingStatus == LoadingStatus.loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Text('Delete Account Permanently'),
                    ),
                    const SizedBox(height: AppSizes.spacing16),

                    // Cancel button
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
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

  Widget _buildDeleteItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacing8),
      child: Row(
        children: [
          Icon(Icons.close, size: 20, color: Colors.red[400]),
          const SizedBox(width: AppSizes.spacing12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
