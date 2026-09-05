import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/auth/auth_provider.dart';
import 'package:my_hrm/auth/auth_repository.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, this.token});

  final String? token;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tokenCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showPassword = false;
  bool _loading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      _tokenCtrl.text = widget.token!;
    }
  }

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
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
      final result = await repo.resetPassword(ResetPasswordRequestDto(
        token: _tokenCtrl.text.trim(),
        newPassword: _passwordCtrl.text,
      ));
      if (!mounted) return;
      setState(() => _successMessage = result);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) context.go('/login');
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
                        Icon(Icons.lock_open, color: Colors.white, size: 44),
                        SizedBox(height: 8),
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Enter your token and new password",
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
                          TextFormField(
                            controller: _tokenCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Reset Token',
                              prefixIcon: Icon(Icons.vpn_key_outlined),
                              hintText: 'Enter the token from your email',
                            ),
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Token is required.'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordCtrl,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: 'Your new password',
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () =>
                                    setState(() => _showPassword = !_showPassword),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password is required.';
                              }
                              if (v.length < 6) {
                                return 'Password must be at least 6 characters.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmCtrl,
                            obscureText: !_showPassword,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              hintText: 'Confirm your new password',
                            ),
                            validator: (v) {
                              if (v != _passwordCtrl.text) {
                                return 'Passwords do not match.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          LoadingButton(
                            label: _loading ? 'Resetting...' : 'Reset Password',
                            loading: _loading,
                            icon: Icons.check_circle,
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
