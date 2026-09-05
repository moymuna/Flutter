import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/auth/auth_provider.dart';
import 'package:my_hrm/auth/auth_repository.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.forgotPassword(
        ForgotPasswordRequestDto(email: _emailCtrl.text.trim()),
      );
      if (!mounted) return;
      setState(() => _successMessage = result);
    } catch (e) {
      setState(() => _errorMessage = apiErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    color: AppColors.primary,
                    child: const Column(
                      children: [
                        Icon(Icons.lock_reset, color: Colors.white, size: 44),
                        SizedBox(height: 8),
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Enter your email to receive a reset link",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_errorMessage != null)
                            ErrorBanner(message: _errorMessage!),
                          if (_successMessage != null)
                            SuccessBanner(message: _successMessage!),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'you@example.com',
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Enter your email.';
                              }
                              if (!v.contains('@')) return 'Enter a valid email.';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          LoadingButton(
                            label: _loading ? 'Sending...' : 'Send Reset Link',
                            loading: _loading,
                            icon: Icons.send,
                            onPressed: _submit,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => context.go('/login'),
                            child: const Text('Back to Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
