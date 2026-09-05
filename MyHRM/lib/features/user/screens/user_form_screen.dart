import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/user/providers/user_providers.dart';
import 'package:my_hrm/features/user/data/models/user.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/widgets/app_dropdown.dart';
import 'package:my_hrm/shared/enums.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  const UserFormScreen({super.key, this.userId});
  final int? userId;

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AppRole _selectedRole = AppRole.EMPLOYEE;
  bool _enabled = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    final user = await ref.read(userByIdProvider(widget.userId!).future);
    _fullNameController.text = user.fullName ?? '';
    _emailController.text = user.email ?? '';
    _selectedRole = AppRole.values.firstWhere(
      (r) => r.name == user.role,
      orElse: () => AppRole.EMPLOYEE,
    );
    _enabled = user.enabled ?? true;
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(userRepositoryProvider);
      if (widget.userId == null) {
        await repo.create(UserRequest(
          fullName: _fullNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          role: _selectedRole.name,
          enabled: _enabled,
        ));
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User saved successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.userId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit User' : 'New User'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _fullNameController,
              label: 'Full Name',
              prefixIcon: Icons.person,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _emailController,
              label: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            if (!isEdit) ...[
              AppTextField(
                controller: _passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
            ],
            AppEnumDropdown<AppRole>(
              label: 'Role',
              values: AppRole.values,
              displayName: (r) => r.displayName,
              selectedValue: _selectedRole,
              onChanged: (v) => setState(() => _selectedRole = v!),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enabled'),
              value: _enabled,
              onChanged: (v) => setState(() => _enabled = v),
            ),
            const SizedBox(height: 24),
            LoadingButton(
              label: isEdit ? 'Update' : 'Create',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
