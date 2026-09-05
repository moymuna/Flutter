import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/leave_type/providers/leave_type_providers.dart';
import 'package:my_hrm/features/leave_type/data/models/leave_type.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class LeaveTypeFormScreen extends ConsumerStatefulWidget {
  const LeaveTypeFormScreen({super.key, this.leaveTypeId});
  final int? leaveTypeId;
  @override
  ConsumerState<LeaveTypeFormScreen> createState() => _LeaveTypeFormScreenState();
}

class _LeaveTypeFormScreenState extends ConsumerState<LeaveTypeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _daysController = TextEditingController();
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.leaveTypeId != null) _load();
  }

  Future<void> _load() async {
    final lt = await ref.read(leaveTypeByIdProvider(widget.leaveTypeId!).future);
    _nameController.text = lt.name;
    _daysController.text = lt.daysPerYear?.toString() ?? '';
    _isActive = lt.isActive ?? true;
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(leaveTypeRepositoryProvider);
      final dto = LeaveTypeRequest(
        name: _nameController.text,
        daysPerYear: int.tryParse(_daysController.text),
        isActive: _isActive,
      );
      if (widget.leaveTypeId == null) {
        await repo.create(dto);
      } else {
        await repo.update(widget.leaveTypeId!, dto);
      }
      ref.invalidate(leaveTypesProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave type saved')),
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
    final isEdit = widget.leaveTypeId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Leave Type' : 'New Leave Type')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _nameController,
              label: 'Name',
              prefixIcon: Icons.label,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _daysController,
              label: 'Days Per Year',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Active'),
              value: _isActive,
              onChanged: (v) => setState(() => _isActive = v),
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
