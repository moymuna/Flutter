import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/leave/providers/leave_providers.dart';
import 'package:my_hrm/features/leave_type/providers/leave_type_providers.dart';
import 'package:my_hrm/features/leave/data/models/leave.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class LeaveFormScreen extends ConsumerStatefulWidget {
  const LeaveFormScreen({super.key});
  @override
  ConsumerState<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends ConsumerState<LeaveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _reasonController = TextEditingController();
  final _totalDaysController = TextEditingController();
  int? _selectedLeaveTypeId;
  bool _isLoading = false;

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    _totalDaysController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(leaveRepositoryProvider);
      await repo.create(LeaveRequest(
        employeeId: 1,
        leaveTypeId: _selectedLeaveTypeId,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        reason: _reasonController.text,
        totalDays: int.tryParse(_totalDaysController.text),
      ));
      ref.invalidate(leavesProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave applied successfully')),
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
    final leaveTypesAsync = ref.watch(leaveTypesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Apply Leave')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            leaveTypesAsync.when(
              data: (types) => DropdownButtonFormField<int>(
                initialValue: _selectedLeaveTypeId,
                decoration: const InputDecoration(
                  labelText: 'Leave Type',
                  border: OutlineInputBorder(),
                ),
                items: types
                    .map((t) => DropdownMenuItem(
                          value: t.id,
                          child: Text(t.name),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedLeaveTypeId = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading leave types'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _startDateController,
              label: 'Start Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _endDateController,
              label: 'End Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _totalDaysController,
              label: 'Total Days',
              prefixIcon: Icons.numbers,
              keyboardType: TextInputType.number,
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
              label: 'Submit',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
