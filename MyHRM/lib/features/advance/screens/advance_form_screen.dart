import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/advance/providers/advance_providers.dart';
import 'package:my_hrm/features/advance/data/models/advance.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class AdvanceFormScreen extends ConsumerStatefulWidget {
  const AdvanceFormScreen({super.key});
  @override
  ConsumerState<AdvanceFormScreen> createState() => _AdvanceFormScreenState();
}

class _AdvanceFormScreenState extends ConsumerState<AdvanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(advanceRepositoryProvider);
      await repo.create(AdvanceRequest(
        employeeId: 1,
        amount: double.tryParse(_amountController.text),
        reason: _reasonController.text,
      ));
      ref.invalidate(advancesProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Advance request submitted')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Advance')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _amountController,
              label: 'Amount',
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _reasonController,
              label: 'Reason',
              prefixIcon: Icons.description,
              maxLines: 3,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            LoadingButton(
              label: 'Submit Request',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
